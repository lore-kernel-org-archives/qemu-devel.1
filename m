Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA86C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 988DA20842
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 10:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+M8rNxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 988DA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1TF9-00011M-Qb
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 05:58:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36836)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j1TEH-0000Eb-Og
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j1TEG-0004ac-KM
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:57:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60191
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j1TEG-0004aG-FR
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 05:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581418639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dy4/YtJ4c+Odf/AzfJpD5mThxSf8kRCal2fy6W3KRz0=;
 b=Y+M8rNxVfK3IQuyJBgXvsDNODDfsJz2GJrVDORR2GLTe0nZCpsJXSAlPRc3hv43abE8hGo
 kGb2IGxFeKK5RqkQopSPf259eAyuKkG6AEzMAghdG7UPLmTWmka9MZzH1TIBrPo6XJjawY
 zsvSjYIKf8oAWc1EX8KcBpd39URijJA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-TDdIkVplNNe-_un75j5ZkQ-1; Tue, 11 Feb 2020 05:57:15 -0500
Received: by mail-qv1-f72.google.com with SMTP id p3so6913791qvt.9
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 02:57:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zHDZin+UZkvf57OXTiAEW8DlkByJ4zhgnoIg7b8L+NE=;
 b=OpCobA9K90GYNZgz7ilJeUkrhgSSxTOVbAVCizQtQWT5sDvskaN0+xJF7/CgiorJcA
 0zhqx98qSVdJ6jLI1GmJnESwEDjt8gADfX0EKez/kt3HN27bRbtE3aE4UkyAEARlYcwB
 AR/uirS3lw77AHFUWSHan4UyIX6EiV/lHv36hoVWhLcTXOWAeqTF01iAkl5Tc0NSMRNd
 T26/Pjp+co9zjkXeHDa/FSCcb8tQhLWCGWE2PxsE2D8nVM81vANgodjGLZgjgnX4zqR6
 7hAyd+jkFmIifjEouYwRYBjtdKEnLoDCBccEzFoddWN6NvvQJNtWB/TJvTC75QNXHhjZ
 7FpA==
X-Gm-Message-State: APjAAAX1uBwBs49fEkw147IP7NlbSd+y0gikgiT0l6oJVhZZotgnoM2U
 bQRHNioNF5CW01NxW3DphX7tg6i8P2k4ndJ3hTZUy6OcCXMd16w7ZmTxnfbyUqLe9A4MHh8bAyx
 6uDl1TsL5ipYkJxc=
X-Received: by 2002:ac8:6618:: with SMTP id c24mr1791416qtp.327.1581418634810; 
 Tue, 11 Feb 2020 02:57:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcqApMTJKfRU4KaIK2j3dYSSGgI3NBh3ICYMKJb9stGPpMG+yyEwb6XYA+WHcmJ3qLyBYqvA==
X-Received: by 2002:ac8:6618:: with SMTP id c24mr1791404qtp.327.1581418634534; 
 Tue, 11 Feb 2020 02:57:14 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id z1sm1872926qtq.69.2020.02.11.02.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 02:57:13 -0800 (PST)
Date: Tue, 11 Feb 2020 05:57:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chao Peng <chao.p.peng@linux.intel.com>
Subject: Re: [PATCH v2 0/5] virtio mmio specification enhancement
Message-ID: <20200211053953-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <20200210062938-mutt-send-email-mst@kernel.org>
 <20200211160541.GA37446@chaop.bj.intel.com>
MIME-Version: 1.0
In-Reply-To: <20200211160541.GA37446@chaop.bj.intel.com>
X-MC-Unique: TDdIkVplNNe-_un75j5ZkQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>,
 slp@redhat.com, jasowang@redhat.com, jing2.liu@linux.intel.com,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, gerry@linux.alibaba.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 11, 2020 at 04:05:41PM +0000, Chao Peng wrote:
> On Mon, Feb 10, 2020 at 06:44:50AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Feb 10, 2020 at 05:05:16PM +0800, Zha Bin wrote:
> > > We have compared the number of files and the lines of code between
> > > virtio-mmio and virio-pci.
> > >=20
> > > =09=09=09=09Virtio-PCI=09    Virtio-MMIO=09
> > > =09number of files(Linux)=09    161=09=09=091
> > > =09lines of code(Linux)=09    78237=09=09538
> >=20
> >=20
> >=20
> > Something's very wrong here. virtio PCI is 161 files?
> > Are you counting the whole PCI subsystem?
>=20
> Right, that is just a rough statistics.

Please try not to make them look so wrong then.
E.g. you don't include drivers/base/platform-msi.c for
mmio do you? Your patch brings a bunch of code in there.

> Surely enough, some drivers will
> never get enabled in a typcial config.
>=20
> > Sure enough:
> >=20
> > $ find drivers/pci -name '*c' |wc -l
> > 150
>=20
> and plus:
> $ find arch/x86/pci/ -name '*c' |wc -l
> 22

But what's the point? This is code that is maintained by PCI core
people anyway.

> >=20
> > That's not reasonable, this includes a bunch of drivers that
> > never run on a typical hypervisor.
> >=20
> > MMIO is also not as small as you are trying to show:
> >=20
> > $ cloc drivers/virtio/virtio_mmio.c include/uapi/linux/virtio_mmio.h
> >        2 text files.
> >        2 unique files.                             =20
> >        0 files ignored.
> >=20
> > github.com/AlDanial/cloc v 1.82  T=3D0.01 s (230.7 files/s, 106126.5 li=
nes/s)
> > -----------------------------------------------------------------------=
--------
> > Language                     files          blank        comment       =
    code
> > -----------------------------------------------------------------------=
--------
> > C                                1            144            100       =
     535
> > C/C++ Header                     1             39             66       =
      36
> > -----------------------------------------------------------------------=
--------
> > SUM:                             2            183            166       =
     571
> > -----------------------------------------------------------------------=
--------
> >=20
> >=20
> > I don't doubt MMIO is smaller than PCI. Of course that's because it has
> > no features to speak of - just this patch already doubles it's size. If
> > we keep doing that because we want the features then they will reach
> > the same size in about 4 iterations.
>=20
> Since current virtio-mmio size is small enough, so adding any notable
> feature would easily double it.

But really unlike PCI this is just PV stuff that is not reused by
anyone. We end up maintaining all this by ourselves.

> I have no objection that it may one day
> reach the same level of PCI, but in this patch some are actually
> generic changes and for MSI specific code we provide the option to
> confige away.
>=20
> Thanks,
> Chao

The option will make it fall down at runtime but
it does not actually seem to remove all of the overhead.



> >=20
> >=20
> > --=20
> > MST


