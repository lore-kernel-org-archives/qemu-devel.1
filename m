Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFCDC33CA1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ADA620659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Hiy7qlAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ADA620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izGdM-0000ky-3J
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izGcO-0000AN-4A
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izGcM-0001kS-VF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:05:08 -0500
Received: from mail-db8eur05on2115.outbound.protection.outlook.com
 ([40.107.20.115]:58080 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izGcG-0001XF-22; Wed, 05 Feb 2020 04:05:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1gGXKwEyfh5/058FdBomGB2ccJQ1qLe3ZSjulXfV5NXX1gsP3jR2jF+sIGG1tVBfwzfk1HF/JxZH9LtVmSWgTsTDuqGWJFLVX85Oo2JBdHtMyJWz5Mepky84uRdac8T04i2a0stJ83iwfSKNwaom3tVQceP0zDMGpuvwlKezMtbs4an/q+lODEwUol3T6u6DCakH8CLa0Z4/5Q/KgAhn/BpHIiDzW4cQGdmVtyiSXwjTsqWqqyOeXXoOI0z3WwyEMbF7Zq4TNVh3NSuqfRe9iZw/64XO69MqTuvWatA98fvF7sLzxDLgjH5PJSxxwWitKQ/yt0bHfsC4TneocW3hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k77GUDyel/Ktz7a1NmQH6MA5pI3tkuqb2z36IEUs28I=;
 b=e7Ah3wmyXoZ2FEeWkEP3/pwyaVanYtXanDGJIm8Hwuybbl8Uk9ly9s2nyySWOqFLBBFWJ9PeUg1pQyD62dYxtbCh58odVpRoc7ojc2u32DFcbLFdkx5w+dfC/a541INcQfPHGXVVuVm9/JrobR5sTeJurg6D2VbL1sYvhooMFNCh0hwetsmQfuvvthBUJEk2P9a9t4RCJpVKmQ7yFkGGqNOXwvxmYxSF2fGeLp7ThYMNIfn0bBa10Ki24E4rDcnNSoZWXq6a6f0gv7XdRiMMkaMXKKhSsgNYEshRcRWjWX5WgLl2//qZ96L/47ZI+znJ18siRnzGirAxgmRBNnYYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k77GUDyel/Ktz7a1NmQH6MA5pI3tkuqb2z36IEUs28I=;
 b=Hiy7qlAO4xBn1hTUgWo+o+8G5TaL9QxdQKt5pOXkp/EYKBD0PIFoOKF/uDuVBfFRkTVRy66kn5VphlzOobEKa61VVNjd5cASEwi6yuakovX378SAunEgky46CUzSxiINBxepS6sGSRhDnLOppma8VJFNhg0NFDYUI92atQ/SSPI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com (20.179.28.138) by
 VI1PR08MB2878.eurprd08.prod.outlook.com (10.170.236.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 09:04:54 +0000
Received: from VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0]) by VI1PR08MB4432.eurprd08.prod.outlook.com
 ([fe80::9c56:6d95:76d1:d0%2]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 09:04:54 +0000
Subject: Re: [PATCH 00/17] Improve qcow2 all-zero detection
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200205120451811
Message-ID: <3bad82d4-4d60-4341-d87e-af37e1dd680e@virtuozzo.com>
Date: Wed, 5 Feb 2020 12:04:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200131174436.2961874-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::19)
 To VI1PR08MB4432.eurprd08.prod.outlook.com
 (2603:10a6:803:102::10)
MIME-Version: 1.0
Received: from [172.16.24.200] (185.231.240.5) by
 HE1P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29 via Frontend Transport; Wed, 5 Feb 2020 09:04:53 +0000
X-Tagtoolbar-Keys: D20200205120451811
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43267769-6339-40f9-9949-08d7aa1a7733
X-MS-TrafficTypeDiagnostic: VI1PR08MB2878:
X-Microsoft-Antispam-PRVS: <VI1PR08MB287854543FD137A58FE892F8C1020@VI1PR08MB2878.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(136003)(376002)(39850400004)(346002)(396003)(366004)(199004)(189003)(26005)(956004)(2616005)(316002)(186003)(16526019)(6486002)(8676002)(2906002)(36756003)(81156014)(81166006)(31696002)(8936002)(86362001)(478600001)(31686004)(66556008)(66476007)(4326008)(16576012)(52116002)(5660300002)(66946007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB2878;
 H:VI1PR08MB4432.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UFVcrB+VxJEUbQNtrhvdrOUApbKhpkBq/woTjWRDhJkjYFArcruYfMhB3kPm6JCkv5pqyN4fSDPaeLAq4fXiCaoJTcJBv/wz0GEtK8qT8qsXHUuKKa0yqogYR651OrTU0wxYaIfA1vdbW8w3APabFDTlwuGzkVBI7WoKkgF8FxZelvFk/NBaQO1jMtv9Fzje79k5LmHKqEHHBX+h10vZC6D2rRfDOkQs834MZIcV9He+qDNSWnIBpG/SA7oH2c+x+9svwD3SW87W41nokgt27d8VCjMEtK6d7TFEvlqYyctj+cDEosGDytkk6mPV5A2G9cBQQwyESypcbhptQdDoF3EBJcvvjF8PTK72Mijfq5dTUF9iPU7YnvwuKdgbj2mgl8Kt3KMijdhCQqmgPrBbFW3HcxgNkVUlzEna41kUXx1HfbaNw9xShlMH7AJrEhc5
X-MS-Exchange-AntiSpam-MessageData: 6LcfdVPRuV8Jgtq3a6TE+RWCzc4EQf7+AuzZiHc+1cbds8gGyxIVtGd29nSkUVZAYohc5kZOyG86mLdRJQEeN8ogddBSDBwEif6YWc8DlQ0fcm2cpe7Sg2XMxNSClefjpSy1zgxO4o2OBTv3KkQIoA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43267769-6339-40f9-9949-08d7aa1a7733
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 09:04:54.3285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWQGQcQAs3+DLVdtjbSVoKJrKN1TsIzX40zIGayKzyOaojlE/VJaJIES9CqRaukgc8H5jX6qcqFqhEtosQq4UHnPbGcGRLfKp6BAPCG3zEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2878
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.20.115
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
Cc: david.edmondson@oracle.com, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

31.01.2020 20:44, Eric Blake wrote:
> Based-on: <20200124103458.1525982-2-david.edmondson@oracle.com>
> ([PATCH v2 1/2] qemu-img: Add --target-is-zero to convert)
> 
> I'm working on adding an NBD extension that reports whether an image
> is already all zero when the client first connects.  I initially
> thought I could write the NBD code to just call bdrv_has_zero_init(),
> but that turned out to be a bad assumption that instead resulted in
> this patch series.  The NBD patch will come later (and cross-posted to
> the NBD protocol, libnbd, nbdkit, and qemu, as it will affect all four
> repositories).
> 
> I do have an RFC question on patch 13 - as implemented here, I set a
> qcow2 bit if the image has all clusters known zero and no backing
> image.  But it may be more useful to instead report whether all
> clusters _allocated in this layer_ are zero, at which point the
> overall image is all-zero only if the backing file also has that
> property (or even make it two bits).  The tweaks to subsequent patches
> based on what we think makes the most useful semantics shouldn't be
> hard.
> 
> [repo.or.cz appears to be down as I type this; I'll post a link to a
> repository later when it comes back up]
> 

I have several ideas around it.

1. For generic block layer.
Did you consider as alternative to BDRV_ZEO_OPEN, to export the
information through normal block_status? So, if we have the
information, that disk is all-zero, we can always add _ZERO
flag to block-status result. And in generic bdrv_is_all_zeroes(),
we can just call block_status(0, disk_size), which will return
ZERO and n=disk_size if driver supports all-zero feature and is
all-zero now.
I think block-status is a native way for such information, and I
think that we anyway want to come to support of 64bit block-status
for qcow2 and nbd.

2. For NBD
Again, possible alternative is BLOCK_STATUS, but we need 64bit
commands for it. I plan to send a proposal anyway. Still, nothing
bad in two possible path of receiving all-zero information.
And even with your NBD extension, we can export this information
through block-status [1.]

3. For qcow2
Hmm. Here, as I understand, than main case is freshly created qcow2,
which is fully-unallocated. To understand that it is empty, we
need only to check all L1 entries. And for empty L1 table it is fast.
So we don't need any qcow2 format improvement to check it.




-- 
Best regards,
Vladimir

