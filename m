Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D0EC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD992467F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 08:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drisiGG2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD992467F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7EMI-0002BL-V3
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 03:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j7EKk-00019j-89
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:15:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j7EKi-0006DQ-Ii
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:15:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26343
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j7EKi-0006DA-E8
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 03:15:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582791347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CvONgG00nAtPaoceucsYJoqisFX0D2LHlnvB6Go/vrY=;
 b=drisiGG2ZoyFjPYEsxqtPsxZE+glRDcxdzjJPBS46pUkjLD3PAlpA5VqoyfKy0HG6PZQD9
 PERRRxqbSDnLjW6xj9oqEL5tGrESn/EtnjiR75oEeuX4nwe16v9QekOvL76rn/+iE1udKo
 c8cXA4yN/BLcKr5HpGXgisjgeBsMATk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Tycj2z5_M2m6XIhNYr6w3A-1; Thu, 27 Feb 2020 03:15:41 -0500
X-MC-Unique: Tycj2z5_M2m6XIhNYr6w3A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84A92107B7D4
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 08:15:40 +0000 (UTC)
Received: from lpt (unknown [10.43.2.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CC9B9051C;
 Thu, 27 Feb 2020 08:15:30 +0000 (UTC)
Date: Thu, 27 Feb 2020 09:15:28 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH v3] pcie_root_port: Add hotplug disabling option
Message-ID: <20200227081528.GA2262365@lpt>
References: <20200226174607.205941-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226174607.205941-1-jusual@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On a Wednesday in 2020, Julia Suvorova wrote:
>Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
>manage it and restrict unplug for the whole machine. This is going to
>prevent user-initiated unplug in guests (Windows mostly).
>Hotplug is enabled by default.
>Usage:
>    -device pcie-root-port,hotplug=3Doff,...
>
>If you want to disable hot-unplug on some downstream ports of one
>switch, disable hot-unplug on PCIe Root Port connected to the upstream
>port as well as on the selected downstream ports.
>
>Discussion related:
>    https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00530.html
>
>Signed-off-by: Julia Suvorova <jusual@redhat.com>
>---
>v1: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04868.html
>
>v2: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg05192.html
>    * change name of the option to 'enable-hotplug' [Laine]
>    * change order of enabling capability bits [Igor]
>    * enable HPS bit [Igor]
>    * add option to xio3130_downstream [J=E1n]
>
>v3:
>    * change name of the option to 'hotplug'. Naming is hard! [Laine]
>    * move property under TYPE_PCIE_SLOT [Michael]
>
> hw/pci-bridge/pcie_root_port.c     |  2 +-
> hw/pci-bridge/xio3130_downstream.c |  2 +-
> hw/pci/pcie.c                      | 11 +++++++----
> hw/pci/pcie_port.c                 |  1 +
> include/hw/pci/pcie.h              |  2 +-
> include/hw/pci/pcie_port.h         |  3 +++
> 6 files changed, 14 insertions(+), 7 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5XepwACgkQ+YPwO/Ma
t53HewgAs0k6e3UOpwXlDlkxi1HaWpSsNl0xCTiyVkAbQf4+sMXyld+tOodHg/wB
0f/+qstxi1G5lfL/s8XWiBpXCXGev+nrVoqbDjoA5HgX0EftaZwMBWbkCEJTnJfB
V9cLTcWlV/lYKGDikh6axdlJEoXTmBKkOZDsYSxzqUuq66i1uvelKd6RQ6InHTpI
SLJpRBmfT17d2Vpk86tk/eIxn1R7C/dOlpW1aimrEwI1TFnSooSW6xh+pDJ7UNaP
8+Zc9+ZiZnh0MydDf0wOt/ZVk43X56swmbrf78hX5q0Q2ew3HGkrEO+WuR5HDPUw
UBCbmh7EyS6t5D5S4LVR9gdJieJTIA==
=Bhxc
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--


