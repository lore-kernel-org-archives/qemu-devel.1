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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8565C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FED621D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pO55zZ+i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FED621D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzmO-0006Iz-Ge
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVz33-0001K8-3n; Fri, 23 Oct 2020 11:32:09 -0400
Received: from mail-eopbgr70095.outbound.protection.outlook.com
 ([40.107.7.95]:25942 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVz2z-00025m-37; Fri, 23 Oct 2020 11:32:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOHxIviZViEUcpZETc9ZFL/qDi4evZVimnsIu4QqeP3v+QNCn4z2p3bVi0olu41q/6Hu3o+1wcbJLf9lspgPXpNkaBoprhz01skhR8mr8+xzX7yJRv5Ez8mHSK9XLUVR/K6kl9tvHJj1m+udSFLm96nsYTolIP9pE9LU0hp2f1EMyo/fXxUn1m/Cavn8yh0XoyVmCVzKUwiuJRF+jkCZjdatjH59ZPWnB0Juqv/hgThChTdBToFaXkgOQD3VeQ0v9H7hj9nTDcveJYp3oz3/tjSBaMOnbmrTUaEANuvwIdDoWO0+SZTJvoBdQQ+eZ2h8b+oYphQg4pUBQfUpY6En5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2k8lsFqu1NIJgX1u3xZfhrPhgL6UIq2prCEy3k9a+w=;
 b=UAZHwxF1pCDCaTxinj8IQakLDV+D4gg2cDBdUH7yaGwKhmd4e4SYjNjYl2wI5fcSJ+5v8rRBwil6kXZJ8EmbZ6Pkf1Q4NpJW/TgPRecQ49tGiWnWH1HOJ16z+YOKVg2VdGfY5MZCZvKT+rTLpSbrDZpOW0Ayq68C6Vlp8b61Q54ME6dn35Try8ejA8vHrzHxjLJN52CcstEsXs08JKnTfnNZbrc1f4HnBfaoN/TBQmJI042HlZ3XcouCpjItcHODxwehcDzFTCqBp7HDM9FHGBXoGWFs6Vj9+aASNZSD/1+QvvWOgyVb6fCOdPMBbbZofcDXQLkD6rgNSgSSRfKdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2k8lsFqu1NIJgX1u3xZfhrPhgL6UIq2prCEy3k9a+w=;
 b=pO55zZ+i5/2zH/zHIYP579KVQ+vtBIssC92o5ppvDfS4pIOyJy0hT31vvtLMSq+SbX/fm63z5tZUoxNlWMEIlSJlkIS2R4QqCYv0PU2ZdAPQdvxu3yklrb8MJrfAxsRsboXkj//LHErgdE+n2Rzn9vzu7TWkxAV2KzZxlP1Viw8=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2650.eurprd08.prod.outlook.com (2603:10a6:7:2d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 23 Oct
 2020 15:31:58 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.028; Fri, 23 Oct 2020
 15:31:57 +0000
Subject: Re: [PATCH v12 06/14] copy-on-read: pass bottom node name to COR
 driver
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <5cb6baa3-3035-9b50-3e45-a2a48bc8fdd6@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <96d5d3b8-8334-3900-7085-6fd7aeb8190b@virtuozzo.com>
Date: Fri, 23 Oct 2020 18:31:54 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <5cb6baa3-3035-9b50-3e45-a2a48bc8fdd6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::8) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 FR2P281CA0021.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7 via Frontend Transport; Fri, 23 Oct 2020 15:31:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03a46ae5-59ec-4932-9ff2-08d87768c73b
X-MS-TrafficTypeDiagnostic: HE1PR08MB2650:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2650DBD3AD4DFF7C62312769F41A0@HE1PR08MB2650.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAFtnL8MKkDATazQZhQbh5xgKNwhLDs/SiXD4o8WNpP5x764Y1XzUhTua16tDr03ZWm7LSslUuVfeTmVh3JBIex46jctQPUAIIWyQStYFhjeLGRyHYrH/NQAPzZeqIy7sy35DNkWtc0c06jkSAAZMqTwgc7cc42v7Rgk0YVzFSrP9dFfoLxZwCoFfqWY3HWBHo3LedoEqhOOb6pVi2eR0BMtbYmBL03V1QIzsbuW6JvxyIixfsb8+NmgcfnTyVovxyZWqOTOJrwlkZ5VKtxrYmi5n8x3NTpAFEQy/SjucB40FRDLvSPZka2BwrWGer9a4bqn9+cErqx7wMVReTerJ5eDmE30MlZ76TxTVl6ko981/NLBJ5BdXBDQGqiC9Bzi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(396003)(366004)(346002)(136003)(376002)(186003)(16526019)(6506007)(53546011)(478600001)(5660300002)(6486002)(52116002)(83380400001)(2906002)(4326008)(107886003)(8936002)(36756003)(6512007)(26005)(31686004)(66946007)(66476007)(66556008)(44832011)(8676002)(86362001)(31696002)(2616005)(956004)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: B+96EQTM1QrMCLh5JCdvNT7/1+uSu6PpPfGF/cnEQj/OVwNk+HupnRziE2dS1ojI/yI4RaEzkOJJg4+StjKA4ylhCvX2FFPitJlHt0pOHR09ajCFYrZVlv5CvFw+iJ7Ah5ixMTTV2cAZ+BDmndxejmlBde4V3XvZSFVQG6/J7be5Mq9htEMOKkOy587RukIWBHAZHfujp/r12qUJRfesLNsa+2U5g9CPflNqKsocoTDokoclPNjS2+n/TsP9ObOy6/czYNQEql7++hEoWIooisrJjqyRFt6gOSOrhkkFb1xEM4XaG1u2/k6UGAnC1dahfBckQSbCM0GK3c8BsEz+zVwucjrbAYnNFOQVylHTEf65q0TGE9WX24eybG88AseiG1ksvUDNot7pXMehBEzg3JpO3f6IGssLTpuksxWttTb1J/00dxGdV8lI6aaEVtGNTSrINnWJMxZ7Hi74UAPYtr2U6HuSjrCdiMpU0gjosoe6lUqzFU4fLJI6MN7Bu/Ay92G//2qm4JIS2matCqA+uVSFV6cW7RGXvoBdhUF+vHAW/XkZ1VamElSvPQBFg3NjSkxMhdWGU5ih1+yKjXjZCZkqKV3UU8viQYydoDrzt9LvR4mOolDRO9LiKhm1NV7qXOWXCS2t6WjNeBY56+ltew==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a46ae5-59ec-4932-9ff2-08d87768c73b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 15:31:57.7771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmjarV9nfieVyg74t6vP8MLJn6vym4Gc1PegbXpid8P6Rj80jL2yD8EQxwHDyT4Mn183mOGY7DAYNAW6NAwmKdalsckZHnqwXRrWaEAu1/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2650
Received-SPF: pass client-ip=40.107.7.95;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:32:01
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_LOW=-0.7,
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


On 23.10.2020 17:45, Vladimir Sementsov-Ogievskiy wrote:
> 22.10.2020 21:13, Andrey Shinkevich wrote:
>> We are going to use the COR-filter for a block-stream job.
>> To limit COR operations by the base node in the backing chain during
>> stream job, pass the bottom node name, that is the first non-filter
>> overlay of the base, to the copy-on-read driver as the base node itself
>> may change due to possible concurrent jobs.
>> The rest of the functionality will be implemented in the patch that
>> follows.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/copy-on-read.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/block/copy-on-read.c b/block/copy-on-read.c
>> index 618c4c4..3d8e4db 100644
>> --- a/block/copy-on-read.c
>> +++ b/block/copy-on-read.c
>> @@ -24,18 +24,24 @@
>>   #include "block/block_int.h"
>>   #include "qemu/module.h"
>>   #include "qapi/error.h"
>> +#include "qapi/qmp/qerror.h"
>> +#include "qapi/qmp/qdict.h"
>>   #include "block/copy-on-read.h"
>>   typedef struct BDRVStateCOR {
>>       bool active;
>> +    BlockDriverState *bottom_bs;
>>   } BDRVStateCOR;
>>   static int cor_open(BlockDriverState *bs, QDict *options, int flags,
>>                       Error **errp)
>>   {
>> +    BlockDriverState *bottom_bs = NULL;
>>       BDRVStateCOR *state = bs->opaque;
>> +    /* Find a bottom node name, if any */
>> +    const char *bottom_node = qdict_get_try_str(options, "bottom");
>>       bs->file = bdrv_open_child(NULL, options, "file", bs, 
>> &child_of_bds,
>>                                  BDRV_CHILD_FILTERED | 
>> BDRV_CHILD_PRIMARY,
>> @@ -51,7 +57,17 @@ static int cor_open(BlockDriverState *bs, QDict 
>> *options, int flags,
>>           ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
>>               bs->file->bs->supported_zero_flags);
>> +    if (bottom_node) {
>> +        bottom_bs = bdrv_lookup_bs(NULL, bottom_node, errp);
>> +        if (!bottom_bs) {
>> +            error_setg(errp, QERR_BASE_NOT_FOUND, bottom_node);
> 
> QERR_BASE_NOT_FOUND is unrelated here. Also, I see a comment in qerror.h 
> that such macros should not be used in new code. And don't forget to 
> drop qerror.h include line.
> 

I have been surprized because I don't have it in my branch and instead I do:
error_setg(errp, "Bottom node '%s' not found", bottom_node);

>> +            qdict_del(options, "bottom");
> 
> this may be moved above "bottom_bs = ..", to not call it after "if" in 
> separate.
> 

Please, see the "Re: [PATCH v11 04/13] copy-on-read: pass overlay base 
node name to COR driver".

>> +            return -EINVAL;
>> +        }
>> +        qdict_del(options, "bottom");
>> +    }
>>       state->active = true;
>> +    state->bottom_bs = bottom_bs;
>>       /*
>>        * We don't need to call bdrv_child_refresh_perms() now as the 
>> permissions
>>
> 
> 

