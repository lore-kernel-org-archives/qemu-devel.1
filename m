Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9E4C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7230E2087B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 10:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7230E2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huaew-0005T0-Qb
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 06:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49958)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tgolembi@redhat.com>) id 1huaeZ-0004xn-Rm
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgolembi@redhat.com>) id 1huaeY-0007o6-Ny
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:55:47 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36150)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1huaeY-0007nT-Gn
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 06:55:46 -0400
Received: by mail-wm1-f42.google.com with SMTP id g67so68430799wme.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 03:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=SH3sywiYGik9zV3wlOlcKPjnoZWf8+bGX1xawRu7wt4=;
 b=hH55lMDzIxeO7AFIa+Phl8AffJUXTEfORsx6Noqpgn6d2m2aRi6pU6ZGoU10QG9a4K
 bVpfL2FJbpID4Yohf5es+EfyMvqBrCyhfwchZOL/v/0fdWO8CehwmPZvokv43vpC3JAw
 +jD6zv2mOzNt5gyvTjEjVNP75O4hOlkiXHAeeNe6K97UwSq/1p4KYNSrCdQlWjLdPQpJ
 ykaXVLzbLxcEV+l+xB5ydzLv5jDp+vFyG7aZFjT+VH1+FBmESVIAgr5zpQ2lh+5L/nlk
 puoD4gVm0fx624sikRQA0wo7eygTEMKkjL0Qm4InEfpVs58vH6l9V/NL+q1Ap9ASfral
 2w9Q==
X-Gm-Message-State: APjAAAWDLwaWI0anNCe49DglWMTaR54NxZ0JjaxlsskvHs5W9Yl+ahGy
 OA+C+LYhdzv8e/ZCloh8RaZWxw==
X-Google-Smtp-Source: APXvYqweUtA5LxokYc/MMOMzxqIBflM1jyQuMWus4Cggm3d9gPK2OZe1+WBu9HsjlLQ8M24HwZnWnA==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr17763793wmf.119.1565002544774; 
 Mon, 05 Aug 2019 03:55:44 -0700 (PDT)
Received: from auriga.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 n12sm87949611wmc.24.2019.08.05.03.55.43
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 03:55:44 -0700 (PDT)
Date: Mon, 5 Aug 2019 12:58:26 +0200
From: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190805105825.bjsz3wg76imjspeb@auriga.localdomain>
References: <20190802131509.lplyvrbdwiwo2tve@auriga.localdomain>
 <CAMxuvawykqui1GA4ojF5gdPwzOF5ETWnaGMhxyC97FR=HmB7DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawykqui1GA4ojF5gdPwzOF5ETWnaGMhxyC97FR=HmB7DQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.42
Subject: Re: [Qemu-devel] qemu-ga -- virtio driver version reporting
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
Cc: Gal Hammer <ghammer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 03, 2019 at 05:07:09PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Aug 2, 2019 at 5:12 PM Tomáš Golembiovský <tgolembi@redhat.com> wrote:
> >
> > Hi,
> >
> > I would like to add version reporting of Windows virtio drivers to qemu-ga.
> > Obviously this is specific to Windows as for POSIX systems it corelates with
> > the version of kernel. I would appreciate your ideas on a few topics.
> >
> > Does it make sense to add this information as new (optonal) field to result of
> > 'guest-get-osinfo'. Or would it be better to add whole new command? I expect
> 
> If the information is cheap to retrieve, I think it is fine as part of
> get-osinfo.

Hmm, good point. Actually fetching the list takes several seconds. A
special command may be preferable.

> 
> > the result to look something like this:
> >
> >     "component-versions": [
> >         {
> >             "name": "VirtIO Balloon Driver",
> >             "version": "03/10/2019,62.77.104.16900"
> >         },
> >         {
> >             "name": "QEMU PVPanic Device",
> >             "version": "06/11/2018,62.76.104.15400"
> >         },
> >         ...
> >     ]
> 
> I am not a Windows expert, but I can imagine drivers have a more
> uniquely identifiable ID than a human string.

I am not an expert either, but I don't see any unique identifier. Don't
see anything like that in INF files nor in API.

But another option would be to list the actual hardware and match it by
vendor IDs. Then list the driver name and version that is assigned to
the hardware. The up-side of this would be that one would also notice
situation where there is unsuitable driver (e.g. generic display driver
on QXL device).

> 
> >
> > Alternatively we could report all available versions of the specific
> > driver instead of just the latest. Note that this does not say much
> > about which version is in use or if a device is available in the
> > system.
> 
> What's the goal of this version reporting btw? to audit the VM? Isn't
> there other mechanism to keep Windows systems up to date and alert
> management layers? Perhaps that's Windows business/enterprise
> solutions that are too expensive though, and we want something more
> specific to qemu VMs.

The goal is to notify admin when there is old driver in the guest so
that he/she can update.

The "enterprise" solution you speak of is called Windows Update. The
problem is however two-fold. Virtio drivers are not yet available
through Windows Update. While the topic has been on the table for many
years it is still work-in-progress. But even when we get the drivers
into Windows Update, there are administrators who have automatic updates
disabled and prefer to do updates in a controlled manner. 


> > I have checked the available drivers and the names quite vary. I guess we'll
> > need to list and match the complete name and not just some substring (like
> > "VirtIO"). See the following list:
> >
> >     QEMU FWCfg Device
> >     QEMU PVPanic Device
> >     QEMU Serial PCI Card
> >     Red Hat Q35 SM Bus driver
> >     Red Hat QXL controller
> >     Red Hat VirtIO Ethernet Adapter
> >     Red Hat VirtIO SCSI controller
> >     Red Hat VirtIO SCSI controller
> >     Red Hat VirtIO SCSI pass-through controller
> >     VirtIO Balloon Driver
> >     VirtIO Input Driver
> >     VirtIO RNG Device
> >     VirtIO Serial Driver
> >     VirtIO-Serial Driver
> >
> > Is it OK to hardcode the list in qemu-ga source? Is there already any support
> > for dealing with regexes or tries in qemu source tree?
> 
> glib has GRegexp.

Ah, good!

    Tomas

> 
> >
> > Any other ideas, concerns?
> >
> >     Tomas
> >
> > --
> > Tomáš Golembiovský <tgolembi@redhat.com>

-- 
Tomáš Golembiovský <tgolembi@redhat.com>

