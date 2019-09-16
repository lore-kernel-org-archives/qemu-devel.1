Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75610C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 03:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47055206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 03:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47055206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9ho6-0007Q0-HI
	for qemu-devel@archiver.kernel.org; Sun, 15 Sep 2019 23:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57405)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1i9hnJ-0006vG-Da
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:35:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1i9hnH-0003h0-LM
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:35:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1i9hnH-0003gZ-BF
 for qemu-devel@nongnu.org; Sun, 15 Sep 2019 23:35:15 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2E394C059B7A
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 03:35:14 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id v3so19774990pff.4
 for <qemu-devel@nongnu.org>; Sun, 15 Sep 2019 20:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1Nna47Iikl1N0ydAaQUtB54jP0EYr+/6I67YefDRvsc=;
 b=kHJ8xdbHPcfAALYqqNOpuEEIuwERP4sJBzM1Ayx5yVdE3iusSlvO+YnG8bn4AgqE+y
 fqEvShR2VP3s450DXyq72ZAfvzRG5hm/pOszFUXkv8zBEhVUrzilbRG+i57gk1vgFacK
 Pd2lWHjBD8dsSjYbMRxrFyCz3ngtGM+sdzJ9cmcC/Y29pyF14CIu9rhGOlQs0c86nmqO
 CUOnCXqiTMsW/dcNWX2DuoX+INpuCFDMmiA6dslmRWtbUZyrxMxsboCdiYW7uRjHO+Af
 y+OatTMpev8dnyqDcdfJBxLUP3cfOCmguRq5GCQhxWeOO8EdxdgFjBnzOQ9sRxg1dd8B
 pA/A==
X-Gm-Message-State: APjAAAW7Xb3Qgbfv+CZ8k5rU9NNAb0wo+80LSUe8jkvPNtOLZ5bojjR3
 MLWY1gMWXQ1EH1LJenceP7jAPs6n/bda7hxPigLb65Iw3xKFMpSHQw08V9nw1Nyk6zewUs3VRUv
 Dn5Y/j+dKGYVEPis=
X-Received: by 2002:aa7:8ad7:: with SMTP id b23mr4286943pfd.254.1568604913675; 
 Sun, 15 Sep 2019 20:35:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyDHqVJCvXRNoCZgUb5T/jaBJATCe/ClEnomXipuSzwMRA2z1R8U+FkjBtRtZXVAlSY7eNUjQ==
X-Received: by 2002:aa7:8ad7:: with SMTP id b23mr4286934pfd.254.1568604913506; 
 Sun, 15 Sep 2019 20:35:13 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g8sm28637338pgk.1.2019.09.15.20.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Sep 2019 20:35:12 -0700 (PDT)
Date: Mon, 16 Sep 2019 11:35:02 +0800
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190916033501.GE14232@xz-x1>
References: <20190812074531.28970-1-peterx@redhat.com>
 <20190820052240.GG13560@xz-x1>
 <f8e320ca-8c24-a562-1f5b-e55bd5c64d4a@redhat.com>
 <20190821050302.GA25454@xz-x1>
 <8106168f-1648-5823-8a69-f93638c74c66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8106168f-1648-5823-8a69-f93638c74c66@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Bandan Das <bsd@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 21, 2019 at 09:50:43AM +0200, Paolo Bonzini wrote:
> On 21/08/19 07:03, Peter Xu wrote:
> > On Tue, Aug 20, 2019 at 08:24:49AM +0200, Paolo Bonzini wrote:
> >> On 20/08/19 07:22, Peter Xu wrote:
> >>> On Mon, Aug 12, 2019 at 09:45:27AM +0200, Peter Xu wrote:
> >>>> This is a RFC series.
> >>>>
> >>>> The VT-d code has some defects, one of them is that we cannot detect
> >>>> the misuse of vIOMMU and vfio-pci early enough.
> >>>>
> >>>> For example, logically this is not allowed:
> >>>>
> >>>>   -device intel-iommu,caching-mode=off \
> >>>>   -device vfio-pci,host=05:00.0
> >>>>
> >>>> Because the caching mode is required to make vfio-pci devices
> >>>> functional.
> >>>>
> >>>> Previously we did this sanity check in vtd_iommu_notify_flag_changed()
> >>>> as when the memory regions change their attributes.  However that's
> >>>> too late in most cases!  Because the memory region layouts will only
> >>>> change after IOMMU is enabled, and that's in most cases during the
> >>>> guest OS boots.  So when the configuration is wrong, we will only bail
> >>>> out during the guest boots rather than simply telling the user before
> >>>> QEMU starts.
> >>>>
> >>>> The same problem happens on device hotplug, say, when we have this:
> >>>>
> >>>>   -device intel-iommu,caching-mode=off
> >>>>
> >>>> Then we do something like:
> >>>>
> >>>>   (HMP) device_add vfio-pci,host=05:00.0,bus=pcie.1
> >>>>
> >>>> If at that time the vIOMMU is enabled in the guest then the QEMU
> >>>> process will simply quit directly due to this hotplug event.  This is
> >>>> a bit insane...
> >>>>
> >>>> This series tries to solve above two problems by introducing two
> >>>> sanity checks upon these places separately:
> >>>>
> >>>>   - machine done
> >>>>   - hotplug device
> >>>>
> >>>> This is a bit awkward but I hope this could be better than before.
> >>>> There is of course other solutions like hard-code the check into
> >>>> vfio-pci but I feel it even more unpretty.  I didn't think out any
> >>>> better way to do this, if there is please kindly shout out.
> >>>>
> >>>> Please have a look to see whether this would be acceptable, thanks.
> >>>
> >>> Any more comment on this?
> >>
> >> No problem from me, but I wouldn't mind if someone else merged it. :)
> > 
> > Can I read this as an "acked-by"? :)
> 
> Yes, it shouldn't even need Acked-by since there are other maintainers
> that handle this part of the tree:
> 
> Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
> Richard Henderson <rth@twiddle.net> (maintainer:X86 TCG CPUs)
> Eduardo Habkost <ehabkost@redhat.com> (maintainer:X86 TCG CPUs)
> "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
> Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)

Michael (or any maintainers listed above):

Do any of you have any further comment on this series?  Do any of you
like to merge this?

Thanks,

-- 
Peter Xu

