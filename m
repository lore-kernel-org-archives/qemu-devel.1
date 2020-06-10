Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B2EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C312072F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 15:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="BxbLw2D7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C312072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj2t3-00037g-OF
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 11:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jj2s6-0002Yz-AU
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:42:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52135)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1jj2s4-0000ve-VT
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 11:42:33 -0400
Received: by mail-wm1-x343.google.com with SMTP id u13so2265665wml.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=hIAvhwLqtzE/CW/wXZJTwELxjRO3/Xv5xkvDJShF76k=;
 b=BxbLw2D7jWEPFV08EdBzSI1Jt7OMBYrJMHoLCCFi+aa783K8K+lXLVSXhPGcVg2EvS
 MSCgwzbmw3qgJUkkCGVtMIzfdPkOvm24e1u4C760KFXhsUmp1pzSizXbfOHtoOIepUYS
 2GKKxxRs4btsI/aIPFbHcbqvJ87seBNaCxRjI0L2MvO7o5VZlaZ7pOLAJx8bVpWi/QLm
 KFRkDIFh3NZNkfTVrHhch9CwGi/4imDhXLxGLpwAtoaRmg8B/hsscPPdztBedKcMD+UL
 9B/rbg86e3mYxIYNfDjanAUiMFxxVOxhK7TpA0dzJdiiLC1ItYT+tTXWiUWCsxvtnt7I
 HAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=hIAvhwLqtzE/CW/wXZJTwELxjRO3/Xv5xkvDJShF76k=;
 b=gAoEHCdAtu27Ys8oxzdj2FsAOvbZGEEa+XGeXyF2pxmaNrVwtJbIyMO8DbgljQeRoL
 YxGj9nSPIdH8YeGSS6J8/2z/TCgDAAC/BFDggxrX3cEFAIvTAQWEseAkgvg0kuOD32YB
 fPm7+1G8mBy23fDnUYq5i7kT89heJ1wcw9NYtjnRbq9Z14Qec1CD1wsu+YYAqIPSuMZO
 PbkzbjHfPvb5ayBLjYnbM7PAovUpInXF/pv0J3//mN3nlm9F5x7UQwRPvAih2YO9fJjt
 EzdOUP1WHXHMi8H7UJg42OaN9bwS0ONrGBrgBrtWlwOd/Hr34poNwaN+auH+sK99azf6
 8xLg==
X-Gm-Message-State: AOAM532GU4Ah6IdeggOISb9rvqifiLcGjYTNxEMB+xTBowe2ZnX2sauq
 8ffDiz+g9y2PezbzYotO1zt1SjAUxuxwIYhb
X-Google-Smtp-Source: ABdhPJyuGlC7e9q4yFpwvSGigEl+Q2gBPtqEDwDBdyfwcBeT4BBdWRN1qsk+4o+A97XfE5l1PPMzWg==
X-Received: by 2002:a1c:6042:: with SMTP id u63mr3760960wmb.65.1591803749881; 
 Wed, 10 Jun 2020 08:42:29 -0700 (PDT)
Received: from disaster-area.hh.sledj.net (disaster-area.hh.sledj.net.
 [2001:8b0:bb71:7140:64::1])
 by smtp.gmail.com with ESMTPSA id w15sm108549wmk.30.2020.06.10.08.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 08:42:28 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 3a7faa7c;
 Wed, 10 Jun 2020 15:42:28 +0000 (UTC)
To: Sam Eiderman <sameid@google.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
In-Reply-To: <CAFr6bUksp1Nm4nL69na5WDj6A5iXzwcc4K3=JNnyP4xZ+HKJHA@mail.gmail.com>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
 <20200610140620.GE6947@linux.fritz.box>
 <CAFr6bU=aD=AXnoR-qSdQtQC690FYFqFsDRHHGxdUDkTh2ho1cA@mail.gmail.com>
 <CAFr6bUksp1Nm4nL69na5WDj6A5iXzwcc4K3=JNnyP4xZ+HKJHA@mail.gmail.com>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 10 Jun 2020 16:42:27 +0100
Message-ID: <m2bllr7wrg.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::343;
 envelope-from=dme@dme.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=_AUTOLEARN
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Tony Zhang <tzz@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-06-10 at 18:29:33 +03, Sam Eiderman wrote:

> Excuse me,
>
> Vladimir already pointed out in the first comment that it will skip
> writing real zeroes later.

Right. That's why you want something like "--no-need-to-zero-initialise"
(the name keeps getting longer!), which would still write zeroes to the
blocks that should contain zeroes, as opposed to writing zeroes to
prepare the device.

> Sam
>
> On Wed, Jun 10, 2020 at 6:26 PM Sam Eiderman <sameid@google.com> wrote:
>>
>> Thanks for the clarification Kevin,
>>
>> Well first I want to discuss unallocated blocks.
>> From my understanding operating systems do not rely on disks to be
>> zero initialized, on the contrary, physical disks usually contain
>> garbage.
>> So an unallocated block should never be treated as zero by any real
>> world application.
>>
>> Now assuming that I only care about the allocated content of the
>> disks, I would like to save io/time zeroing out unallocated blocks.
>>
>> A real world example would be flushing a 500GB vmdk on a real SSD
>> disk, if the vmdk contained only 2GB of data, no point in writing
>> 498GB of zeroes to that SSD - reducing its lifespan for nothing.
>>
>> Now from what I understand --target-is-zero will give me this behavior
>> even though that I really use it as a "--skip-prezeroing-target"
>> (sorry for the bad name)
>> (This is only true if later *allocated zeroes* are indeed copied correctly)
>>
>> Sam
>>
>> On Wed, Jun 10, 2020 at 5:06 PM Kevin Wolf <kwolf@redhat.com> wrote:
>> >
>> > Am 10.06.2020 um 14:19 hat Sam Eiderman geschrieben:
>> > > Thanks David,
>> > >
>> > > Yes, I imaging the following use case:
>> > >
>> > > disk.vmdk is a 50 GB disk that contains 12 MB binary of zeroes in its beginning.
>> > > /dev/sda is a raw disk containing garbage
>> > >
>> > > I invoke:
>> > > qemu-img convert disk.vmdk -O raw /dev/sda
>> > >
>> > > Required output:
>> > > The first 12 MB of /dev/sda contain zeros, the rest garbage, qemu-img
>> > > finishes fast.
>> > >
>> > > Kevin, from what I understood from you, this is the default behavior.
>> >
>> > Sorry, I misunderstood what you want. qemu-img will write zeros to all
>> > unallocated parts, too. If it didn't do that, the resulting image on
>> > /dev/sda wouldn't be a copy of disk.vmdk.
>> >
>> > As the metadata (which blocks are allocated) cannot be preserved in raw
>> > images, you wouldn't be able to tell which part of the image contains
>> > valid data and which part needs to be interpreted as zeros even though
>> > it contains random garbage.
>> >
>> > What is your use case for this result where the actual virtual disk
>> > content is mixed with garbage?
>> >
>> > Kevin
>> >

dme.
-- 
He caught a fleeting glimpse of a man, moving uphill pursued by a bus.

