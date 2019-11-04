Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D006CA9ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6437217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 22:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zh5bTwCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6437217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRkUc-0007HA-Mf
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 17:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iRkSB-0005Ll-FD
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iRkS9-0002Ym-8W
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:04:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58059
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iRkS8-0002Wn-Vg
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 17:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572905039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akEDGuqmyLyjEzXTVWFxLWJ5kunnV7xE1cf4kqLg+S8=;
 b=Zh5bTwCgF7+jB+K4R8vBVRzxDmUrScST1vdwNEn5y3OGzSVoyeVchaRMexA/NYsGlk0U96
 V7JPR2wdrb8Ik0L10qEaP4xuqvpISG2jJBBzdsFdZnuIeo/zGof6O1K5k2CM5vCQi1ZkBc
 7e0JAvm+akoPJK5tOMRf4s+3Nd3pUdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-dJscMvdHNHWw7OFDtCHVVw-1; Mon, 04 Nov 2019 17:03:58 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A90B107ACC2
 for <qemu-devel@nongnu.org>; Mon,  4 Nov 2019 22:03:57 +0000 (UTC)
Received: from x1.home (ovpn-116-110.phx2.redhat.com [10.3.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F27360BF3;
 Mon,  4 Nov 2019 22:03:54 +0000 (UTC)
Date: Mon, 4 Nov 2019 15:03:53 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org, mst@redhat.com
Subject: Re: [RESEND PATCH 0/2] PCI DMA alias support
Message-ID: <20191104150353.0a694812@x1.home>
In-Reply-To: <157187055395.5439.6693401317571144578.stgit@gimli.home>
References: <157187055395.5439.6693401317571144578.stgit@gimli.home>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dJscMvdHNHWw7OFDtCHVVw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 16:47:02 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Previous posting:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06182.html
>=20
> Rebased (no change) and added Peter's R-b.  Please apply for QEMU 4.2.

Anyone?  I suppose this has missed another release despite pings from
me, Peter, and a resend :-(

Alex
=20
> Previous cover letter:
>=20
> Please see patch 1/ for the motivation and utility of this series.
> This v1 submission improves on the previous RFC with revised commit
> logs, comments, and more testing, and the missing IVRS support for DMA
> alias ranges is now included.  Testing has been done with Linux guests
> with both SeaBIOS and OVMF with configurations of intel-iommu and
> amd-iommu.  Intel-iommu testing includes device assignment, amd-iommu
> is necessarily limited to emulated devices with interrupt remapping
> disabled and iommu=3Dpt in the guest (enabling interrupt remapping or
> disabling guest passthrough mode fails to work regardless of this
> series).  This series is NOT intended for QEMU v4.1.  Thanks,
>=20
> Alex
>=20
> ---
>=20
> Alex Williamson (2):
>       pci: Use PCI aliases when determining device IOMMU address space
>       hw/i386: AMD-Vi IVRS DMA alias support
>=20
>=20
>  hw/i386/acpi-build.c |  127 ++++++++++++++++++++++++++++++++++++++++++++=
+++---
>  hw/pci/pci.c         |   43 ++++++++++++++++-
>  2 files changed, 160 insertions(+), 10 deletions(-)


