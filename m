Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1A7C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BCC020708
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pEPzqBVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BCC020708
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW09P-0005qK-VU
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVzW1-0008QB-Rj; Fri, 23 Oct 2020 12:02:06 -0400
Received: from mail-eopbgr80103.outbound.protection.outlook.com
 ([40.107.8.103]:31254 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVzVy-00063v-1x; Fri, 23 Oct 2020 12:02:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAdDHy17m6hiVGVMLTwwhPqGrNoEsovPSxA0W+3LLTJfdq9/lo2ZuIYIFDupRnuYEPuDcSI9wgYkZZyckVEi9R3X7eF/XB/xmX986qT3T3Dc77Qqg3siS6JAZ5BdOZ3JeVUSG8XHFQu/4q0q8LjziW9rylYjBE8We3objza8rLN3mbMk99CsTOVFI9WioVbLpidRXctTLpoq/FEBC0x/MXoN6I/v+kDHzoCmarPOcRCfyCGlEzpkBAUR6Qav8GslScOvXOnUWwbsc24PD0o/qQtyWOC8Ynpp/bYVA9e4LrfWeVvzGyBK8TQe6kGzdWgA+UniCi7yfekniGrjigmrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hQksKeah2AUeRF2K4ZkdKqsU7yubfflK7il9FGNofE=;
 b=HHgOp1RMzEbGZN85LjB2E901ZXeWSQ1PUCwQUKLnE59QJFqlM0VJeAxqYvZT9maJJNl0stA77sT7IzlxsQRmfl1qtqySZMo4fCiyyy/g9JBOvMUrxWLoJ/qRp1fP0wxedq31hN/xmraKEfdCiI0TObhdz532m5B+GyyqgsTTjGOYzdEXRfIvJpKRok1BugewWqZXexm8qdxmZBFErqJ660FBeGpnORHYBPv3wqWuhvBn1zcrtsZJkktO1T3G8TFjBq+AltwX+C9ekG7D2L5OTAVSbMBUon9pJWdrxiELatip/AoB5YSsfh/jwFg//4veNUDm7htAR97tmqJM5GiARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hQksKeah2AUeRF2K4ZkdKqsU7yubfflK7il9FGNofE=;
 b=pEPzqBVCIqU8h0h7VTW9avbE1q1hfJECs6r68YO57dVAU1Ja5MiZK0QaA99+0ecC2Li2qXa8DcN8kX5DQxzzGGT+Gr8AQ5SUROZHc7O23PMDGSIxqqKepqwHYivQ/G7J1M5YdOPrFAwRb9icJUCqFzOUtOXdz/rgrMe+pxfbwhQ=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4600.eurprd08.prod.outlook.com (2603:10a6:20b:84::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Fri, 23 Oct
 2020 16:01:57 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 16:01:56 +0000
Subject: Re: [PATCH v12 06/14] copy-on-read: pass bottom node name to COR
 driver
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <5cb6baa3-3035-9b50-3e45-a2a48bc8fdd6@virtuozzo.com>
 <96d5d3b8-8334-3900-7085-6fd7aeb8190b@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8c2911f0-8381-9a32-3e21-5d48b6c246fc@virtuozzo.com>
Date: Fri, 23 Oct 2020 19:01:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <96d5d3b8-8334-3900-7085-6fd7aeb8190b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.98]
X-ClientProxiedBy: AM4PR0101CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::35) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.98) by
 AM4PR0101CA0067.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 23 Oct 2020 16:01:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bff62755-aca9-4ebf-ddec-08d8776cf79d
X-MS-TrafficTypeDiagnostic: AM6PR08MB4600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB460026C694F495B6CFA4B888C11A0@AM6PR08MB4600.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d86MjgNhgOdiFmdsBTONFM3LB+kJyDCio2u9wvRsg8Y8Yb3h7GivxPO3b7F3dxN5dMhVrFZ2MYxp1br1TOxxN7eFpz4n1jZCyIA/V9rjO3oRsDzsQqHEwTlUTOU58LfUyyg0bOylIoh0ePgXWj7gRxHLbZYfJ5MHtwsG5oQ/suAhQC1LGUL4vY7wCYqG3z2k4zVW46YDUv/b8V0iwcumLRD19B1wRnrUuxuAoAyyb9twsDs9igbRQ6vu5obb/i0yp+HkI0B4In/ift9A0LfMNV+59Zb4+B/cHdgB7FSL+CLylQkpO/KKr8A/CmBrVQyKl1o45DS3E/82ZjHOr/XK/71MWkaW1m10y4Y0FgXbdFLjMNsw5yEziD1oOnUhc69J
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(39830400003)(396003)(6486002)(66476007)(36756003)(5660300002)(956004)(66556008)(4326008)(2906002)(66946007)(86362001)(16526019)(53546011)(52116002)(8936002)(478600001)(31696002)(26005)(16576012)(186003)(31686004)(316002)(2616005)(8676002)(83380400001)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: nCGDpHKu1Y6QzPnZAByZAFuO3zuGjpFeAc45sx0304TYseu06e+3Xd3G4vbU1OeSnUF0KmCzDh8SmVK6LV7VRsm+XTrJ1HYcceT1EJZLCKk4gPd/15fqO3dzgyLlVDMQ0teLf3hU8zydD7V6wjHMSTNGenGTKCZ9MgFdX0QkVhlTtSExqJBekFXCqQZoaFONol7o/5g60tlq0ED4mbT6rFi0geGgVfE6548bmaMQL73PRPspq0tLI9eBqdkiYdJ3x8z0lXl4MiBGuICOOn/5A3sRKodRCU43oL2EH2vYI+N9Of5Cp7mxiVWxcsPIRId469C4yuHgJsEBNNxglueUBtm3HVpgqAkr3Xy2Eu6R6S+9CXtW8b4uuakUOhfoLY8YwrNiv9p49DXhomroBRDhN4iZoVYDXMfuYYckqmgUmJKH9jDQpHiJlsz4iOxT74qKJRnAW2PfYDJX4s7WHhcV4KWhKZ3ZcK418G6A4xNvLMxQv4KlSOCm0sp/xs/Gse6NOSXKcxCzyUArtKK/2jFne9i6prt7W2tVk+EIpB5pLtRN108CvNoWXq3b4qOG1eiJnQPnjHQDDYJZiz1kiY+h8R/9nrZx7ZJ39LLiU0njkjUZwg30Bho8YpvdL9cm2dbPMUVtsC4l10wQLqP29OtxPA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff62755-aca9-4ebf-ddec-08d8776cf79d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 16:01:56.8392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VR4Zk9UU9InMhrqsjoykaMA4sCOuhU6bdTJ6ln2IiwV9u/GGvxy7SUfk6Nh+kg82argd4LptsPuuZv2ikvz5lOAkKyPZd8TJM8eNSOmytL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4600
Received-SPF: pass client-ip=40.107.8.103;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 12:01:58
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001,
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

23.10.2020 18:31, Andrey Shinkevich wrote:
> 
> On 23.10.2020 17:45, Vladimir Sementsov-Ogievskiy wrote:
>> 22.10.2020 21:13, Andrey Shinkevich wrote:
>>> We are going to use the COR-filter for a block-stream job.
>>> To limit COR operations by the base node in the backing chain during
>>> stream job, pass the bottom node name, that is the first non-filter
>>> overlay of the base, to the copy-on-read driver as the base node itself
>>> may change due to possible concurrent jobs.
>>> The rest of the functionality will be implemented in the patch that
>>> follows.
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   block/copy-on-read.c | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>>> index 618c4c4..3d8e4db 100644
>>> --- a/block/copy-on-read.c
>>> +++ b/block/copy-on-read.c
>>> @@ -24,18 +24,24 @@
>>>   #include "block/block_int.h"
>>>   #include "qemu/module.h"
>>>   #include "qapi/error.h"
>>> +#include "qapi/qmp/qerror.h"
>>> +#include "qapi/qmp/qdict.h"
>>>   #include "block/copy-on-read.h"
>>>   typedef struct BDRVStateCOR {
>>>       bool active;
>>> +    BlockDriverState *bottom_bs;
>>>   } BDRVStateCOR;
>>>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>>                       Error **errp)
>>>   {
>>> +    BlockDriverState *bottom_bs = NULL;
>>>       BDRVStateCOR *state = bs->opaque;
>>> +    /* Find a bottom node name, if any */
>>> +    const char *bottom_node = qdict_get_try_str(options, "bottom");
>>>       bs->file = bdrv_open_child(NULL, options, "file", bs, &child_of_bds,
>>>                                  BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
>>> @@ -51,7 +57,17 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>>>               bs->file->bs->supported_zero_flags);
>>> +    if (bottom_node) {
>>> +        bottom_bs = bdrv_lookup_bs(NULL, bottom_node, errp);
>>> +        if (!bottom_bs) {
>>> +            error_setg(errp, QERR_BASE_NOT_FOUND, bottom_node);
>>
>> QERR_BASE_NOT_FOUND is unrelated here. Also, I see a comment in qerror.h that such macros should not be used in new code. And don't forget to drop qerror.h include line.
>>
> 
> I have been surprized because I don't have it in my branch and instead I do:
> error_setg(errp, "Bottom node '%s' not found", bottom_node);

OK, with it:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> 
>>> +            qdict_del(options, "bottom");
>>
>> this may be moved above "bottom_bs = ..", to not call it after "if" in separate.
>>
> 
> Please, see the "Re: [PATCH v11 04/13] copy-on-read: pass overlay base node name to COR driver".

Hm, assume that it may free the string itself, OK then.

> 
>>> +            return -EINVAL;
>>> +        }
>>> +        qdict_del(options, "bottom");
>>> +    }
>>>       state->active = true;
>>> +    state->bottom_bs = bottom_bs;
>>>       /*
>>>        * We don't need to call bdrv_child_refresh_perms() now as the permissions
>>>
>>
>>


-- 
Best regards,
Vladimir

