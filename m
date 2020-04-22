Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B558C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027E6206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="C2s0FdM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027E6206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGNq-0006tg-7B
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59718)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRGNE-0006TG-6E
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jRGNC-0001Q1-JT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:29:11 -0400
Received: from mail-eopbgr40092.outbound.protection.outlook.com
 ([40.107.4.92]:27579 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jRGNB-0001Ir-SD; Wed, 22 Apr 2020 10:29:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu3lkE0siS1BzfWBEe9nLFPtT5XIo90Qwd8bXRbtkRGHnktk42k+MCh5G5jXmYkAtpnmGIg3nnVWdgD+4D/OKrktX7vf2VpHhZNPIvBTuFRm4Nsy4b4CeUCMIRmjD5/Iu7SbhfrQlSlrOcGb00N3WDvg2rQhaRxdGcA6mnmFtA6Vcl3WjRwsdhUeBEyJveVqR6ZKrKFvRCcJngrQvfgZQrW1e0cytXAk1qhS1xcCQUoB8vyN9Ze8NznOvN888RMNQnq1Edm+PBVvQIhmSCn2e17Zze321VYnTa29+gZ4fVE2D7b8T3aklyyCa9rG5t0XlT8t37ya7ZrWp5v8ovxyAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu9sMcx33wsvAKaC1d2lVkQFHHqqw60D1JDgzClD83g=;
 b=X3NJ7zpGTPlCirc0oB8F6d3304w25R+MGCGDOoMfOSypn9PFtk/EF6m5HzBdWbblW4TNWxRuYf2dI74bo4grHtms4mNKhP/Jx6mAmSwefhtrDmqXzWG0GS7COQ2R263Yb64w78IyNFFoZFudh42EyqxVqSklWDzEOQ8/qQXJDPMClu4HZ1og09xxpDrto8QBrA4v6xMpkorL2AHWw2k5X0iqhWFJf/VwPevjsmX9oBlVhLh/OlBhrVxn1MZ86kNpsfrYIx03nzKns/RSKt3W9rZHDZWa7H51xuetzWR9cEtYO3biRq6klrlsxuVq0Cu1skmhTHu5Z/mClyl5/CN1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xu9sMcx33wsvAKaC1d2lVkQFHHqqw60D1JDgzClD83g=;
 b=C2s0FdM5f10fM8m+0b/08bGzwGM234Hzek4hkiBIiYNvXIzuIPtyDpHRjr9XJ5xNVd+5iODid+8KXp1FPf0RwbLfQabasq4ei2+LLJz7R3RZqbenS+yUiDg3izOhCVmESJmg/KfjnEgstbUDZ5c9iwLzAe8NBuL9eZOmwCjKpZQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5511.eurprd08.prod.outlook.com (2603:10a6:20b:10d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 22 Apr
 2020 14:29:06 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2937.012; Wed, 22 Apr 2020
 14:29:06 +0000
Subject: Re: [RFC 0/3] 64bit block-layer part I
To: qemu-block@nongnu.org
References: <20200330141818.31294-1-vsementsov@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200422172902671
Message-ID: <572e78c6-f346-58e8-98cd-1b355e5bb33b@virtuozzo.com>
Date: Wed, 22 Apr 2020 17:29:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200330141818.31294-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0118.eurprd07.prod.outlook.com
 (2603:10a6:207:7::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM3PR07CA0118.eurprd07.prod.outlook.com (2603:10a6:207:7::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.10 via Frontend Transport; Wed, 22 Apr 2020 14:29:04 +0000
X-Tagtoolbar-Keys: D20200422172902671
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0288682f-782c-48c2-2afc-08d7e6c9835f
X-MS-TrafficTypeDiagnostic: AM7PR08MB5511:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5511D493CA1C332AFCF3999BC1D20@AM7PR08MB5511.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39840400004)(366004)(136003)(346002)(376002)(186003)(81156014)(5660300002)(66946007)(52116002)(2906002)(66556008)(66476007)(7416002)(31686004)(26005)(8936002)(478600001)(316002)(16576012)(8676002)(16526019)(86362001)(36756003)(31696002)(6486002)(6916009)(956004)(2616005)(4326008)(107886003);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1n2KAB8vUO4W7WTWrdxpWasaeAHHsdfauXGYa9wulcwVoOC9GVOp2lUJ0mMMTEzai79N+66LxocNSig1wzFTQ9h1juivaZhUEcM6MrzoQOw6Mu3Djtb8hRM4yTj06eb4vz07Dmyt2Ltosf8J3DRE7wTEaAymh5m6Vm0/YWATM2OZ4p+gIzMzng7LkwMLterF9UJMjEv1krbta/ofrXFJXhDooPIvt99scsHAd/gRbWVnlkcMDDGx1dK7/ucFED79DVGpq5KKkEjFazs/jypTtjlQn50o/U+dV1lwU3mZVx0MHqYwVTXP2DHhGmWV8VCzHSaRyCHHIRSI1vUo0RSEQYKz1RtZmZafdVLazSMDEeLV1jKEdABa80OdzDR5Ly12YuGAEx4KzufNJAk44NO6EEDmSUkUJnxpRN08i+WcYdCrtpAKf7j1K6t1YeOJtx8
X-MS-Exchange-AntiSpam-MessageData: NI8HiR/11MVdo1uIDIrqDJdsf11jbYPlsztHd8SnoGfRKk3OMLAzmF0jMXpfURo5Gm8pOpHwXPZTUBguLtkSuErc7O7zbzl0S24cfdHrd168bDtexYXd5152mqWvdI5AgdDbrGs7qqQ762aXl/kJug==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0288682f-782c-48c2-2afc-08d7e6c9835f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 14:29:06.5102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5K5QOwHWm0OYwrOU+FXh5dL6fNoOdDlBLxJQ/rt801MgvbuG/Mqfx1ifH5NDdApfHv7sXHIcCqI1n08QGloUUtt5HJuXB68RdUOXpFi2iY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5511
Received-SPF: pass client-ip=40.107.4.92;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 10:29:07
X-ACL-Warn: Detected OS   = Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.4.92
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
Cc: fam@euphon.net, kwolf@redhat.com, berto@igalia.com, stefanha@redhat.com,
 pavel.dovgaluk@ispras.ru, sw@weilnetz.de, pl@kamp.de, qemu-devel@nongnu.org,
 mreitz@redhat.com, jsnow@redhat.com, ronniesahlberg@gmail.com, den@openvz.org,
 pbonzini@redhat.com, dillaman@redhat.com, ari@tuxera.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any thoughts here? I need to resend to update some more functions as patchew said.

Is it OK in general? Or should we instead convert everything to uint64_t ?

30.03.2020 17:18, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> There is an idea to make NBD protocol extension to support 64bit
> write-zero/discard/block-status commands (commands, which doesn't
> transfer user data). It's needed to increase performance of zeroing
> large ranges (up to the whole image). Zeroing of the whole image is used
> as first step of mirror job, qemu-img convert, it should be also used at
> start of backup actually..
> 
> We need to support it in block-layer, so we want 64bit write_zeros.
> Currently driver handler now have int bytes parameter.
> 
> write_zeros path goes through normal pwritev, so we need 64bit write,
> and then we need 64bit read for symmetry, and better, let's make all io
> path work with 64bit bytes parameter.
> 
> Actually most of block-layer already have 64bit parameters: offset is
> sometimes int64_t and sometimes uint64_t. bytes parameter is one of
> int64_t, uint64_t, int, unsigned int...
> 
> I think we need one type for all of this, and this one type is int64_t.
> Signed int64_t is a bit better than uint64_t: you can use same variable
> to get some result (including error < 0) and than reuse it as an
> argument without any type conversion.
> 
> So, I propose, as a first step, convert all uint64_t parameters to
> int64_t.
> 
> Still, I don't have good idea of how to split this into more than 3
> patches, so, this is an RFC.
> 
> What's next?
> 
> Converting write_zero and discard is not as simple: we can't just
> s/int/uint64_t/, as some functions may use some int variables for
> calculations and this will be broken by something larger than int.
> 
> So, I think the simplest way is to add .bdrv_co_pwritev_zeros64 and
> .bdrv_co_pdiscard64 and update drivers one-by-one. If at some point all
> drivers updated - drop unused 32bit functions, and then drop "64" suffix
> from API. If not - we'll live with both APIs.
> 
> Another thing to do is updating default limiting of request (currently
> they are limited to INT_MAX).
> 
> Then we may move some drivers to 64bit discard/write_zero: I think about
> qcow2, file-posix and nbd (as a proof-of-concept for already proposed
> NBD extension).
> 
> Any ideas?
> 
> Vladimir Sementsov-Ogievskiy (3):
>    block: use int64_t as bytes type in tracked requests
>    block/io: convert generic io path to use int64_t parameters
>    block: use int64_t instead of uint64_t in driver handlers
> 
>   include/block/block.h     |  8 ++--
>   include/block/block_int.h | 52 ++++++++++-----------
>   block/backup-top.c        |  5 +-
>   block/blkdebug.c          |  4 +-
>   block/blklogwrites.c      |  4 +-
>   block/blkreplay.c         |  4 +-
>   block/blkverify.c         |  6 +--
>   block/bochs.c             |  2 +-
>   block/cloop.c             |  2 +-
>   block/commit.c            |  2 +-
>   block/copy-on-read.c      |  4 +-
>   block/crypto.c            |  4 +-
>   block/curl.c              |  2 +-
>   block/dmg.c               |  2 +-
>   block/file-posix.c        | 18 ++++----
>   block/filter-compress.c   |  6 +--
>   block/io.c                | 97 ++++++++++++++++++++-------------------
>   block/iscsi.c             | 12 ++---
>   block/mirror.c            |  4 +-
>   block/nbd.c               |  8 ++--
>   block/nfs.c               |  8 ++--
>   block/null.c              |  8 ++--
>   block/nvme.c              |  4 +-
>   block/qcow.c              | 12 ++---
>   block/qcow2.c             | 18 ++++----
>   block/quorum.c            |  8 ++--
>   block/raw-format.c        | 28 +++++------
>   block/rbd.c               |  4 +-
>   block/throttle.c          |  4 +-
>   block/vdi.c               |  4 +-
>   block/vmdk.c              |  8 ++--
>   block/vpc.c               |  4 +-
>   block/vvfat.c             |  6 +--
>   tests/test-bdrv-drain.c   |  8 ++--
>   block/trace-events        | 14 +++---
>   35 files changed, 192 insertions(+), 192 deletions(-)
> 


-- 
Best regards,
Vladimir

