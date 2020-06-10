Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7171AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F7FE2070B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 16:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R26Ev71r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7FE2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj3eF-0005DA-Ft
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 12:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jj3dV-0004Sn-Th
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:31:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jj3dU-00065J-VW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 12:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591806691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+rQrJTNrE+IFxP2sunneGISYzwGWrYvcCsqRMNeSanM=;
 b=R26Ev71rOu077lnuztRWV8uBMQTDPsP4yz6XZ6+0x64XANMDEAyp8wfDvrws92/behl1Ss
 C18kUVByBuysHAXDZxB262Vufo0iLmNggerqah6pg85zDEiz2em/FS2tMcWXTk46yl323x
 nfe49/HNYi9RuNvpkFnhlYHS3oIjkHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-J3bt16_6P3OozRkd7t3iYg-1; Wed, 10 Jun 2020 12:31:26 -0400
X-MC-Unique: J3bt16_6P3OozRkd7t3iYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AB8F461;
 Wed, 10 Jun 2020 16:31:25 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-151.ams2.redhat.com [10.36.113.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BC6B1A7D1;
 Wed, 10 Jun 2020 16:31:23 +0000 (UTC)
Date: Wed, 10 Jun 2020 18:31:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Sam Eiderman <sameid@google.com>
Subject: Re: Clarification regarding new qemu-img convert --target-is-zero flag
Message-ID: <20200610163122.GF6947@linux.fritz.box>
References: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
 <m2imfz877v.fsf@dme.org>
 <CAFr6bUk5LrEL8BPXYkNOqj_jsbxHBfbj_NYryUjszMtG89L+2w@mail.gmail.com>
 <20200610140620.GE6947@linux.fritz.box>
 <CAFr6bU=aD=AXnoR-qSdQtQC690FYFqFsDRHHGxdUDkTh2ho1cA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFr6bU=aD=AXnoR-qSdQtQC690FYFqFsDRHHGxdUDkTh2ho1cA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, David Edmondson <dme@dme.org>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Tony Zhang <tzz@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.06.2020 um 17:26 hat Sam Eiderman geschrieben:
> Thanks for the clarification Kevin,
> 
> Well first I want to discuss unallocated blocks.
> From my understanding operating systems do not rely on disks to be
> zero initialized, on the contrary, physical disks usually contain
> garbage.
> So an unallocated block should never be treated as zero by any real
> world application.

I think this is a dangerous assumption to make. The guest did have
access to these unallocated blocks before, and they read as zero, so not
writing these to the conversion target does change the virtual disk.
Whether or not this is a harmless change for the guest depends on the
software running in the VM.

> Now assuming that I only care about the allocated content of the
> disks, I would like to save io/time zeroing out unallocated blocks.
> 
> A real world example would be flushing a 500GB vmdk on a real SSD
> disk, if the vmdk contained only 2GB of data, no point in writing
> 498GB of zeroes to that SSD - reducing its lifespan for nothing.

Don't pretty much all SSDs support efficient zeroing/hole punching these
days so that the blocks would actually be deallocated on the disk level?

> Now from what I understand --target-is-zero will give me this behavior
> even though that I really use it as a "--skip-prezeroing-target"
> (sorry for the bad name)
> (This is only true if later *allocated zeroes* are indeed copied correctly)

As you noticed later, it doesn't.

The behaviour you want is more like -B, except that you don't have a
backing file. If you also pass -n, the actual filename you pass isn't
even used, so I guess '-B "" -n' should do the trick?

Kevin


