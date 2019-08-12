Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F79C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD0CA206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:17:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD0CA206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxHgk-0006rC-6M
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 17:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41693)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hxHg9-0006Dk-5V
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hxHg7-000893-Us
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:16:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hxHg7-00088S-Oj
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:16:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id r1so6743736wrl.7
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 14:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=H1NCDqFtaNw5+6bAZgV4zzDgD8o02gBItnoR55euYAI=;
 b=Me03qzEnDxhyQFkxxzrgUmSd/4gJVPUzl1kc8Fij8pAOzi1luCC2qhUziHxbNbdnWS
 B83GOlb8+MBL6MK2aCTYMoVIq8Y4zzBwUymslr9pSucVnKMbBz6ZZZv6XH/Y6yF5XVle
 YfD84jmIiPTi0rNK1oRfgPKB0VrQdRfHL46ZT8AvJl4C5uL26rjzUmonesUP6zQHUdFD
 DkB8d4cAowyiT3SrMEufp4Hal9ZQZy/bhLJXqPngcqpXl6H0UIXLv/GUa2SmWwtv5Iz1
 3xuXukJ8F9bsva/WhFbz5lbPc5oTGqhWD3MQfwer8eqR9dcvBel/X5h261AejQQW9s1Y
 mUXA==
X-Gm-Message-State: APjAAAVKkP3FTEHgDDiNtXphxaMwniuvdTOjwRcNilbJ1kY1z80E+CfB
 M793PPCwoZ6cwAkgYqvIUg5V3A==
X-Google-Smtp-Source: APXvYqxr/RRoG8S9rTuft4qTEEol3OBHH17ebnAS6en5pOul5jtWCVMHqBcWArTlKs4n/23Jiit/lA==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr17428349wrq.208.1565644590492; 
 Mon, 12 Aug 2019 14:16:30 -0700 (PDT)
Received: from xz-x1 (net77-43-52-122.mclink.it. [77.43.52.122])
 by smtp.gmail.com with ESMTPSA id v124sm482741wmf.23.2019.08.12.14.16.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 12 Aug 2019 14:16:29 -0700 (PDT)
Date: Mon, 12 Aug 2019 23:16:26 +0200
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20190812211626.GA9073@xz-x1>
References: <20190812074531.28970-1-peterx@redhat.com>
 <20190812102453.3c05ab43@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190812102453.3c05ab43@x1.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Bandan Das <bsd@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 12, 2019 at 10:24:53AM -0600, Alex Williamson wrote:
> On Mon, 12 Aug 2019 09:45:27 +0200
> Peter Xu <peterx@redhat.com> wrote:
> 
> > This is a RFC series.
> > 
> > The VT-d code has some defects, one of them is that we cannot detect
> > the misuse of vIOMMU and vfio-pci early enough.
> > 
> > For example, logically this is not allowed:
> > 
> >   -device intel-iommu,caching-mode=off \
> >   -device vfio-pci,host=05:00.0
> 
> Do we require intel-iommu with intremap=on in order to get x2apic for
> large vCPU count guests?  If so, wouldn't it be a valid configuration
> for the user to specify:
> 
>    -device intel-iommu,caching-mode=off,intremap=on \
>    -device vfio-pci,host=05:00.0
> 
> so long as they never have any intention of the guest enabling DMA
> translation?  Would there be any advantage to this config versus
> caching-mode=on?  I suspect the overhead of CM=1 when only using
> interrupt remapping is small to non-existent, but are there other
> reasons for running with CM=0, perhaps guest drivers not supporting it?

AFAIU the major users of the vIOMMU should be guest DPDK apps and
nested device assignments.  For these users I would just make bold to
guess they are mostly using Linux so the majority should be safe.

For the minority, I do agree that above question is valid.  IMHO the
hard point is to find out those users and let them join the
discussion, then we can know how many will be affected and how.  I
think one way to achieve it could be that we merge the patchset like
this, then people will start to complain if there is any. :) I'm not
sure whether that's the best way to go.  I think that could still be a
serious option considering that it could potentially fix a more severe
issue (unexpected QEMU quits), and also reverting the patchset like
this one could be easy as well when really necessary (e.g., the
patchset will not bring machine state changes which might cause
migration issues, or so on).

> 
> I like the idea of being able to nak an incompatible hot-add rather
> than kill the VM, we could narrow that even further to look at not only
> whether caching-mode support is enabled, but also whether translation
> is enabled on the vIOMMU.  Ideally we might disallow the guest from
> enabling translation in such a configuration, but the Linux code is not
> written with the expectation that the hardware can refuse to enable
> translation and there are no capability bits to remove the DMA
> translation capability of the IOMMU.

This is an interesting view at least to me, while... I'm not sure we
should allow that even for emulation.  I'm just imaging such a patch
for the Linux kernel to allow failures on enabling DMAR - it'll be
only for QEMU emulation and I'm not sure whether upstream would like
such a patch.  After all, we are emulating the hardwares, and the
hardware will always succeed in enabling DMAR, AFAICT.  For Windows
and other OSs it could be even harder.  If without the support of all
these, we could simply have other risks of having hanging guests when
the driver is busy waiting for the DMAR status bit to be set.

> Still, we might want to think
> about which is the better user experience, to have the guest panic when
> DMA_GSTS_TES never becomes set (as it seems Linux would do) or to have
> QEMU exit, or as proposed here, prevent all configurations where this
> might occur.  Thanks,

Agreed.  So far, a stricter rule could be a bit better than a hanging
guest to me.  Though that could be very subjective.

Thanks!

-- 
Peter Xu

