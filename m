Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF40C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9442468E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk++qC7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9442468E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXikd-0007pO-Ne
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kXiRv-00086g-Es
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:13:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48125)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kXiRs-0001iH-TI
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603879976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtXLjSvt4Ouh5vBXYnm1NjFS0OfW3Id3l+71q7FayNY=;
 b=Fk++qC7liWbXSEsMdjcZE6TjM00FayZkX/N2Xu3Q3ei/xpddS0ww0UZ3FVAS39jqpEybUK
 fV+d1P8knl+5UA6j93VZA0HKxhfQZQBvCtIeZtW3eSHYJ4oSQEkncNpap56IEEZW1iAM9p
 EmmVgepKELarLLC5TQ078eV/3Vy0ZPM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-hhjKHUzQOAS5c0aPanOT2A-1; Wed, 28 Oct 2020 06:12:54 -0400
X-MC-Unique: hhjKHUzQOAS5c0aPanOT2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FE30835B47;
 Wed, 28 Oct 2020 10:12:52 +0000 (UTC)
Received: from gondolin (ovpn-113-192.ams2.redhat.com [10.36.113.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECD7460C11;
 Wed, 28 Oct 2020 10:12:42 +0000 (UTC)
Date: Wed, 28 Oct 2020 11:12:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
Message-ID: <20201028111240.51a4fc94.cohuck@redhat.com>
In-Reply-To: <63e1d8d3-65a1-cffd-2fdd-724ba2cc9248@redhat.com>
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
 <CAFEAcA8yBrUH-Bqe7oNhBKqtyeUNw0xVA9aKm8DJFE-WLzLTwQ@mail.gmail.com>
 <20201028091158.09df8b3c.cohuck@redhat.com>
 <63e1d8d3-65a1-cffd-2fdd-724ba2cc9248@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Artem Polyakov <artemp@nvidia.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Neo Jia <cjia@nvidia.com>, Amey Narkhede <ameynarkhede03@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 10:28:39 +0100
Max Reitz <mreitz@redhat.com> wrote:

> On 28.10.20 09:11, Cornelia Huck wrote:
> > On Tue, 27 Oct 2020 23:42:57 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >   
> >> On Mon, 26 Oct 2020 at 19:39, Alex Williamson
> >> <alex.williamson@redhat.com> wrote:  
> >>> ----------------------------------------------------------------
> >>> VFIO update 2020-10-26
> >>>
> >>>  * Migration support (Kirti Wankhede)
> >>>  * s390 DMA limiting (Matthew Rosato)
> >>>  * zPCI hardware info (Matthew Rosato)
> >>>  * Lock guard (Amey Narkhede)
> >>>  * Print fixes (Zhengui li)    
> >>
> >> I get a conflict here in
> >> include/standard-headers/linux/fuse.h:
> >>
> >> ++<<<<<<< HEAD
> >>  +#define FUSE_ATTR_FLAGS               (1 << 27)
> >> ++=======
> >> + #define FUSE_SUBMOUNTS                (1 << 27)  
> >> ++>>>>>>> remotes/awilliam/tags/vfio-update-20201026.0    
> >>
> >> I assume these should not both be trying to use the same value,
> >> so something has gone wrong somewhere. The conflicting commit
> >> now in master is Max's 97d741cc96dd08 ("linux/fuse.h: Pull in from Linux").
> >>
> >> Can you sort out the correct resolution between you, please?
> >> (My guess is that Max's commit is the erroneous one because
> >> it doesn't look like it was created via a standard update
> >> from the kernel headers.)  
> > 
> > We should never change things in the synced headers other than via a
> > headers update (excluding fixups of prior messes.) I'm pointing it out
> > whenever I see something like that happening, but nobody is going to
> > catch all of those.  
> 
> Well, it was a kernel update.  Just based on a preliminary version of
> the kernel part of the FUSE submount feature.
> 
> It was clear that the kernel part would have to be merged before the
> qemu/virtiofsd series, and that did happen, but Miklos (the FUSE
> maintainer) fixed some things on top while doing so, an that included
> changing the flag in question.  As Adam wrote, I noted that I would thus
> have to write a v2 of the virtiofsd series.
> 
> Unfortunately, that all was a bit buried in the thread, so I suppose for
> Dave it looked like the kernel series was applied, so the virtiofsd
> series could go in, too.  And I in turn didn't catch that. :/

Yeah, things like that happen, especially if explanations are buried
deeply somewhere :/

> 
> > Is there any place where we can have some kind of automatic check on a
> > pull request for that kind of stuff? We'd need to formalize an "update
> > headers" commit message, or maybe have the update script write some
> > kind of "last updated" file?  
> It would also need to actually check against the kernel tree, because,
> well, I did use the script.  Just against a kernel tree that never came
> to master.

Hm.  That's probably hard to get right, unless we require all updates
to be against a tagged kernel (-rc) version. Not sure if that's too
strict.


