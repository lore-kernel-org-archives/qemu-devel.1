Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6911AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:27:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EFFA20B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QlOMM+8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFFA20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjd6-0004oy-6v
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSjKn-0006eE-KO; Wed, 14 Oct 2020 12:09:01 -0400
Received: from mail-eopbgr80109.outbound.protection.outlook.com
 ([40.107.8.109]:53646 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kSjKj-00025q-LQ; Wed, 14 Oct 2020 12:09:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiIVwTZO734DSdA1ffoD+Sdl3llJssIN1O1My09Mu9K72sjx0ZpQGPsh0q6m522oj83yIM1MNUJcxwDUhu27rMsEf/3S0CSAKM9jf5qppslhynzZk6z/3ULXCWecNfo7RtZBSbQ9xA27ZKrSlTbP5fXWmuU4mdGMTnCTs9HtsXyoz+WdRLryJaLWRO3k4t8JMRcIxpQqVBbARVItAHoYO47ieKMBgTfwpp1cMIq6sqnDhQxUCwxK17yYs7fHb1YEe3XYrigRaJGkn7r0HA98kQWDx15+AkPTIGCj32EPL3Lbcz/Cihra09HtT2kKGRK78hAg4vtyRbg8UGmcIB0RPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU2ZbF/dCBIwBsq/MVZMVPb2bNeYvKK/IT8c+Z34w0U=;
 b=lH09FdZPov2RpibcY9ymdujet7nKf3r2uLdccZM43lC9/SDa1DubRtBDNCiCqC38sKdcregOq6MrbJ3KaQPlQX97XNuOZRTVmFr299L+f12dwmGdeiSwSFdWLDKn0pSsNwo5nrOoiW3lMw0l1cOQUwsu6vSAPIQVf8Erc1TsI2yQUhtqRr9jdS2ZEBCUAOQYDCVc4MBqg/XHsbSnyqZzva36nInNS7o6dyXlUug6L8Zky/s98siocd0uU47YpwoNXRLFfd+Vwll88dd8DO/gODADXLNhoY0BlDmNOrxBdbFhZzew6GZ4TOKZ+RG7/fU9lVoDWdcdKWIiEqRCix5CgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU2ZbF/dCBIwBsq/MVZMVPb2bNeYvKK/IT8c+Z34w0U=;
 b=QlOMM+8O0jw5bHPOFHjJEujGa/XibZ24NE3FPEgMDUhvorMOVN1RlrACTrBW30ZAamNV7DvE5HmXQgptedm/zGGAyrAOntVRl3iX6z3v5PLIaqfHBmiZ/IZwrHCyD3Uu7JnSIg9NoP62uYrbyK6Tc6iO00Mee1Mfl/P32v7ZW7g=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2618.eurprd08.prod.outlook.com (2603:10a6:3:d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Wed, 14 Oct
 2020 16:08:52 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 16:08:52 +0000
Subject: Re: [PATCH v11 04/13] copy-on-read: pass overlay base node name to
 COR driver
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org,
 vsementsov@virtuozzo.com
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-5-git-send-email-andrey.shinkevich@virtuozzo.com>
 <3c6699f3-e061-c2ae-c5e9-a12660405624@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <89965a42-cee0-a98c-f97a-a03b5d834418@virtuozzo.com>
Date: Wed, 14 Oct 2020 19:08:49 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <3c6699f3-e061-c2ae-c5e9-a12660405624@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM4PR0101CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::35) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4PR0101CA0067.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Wed, 14 Oct 2020 16:08:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1de7a8db-a70d-4769-8eb3-08d8705b7176
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2618128FEC88B913818C12A9F4050@HE1PR0802MB2618.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GWpPwwiQhN7FBt/L0OH0795I7WV7FSEGz17C8C2gdRfWqzzbARegs8Rov4P6U1kpub5B+FIzd7RleqR9LkAKcidADGxuoVoRD7XitOEy5IyybHGV3zfvN7ZN/ldYXlUgwTxawW3lODC+iTNLtOf9NZGKEusqivBqemqvGI/vTaAvvnghKw3jx/pHq3fgHJiJ0X1iqZXSO/AznOTczGlromLVoG195bltalqynu4Kj9xif4OsK+wtnhb5IhnNu3Mx6ne7QAZF51pdQ25ZYhhS3NnarcYyR1hlKz3dVoKyCdX1pVfLzwXLNw+Bj85lJs5vU1y0J/ceuAfwgo+sy7rAqbZnJy2tl65Lbp5GyN7Zwz77una5VW5mhUtWS7nytGXb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39830400003)(396003)(136003)(366004)(376002)(346002)(2616005)(107886003)(66946007)(66476007)(4326008)(44832011)(8936002)(186003)(66556008)(7416002)(6512007)(16526019)(8676002)(6506007)(31686004)(478600001)(53546011)(36756003)(86362001)(52116002)(5660300002)(956004)(31696002)(2906002)(316002)(83380400001)(6486002)(26005)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: n0gprXQ0YAYapq+QjTZLS6psoWa7ylTPyJT+HzMJOeVhH4mjfmIrEymdDMMyKkt9MG/AzsQtNICkJVLpeiGY1VFiXFUXmJDtbHG0KlUzY5YGst1pVWuvOkna73QxKglB0NuIhLSUQBXNgX0IeL1TrOB9aNt+cmDGhbi31Jk1huds0pex0hxq1Sru9+omxRFB/EVRFgdiWLxajy0Efw0C9pIHLo6Z+x3crQIey2WQrSeEMHOHqNwLIPcKEb2/prK1e68t8CFcOnasiRYUEThvE51aNygUG+Uwt4J43Fn+KQ5IBNOzlJeMx2zImiysOIebSSkIavEKh5jbZLaKz5spgXl2diGqSLIGMsx88B4ORw2WxqfpPctbqbcsHOta4b/A/P5ysnVHJgveU9LfZS7dyi4ym96WO0D9ipE4FFrI4XcI+SuN2Rk9AhtGm+vYydKZlwzcIfgWb3EjHckYLPLlmZnB8HoCI0azHhdjQ5adXmZd9glnLbBvHQFDebmXxw+I0Hg68E0uY60Jecdm/7w430HKFwwpfHE9EyY/Y9BpT14DdnTiyKvVLsqqgBIlSPPgjqWjAe8YJlFFFINuFYUIPZRa1mnZPZ0Nse3irDRUN7gTBPD6m2EWeGfUwhyvwOcua1IDoWOTGnJMLooZUKJJVg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de7a8db-a70d-4769-8eb3-08d8705b7176
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 16:08:52.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSdaOeoUgPRPgu8rB/1FEmSmP+wRYQ/40X2IJS9XIGB9k9/lw/sWRAvudhLBJg381vIZe9YDs7Nsuo34eqyT22fI8Bg6+/3MABMCcdZTro0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2618
Received-SPF: pass client-ip=40.107.8.109;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 12:08:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14.10.2020 14:09, Max Reitz wrote:
> On 12.10.20 19:43, Andrey Shinkevich wrote:
>> We are going to use the COR-filter for a block-stream job.
>> To limit COR operations by the base node in the backing chain during
>> stream job, pass the name of overlay base node to the copy-on-read
>> driver as base node itself may change due to possible concurrent jobs.
>> The rest of the functionality will be implemented in the patch that
>> follows.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
> 
> Is there a reason why you didn’t add this option to QAPI (as part of a
> yet-to-be-created BlockdevOptionsCor)?  Because I’d really like it there.
> 

I agree that passing a base overlay under the base option looks clumsy. 
We could pass the base node name and find its overlay ourselves here in 
cor_open(). In that case, we can use the existing QAPI.
The reason I used the existing QAPI is to make it easier for a user to 
operate with the traditional options and to keep things simple. So, the 
user shouldn't think what overlay or above-base node to pass.
If we introduce the specific BlockdevOptionsCor, what other options may 
come with?

>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index bcccf0f..c578b1b 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -24,19 +24,24 @@
>>   #include "block/block_int.h"
>>   #include "qemu/module.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qmp/qerror.h"
>>   #include "qapi/qmp/qdict.h"
>>   #include "block/copy-on-read.h"
>>   
>>   
>>   typedef struct BDRVStateCOR {
>>       bool active;
>> +    BlockDriverState *base_overlay;
>>   } BDRVStateCOR;
>>   
>>   
>>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>                       Error **errp)
>>   {
>> +    BlockDriverState *base_overlay = NULL;
>>       BDRVStateCOR *state = bs->opaque;
>> +    /* We need the base overlay node rather than the base itself */
>> +    const char *base_overlay_node = qdict_get_try_str(options, "base");
> 
> Shouldn’t it be called base-overlay or above-base then?
> 

The base_overlay identifier is used below as the pointer to BS. The 
base_overlay_node stands for the name of the node. I used that 
identifier to differ between the types. And the above_base has another 
meaning per block/stream.c - it can be a temporary filter with a JSON-name.

>>   
>>       bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>>                                  BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
>> @@ -52,7 +57,16 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>>               bs->file->bs->supported_zero_flags);
>>   
>> +    if (base_overlay_node) {
>> +        qdict_del(options, "base");
>> +        base_overlay = bdrv_lookup_bs(NULL, base_overlay_node, errp);
> 
> I think this is a use-after-free.  The storage @base_overlay_node points
> to belongs to a QString, which is referenced only by @options; so
> deleting that element of @options should free that string.
> 
> Max
> 

I will swap those two function calls (bdrv_lookup_bs(); qdict_del();).
Thank you.

Andrey

>> +        if (!base_overlay) {
>> +            error_setg(errp, QERR_BASE_NOT_FOUND, base_overlay_node);
>> +            return -EINVAL;
>> +        }
>> +    }
>>       state->active = true;
>> +    state->base_overlay = base_overlay;
>>   
>>       /*
>>        * We don't need to call bdrv_child_refresh_perms() now as the permissions
>>
> 
> 

