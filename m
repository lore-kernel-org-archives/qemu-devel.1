Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA8AC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D16821481
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qXukNlCV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D16821481
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUxfw-0007i5-Ud
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 15:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kUxXX-00075m-5s; Tue, 20 Oct 2020 15:43:23 -0400
Received: from mail-db8eur05on2115.outbound.protection.outlook.com
 ([40.107.20.115]:41472 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kUxXT-0001sF-Gt; Tue, 20 Oct 2020 15:43:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8N3sirDZOV1sUtEDfnHpY4bJqQr83tbWYRpkwLGKP71ITRT03Lkx/Azt8uiWTIVKUJybXjBJsYMtmlCbFzFPPemDPT1vs7DfJWwK62EQ9QSDcXwHuRRMtjWd0ZsOi4JKNpD8dcOLrnCA+CDSXjucjUQ1cRirxnQODZayCIN+ZwaeaROUF5Rbqi8Ox4FVB1L6pE+QX5QcC6IiSGhjS+4e5s5PUNgB6BglPK+Ln5fyfkDFr997I5jZWSe2P4jYZ3rmXjJzZXQswDauLXc9t7WYUg7Sain3U9OVRKvt6lfWv5gAf5Ic2ZY0PP8O0KK91Wb++dIxRFkM4BoLHtK2HV3Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FySAv3BMYIqvcVTi8JWI17kC5vByiuJgSBmk45vTe+8=;
 b=AhFh7PTv1g5UjJLXI3e3tVNWIDzg1vwb/uRYap+RAfxB+ufe4qXHNViG6v0ehgcGs4vChEvRFF+5mk+fmZnx2zLZ66pYBaJhMglRmYm9pMMArvXHoFMh3LnBnAvTPLwZEgxP58h9MoDjzIYLs4HPNJJ8GyZLPJBaDJuT27VeVFsY2HWUxMAYoPYldh/71wZzsUGEUcOEEObqhdUObHOCBGpymmcMhVvqMBcndSjQZamNVvqP3PtKkCZJORNyfSzInB8GwFzSgJCFz5CTFBpNmSry4k0FXwHOcl9rgApc0t5io7r+bMGDVOymEgZFwCPcGS52wM/4Q5mlgtmVRFJR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FySAv3BMYIqvcVTi8JWI17kC5vByiuJgSBmk45vTe+8=;
 b=qXukNlCVlx3OkNdTYSXa/bCmJwgiRyC3YgbCdfOpbd0Y5DdOBX4ps9UlrV75oCzyv9GIZhbscnekCAbAoJzK41jWt9S8zbohBloBc80ONo7cn4iHEVRa+BBMZy6d1Y3V1D+x4t4rcb7svoT16b7+ithntFzBmVMcYn49NRBihjk=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2779.eurprd08.prod.outlook.com (2603:10a6:7:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 19:43:10 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 19:43:10 +0000
Subject: Re: [PATCH v11 13/13] block: apply COR-filter to block-stream jobs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, fam@euphon.net,
 stefanha@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 libvir-list@redhat.com, eblake@redhat.com, den@openvz.org
References: <1602524605-481160-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1602524605-481160-14-git-send-email-andrey.shinkevich@virtuozzo.com>
 <6074273c-088f-069b-2a6c-aee812c3bad6@redhat.com>
 <fd2d9c80-c238-e635-d12c-f2d41b5e3dbc@virtuozzo.com>
 <d5e8cf09-1e39-4c85-5e23-04642322a633@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <2cf07087-aea4-5c8e-fbef-be28eccc94c7@virtuozzo.com>
Date: Tue, 20 Oct 2020 22:43:07 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <d5e8cf09-1e39-4c85-5e23-04642322a633@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Tue, 20 Oct 2020 19:43:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a478581d-249c-4c37-1e48-08d875306011
X-MS-TrafficTypeDiagnostic: HE1PR08MB2779:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB277978AFC7D502FB069256AEF41F0@HE1PR08MB2779.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1JBjlGZuy+ClCcOvci9Aoh1uq32XISIgYBpfV/3uf0DPCe3uvxSABkfHQ35O1q+Sk4m8q3qLY8SqID7XK5oiJuv8ogUUMtSNxLe5vQ/nDZnLL7uGwZ6TtCWKdM2EnDds/8dVudFyd3VMf0PipbKq9+m4ndZ/kta5P2Sfw2w2zRUvPKHI53ZfIsdJNpefYXZqpVPDCdFszeRFdKRe2w5hMuUJpp1v3om7U2JH41/QEX+pJ5TwUGsX1evs7r29oVRdr5X5Gd0H6h9lbbKM/I88PQMTl2bXISdSnKiPdgF7UL/qNISgmpPLGrZ3QPAB/3SzwquoLh3+Wq3Ous1f7uiVAcUwrcEjRO3YUCPVamk4dmjrGYiIq+UdOZd33uJQ6OQC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39830400003)(346002)(396003)(136003)(376002)(44832011)(6486002)(83380400001)(16526019)(53546011)(478600001)(6506007)(52116002)(26005)(2906002)(956004)(8676002)(7416002)(107886003)(31686004)(66476007)(8936002)(110136005)(66556008)(186003)(66946007)(31696002)(6512007)(2616005)(86362001)(316002)(5660300002)(36756003)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: cc28IfqinM69TNABZM1GUb1Po6oc4X2gFYZZstqD4EE+t5y/82ySRY0AEODtp3HmHNm6yY8CB5V2sIo4/gTzpgFbwzmfRA9JZ713HCapEY48+yyhbbn+kLnuahdYJB5GBSz242h7zLwWegpoKdtRz1zwJ6+n141slrs2Bw8JQ5ph0OApt0JAYO5ksZWOdmhcgkxu7/L3q6h/TTMXsRkK939DFX+ezym1vmdCzcwnIIL6ZKBlft1zNwLc8AYQoji8AMavFRwoJ5sM975TZifp1m1luislcxBDv/K8pMeSJXz8dfpNJswi9qBWvFIW6Uv7bqfUzY1ODylesWi4v/5Kw2EvzxGdeeGauH57P6ELCvZQ0gLPrdS/N37dpWKNMGZVsoVdleS10xs28qRD31QeMQw3ePkaMOb+IVdGMo1u/f9/60Si0mQ8UyuXVB3aDpqtdxqAhiRGPhouHS348VWt/fhciyORLjECHge0Tlo4+bHdsZc4+KTVYrMsvlNmQbBJkWMmS7XGo6iNKebLn5dOPvNcnKPE9bqM3kkrPvcfjrj4X3p6/MCkBy6pUPXiosBfpcSxMLyjAw5Ztdn+XbizFDzR5qopIvVp9r2s+Ga1nWEvq9PWpPycmsl1IL8CjYghSlsm3/wVWn6p2FjvnMTqRA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a478581d-249c-4c37-1e48-08d875306011
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 19:43:10.5828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R1vkIsLDyvQysb1dEGSNIOStT3OiVD8pOyZlse/ltQgKHLtnP5K5WXM6TKBXuHP6/m1EYK0j8h6scQ0dQ4xOJ6cVGT8/MZn7brrLyhuU728=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2779
Received-SPF: pass client-ip=40.107.20.115;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 15:43:14
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

On 16.10.2020 18:45, Vladimir Sementsov-Ogievskiy wrote:
> 15.10.2020 20:16, Andrey Shinkevich wrote:
>> On 14.10.2020 19:24, Max Reitz wrote:
>>> On 12.10.20 19:43, Andrey Shinkevich wrote:
>>
>> [...]
>>
>>>> ---
>>>>   block/stream.c             | 93 
>>>> +++++++++++++++++++++++++++++-----------------
>>>>   tests/qemu-iotests/030     | 51 +++----------------------
>>>>   tests/qemu-iotests/030.out |  4 +-
>>>>   tests/qemu-iotests/141.out |  2 +-
>>>>   tests/qemu-iotests/245     | 19 +++++++---
>>>>   5 files changed, 81 insertions(+), 88 deletions(-)
>>>
>>> Looks like stream_run() could be a bit streamlined now (the allocation
>>> checking should be unnecessary, unconditionally calling
>>> stream_populate() should be sufficient), but not necessary now.
>>>
>>
>> That is what I had kept in my mind when I tackled this patch. But 
>> there is an underwater reef to streamline. Namely, how the 
>> block-stream job gets known about a long unallocated tail to exit the 
>> loop earlier in the stream_run(). Shall we return the '-EOF' or 
>> another error code from the cor_co_preadv_part() to be handled by the 
>> stream_run()? Any other suggestions, if any, will be appreciated.
> 
> Just calling read CHUNK by CHUNK may be less efficient than 
> is_allocated()-driven loop: you may end up with splitting regions 
> unaligned to CHUNK-granularity, which would not be splitted with 
> is_allocated()-driven loop. Current loop allows chunks unaligned to CHUNK.

The cor_co_preadv_part() will check for the end of a file in the next 
version. So, the unalignment is not going to be the issue.

Andrey

> 
> So, I think, it's better to keep is_allocated() logic as is for now.
> 
> 
> 

