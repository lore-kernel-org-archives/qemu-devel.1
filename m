Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A24C388F7
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6A52084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="SYqCixcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6A52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc56R-0004eq-50
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:12:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc55I-0004DS-W4; Mon, 09 Nov 2020 06:11:41 -0500
Received: from mail-eopbgr150123.outbound.protection.outlook.com
 ([40.107.15.123]:8518 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kc55F-0008D6-R8; Mon, 09 Nov 2020 06:11:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSMVog2EZw7kG+xpkEwPk7iwrWchERLhTvzLC7Qb7xvezdHmysqD1cCEXWcVK5TD2hFFDxVbqieqF3ROdcCcSBeAdzFcEMG8fbcHc6vZH5Rld24PIsCM7yiQi9+DCqu2b0h+k6sGF3NLwB5sBm3ISVhKbbH/Bh9GKUUexYNGfrl/0UmbfJGwycHR3jK8mMv0gnACxlg45pxYYs1MsCiIklxWH7srbMRRg4MNAepFvPhZioWEJn40+v+1DOWTwBTaVSeS85pRp/D7WJyNrhrx2W7ZSFXCHRp82TPkMsB0LS5ALasWNk91ADMbvk+iRWZ/if9ZcrnR5Qaje0Rf3/gYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS8/j/Ci/KWo0nP+qtdhdkl8Nu5ZIXxxdgETM+nzJ30=;
 b=A0qciW30FpJw7vxnxyZ+oxbi/RbJXURkpSg8Krdnv2PHPDtuDXteTUc0tabf2IemX3LatcjYwfmgHAlS/gpeDkX8AkrbNPrOk69/VgH/94Bp/fVb0h2tO2cBUT2VUbFdNGKbVY/riFfjmkcJ4HicczKFys6/qSaiz3mLp9rts11NgUuJv45z5ejnKXF47FzYXENIBEFCr4StoGLHE+PoLBmuTYgbzpYZbG1le4F68HI6vWcyOkS6nCZGFCKCyafzsKE06TJHsLGdh94NuGEcYGPfno3VFJ3oIt2MEBugMbrT9/FqlBNICkEOaIiBSBt9IElUKUUcpBhqtvE5nTnPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GS8/j/Ci/KWo0nP+qtdhdkl8Nu5ZIXxxdgETM+nzJ30=;
 b=SYqCixczzrA3amk8A078/r/ogwYqydDmWcqpaoUWitUUFuVeLSqPSBnljGyOEUJhP2szMI0aw8DBDWmWKgPow+dJJAIsgnCLcVDNc2mT+qVT00dyiqZVauFAbWAlEBZplonC0HROt1+WX9tA/XcW38CcY6QvKPMo+8IZkSokHlI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AS8PR08MB5910.eurprd08.prod.outlook.com (2603:10a6:20b:296::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 11:11:33 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 11:11:33 +0000
Subject: Re: [PATCH v2 11/20] qapi: backup: add x-max-chunk and x-max-workers
 parameters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, wencongyang2@huawei.com,
 xiechanglong.d@gmail.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, den@openvz.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-12-vsementsov@virtuozzo.com>
 <2117c54a-c9b3-59c6-c0b2-9fd84cb965b6@redhat.com>
 <b0334bde-2e84-9833-8228-a578dc064e32@virtuozzo.com>
 <f9aa552a-3de7-662b-3797-03959163d971@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <6ce52002-0178-d6ed-eac2-9a91d2847337@virtuozzo.com>
Date: Mon, 9 Nov 2020 14:11:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <f9aa552a-3de7-662b-3797-03959163d971@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [185.215.60.85]
X-ClientProxiedBy: FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21)
 To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.85) by
 FRYP281CA0011.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 11:11:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ae42c6a-324b-4996-6183-08d884a037ab
X-MS-TrafficTypeDiagnostic: AS8PR08MB5910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR08MB59104DE9D4ECC6966774B0DAC1EA0@AS8PR08MB5910.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6fq467uE/Zl6g7go+F/39RkRyXRciNQgfkFFfotRAHXdmVtHLJQb0sw3DScb+1a5zRLhjhWWd9Wi96Czbtf6j5G6ii4p8CEnF2/jKaDYZkqq8r+lGzVEDgZLu/ElLLV2vncDg1oT1KoY3mIn6NAKN9D8asnI3GeNR8u7jm4Sc4+VJemGRVAi6vZATPucvZQbo0WquYkMMxrGLJchr8zcxTXW/3QHv1ILAu18ynA/o1H4JaX/kEupJLCJ/ZLAwATWDF2hhj/ujX/+uV0awLH6nsN1AaOUU2IHkVn+PfUiVIZ58xa1lPLvWC1qrQMVFcZ1ddNSyM4gjx5x5fsQoQtILnz9fwrbM3YPcLqahX5/0FynXrYuv+bsNogejDz46Su
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(136003)(39840400004)(376002)(52116002)(83380400001)(53546011)(26005)(16526019)(186003)(36756003)(66946007)(956004)(5660300002)(2616005)(66556008)(31686004)(66476007)(2906002)(8936002)(16576012)(478600001)(316002)(8676002)(86362001)(4326008)(6486002)(31696002)(107886003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EOvScqt8jZBZZKjOPixl1N/a0kByU/mHfOGx5EFHBVZE8Oc1WXEtCH5nz/pdMkd53Ne5UIcShkwlo7LDvmCFtTZygFL38ZSdgfQPQGR0dV+4T1nYF0Ucx0QcI2jpTQddPICq45iaUivLYYLyZniABj33FvbVM7FIimc2CYHvGB+qLRg/C3b8PvwdWXmq7Q3YDbSecYhCc0BI0dDKYgnGVg6pjAoMvlA4wywYmLTP5r0sGa2CsKTsZCrdUd+RQ7MzgH+43/L+ogM1pNqGoQVgYXTSLf9u9xM3BoMpFSJv/NDQC5Sa6XvwU2808V6bUE+nFzBxljTLumXIekQ6npn1yYU9Ysu3SFHoTyfQK1kqcErfastpuEvU5KmjPNmwiCltYxf/YdBXjQLGtXmM+p8Fo79PaCLgApDI7tD4Wh/bLLxB7X1sbfiHQxIz8Uj+EyBAbd/wBKPX52em7lQyYytsdnQPcIBskvA0cl81F30CNbT8pvx9/kM+GFsyHrMsRFo9/XuyNXATL2gbAGETGo3NSUmkmRf6pd35XRJNTO0or1b759oZLHPYOxs+MXXgxS3/YagwiBejjz9f9tsB1Z6WRs3gsBNsRipSRRZsZqQDz5X5lVOl0OtFxjZfarvRRWj2/pbL0BzNl5cyT/CUfSBLog==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae42c6a-324b-4996-6183-08d884a037ab
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 11:11:33.7891 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs18q/wsKkeosvpnMkAyCON0DCwY70wqGrozt/tyPloC6Hteo9WUPvJCDx62hNWz5e2InhphOoqMaDNPmR25n/owDYcBVPbf0tYHpW1gnGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5910
Received-SPF: pass client-ip=40.107.15.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 06:11:35
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

04.11.2020 20:19, Max Reitz wrote:
> On 22.10.20 22:35, Vladimir Sementsov-Ogievskiy wrote:
>> 22.07.2020 15:22, Max Reitz wrote:
>>> On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add new parameters to configure future backup features. The patch
>>>> doesn't introduce aio backup requests (so we actually have only one
>>>> worker) neither requests larger than one cluster. Still, formally we
>>>> satisfy these maximums anyway, so add the parameters now, to facilitate
>>>> further patch which will really change backup job behavior.
>>>>
>>>> Options are added with x- prefixes, as the only use for them are some
>>>> very conservative iotests which will be updated soon.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>    qapi/block-core.json      |  9 ++++++++-
>>>>    include/block/block_int.h |  7 +++++++
>>>>    block/backup.c            | 21 +++++++++++++++++++++
>>>>    block/replication.c       |  2 +-
>>>>    blockdev.c                |  5 +++++
>>>>    5 files changed, 42 insertions(+), 2 deletions(-)
>>>>
>>
>> [..]
>>
>>>> @@ -422,6 +436,11 @@ BlockJob *backup_job_create(const char *job_id,
>>>> BlockDriverState *bs,
>>>>        if (cluster_size < 0) {
>>>>            goto error;
>>>>        }
>>>> +    if (max_chunk && max_chunk < cluster_size) {
>>>> +        error_setg(errp, "Required max-chunk (%" PRIi64") is less
>>>> than backup "
>>>
>>> (missing a space after PRIi64)
>>>
>>>> +                   "cluster size (%" PRIi64 ")", max_chunk,
>>>> cluster_size);
>>>
>>> Should this be noted in the QAPI documentation?
>>
>> Hmm.. It makes sense, but I don't know what to write: should be >= job
>> cluster_size? But then I'll have to describe the logic of
>> backup_calculate_cluster_size()...
> 
> Isn’t the logic basically just “cluster size of the target image file
> (min 64k)”?  The other cases just cover error cases, and they always
> return 64k, which would effectively be documented by stating that 64k is
> the minimum.
> 
> But in the common cases (qcow2 or raw), we’ll never get an error anyway.
> 
> I think it’d be good to describe the cluster size somewhere, because
> otherwise I find it a bit malicious to throw an error at the user that
> they could not have anticipated because they have no idea what valid
> values for the parameter are (until they try).

OK

> 
>>>   (And perhaps the fact
>>> that without copy offloading, we’ll never copy anything bigger than one
>>> cluster at a time anyway?)
>>
>> This is a parameter for background copying. Look at
>> block_copy_task_create(), if call_state has own max_chunk, it's used
>> instead of common copy_size (derived from cluster_size). But at a moment
>> of this patch background process through async block-copy is not  yet
>> implemented, and the parameter doesn't work, which is described in
>> commit message.
> 
> Ah, OK.  Right.
> 
> Max
> 


-- 
Best regards,
Vladimir

