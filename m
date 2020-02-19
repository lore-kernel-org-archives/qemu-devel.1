Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DD3C34050
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:17:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2119824671
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9sIvTcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2119824671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4R65-0002l8-CD
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:17:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j4R5M-0002Hu-5V
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j4R5K-000490-K3
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:16:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j4R5K-00045f-BJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582125380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6QDF/BGK4BnK9ToY8uSAqT50pIMA2PFZvvccA+WN6uQ=;
 b=O9sIvTcBIfjQQRQ+9WnkzCsmCI+IBoNfvpLYCOAPwbfnbxUj2ahtHspKsnXE7NfF9wIm3T
 YFBcMefwRfzPH0cvaXscA4jnH6HYWW0TmmQ/fNlMDI2BL1MAZ/hx/FaL1mGxbfwEPI/ZXo
 8rNlZ2vGCS6Pb+ueVRuQAgm+VuUk4NU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-XYx3MObBPrO9xiMBrhvHsg-1; Wed, 19 Feb 2020 10:16:12 -0500
X-MC-Unique: XYx3MObBPrO9xiMBrhvHsg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15BED107B273
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 15:16:12 +0000 (UTC)
Received: from lpt (ovpn-200-50.brq.redhat.com [10.40.200.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F226484779;
 Wed, 19 Feb 2020 15:16:02 +0000 (UTC)
Date: Wed, 19 Feb 2020 16:15:59 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH v2] pcie_root_port: Add enable_hotplug option
Message-ID: <20200219151559.GE3992@lpt>
References: <20200219145540.648365-1-jusual@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200219145540.648365-1-jusual@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/2994txjAzEdQwm5"
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

--/2994txjAzEdQwm5
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 03:55:40PM +0100, Julia Suvorova wrote:
>Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
>manage it and restrict unplug for the whole machine. This is going to
>prevent user-initiated unplug in guests (Windows mostly).
>Hotplug is enabled by default.
>Usage:
>    -device pcie-root-port,enable-hotplug=3Dfalse,...
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
>v2:
>    * change name of the option to 'enable-hotplug' [Laine]
>    * change order of enabling capability bits [Igor]
>    * enable HPS bit [Igor]
>    * add option to xio3130_downstream [J=E1n]
>
> hw/pci-bridge/pcie_root_port.c     |  3 ++-
> hw/pci-bridge/xio3130_downstream.c |  3 ++-
> hw/pci/pcie.c                      | 11 +++++++----
> include/hw/pci/pcie.h              |  2 +-
> include/hw/pci/pcie_port.h         |  1 +
> 5 files changed, 13 insertions(+), 7 deletions(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--/2994txjAzEdQwm5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5NUSwACgkQ+YPwO/Ma
t50hugf/ZoQORTRH/O7XocU4fyNJlzDvM6tHVpsMgvpyONhUqzq2uS0c7AMIL47g
kdYY/VeaGOtx4NMKl1Q4VKKN0Zvd27IEcFYuUtNxbjBK8N9zuO3EMmfNoDDlb7nX
GdWYVdR8tfSwJuArSjBaL8C2l08pRZwSyChVrJhQrMx9hAmPXNIziHncI+jDXDQE
JsL8IgjdcuhUi5vq3vEbSeksWdnWoX0lPxxglyPB971OEBwgvpXFL//MuWsJGJ7c
lYKYIVOAt49VMWCnUrVWs3lptwpyHFh1EnyNcS79xJPySYhR+3wExxT20J3vRZ7p
JwvKRdhK/wYzTKbXv/QAtemWSRaQpA==
=oHTt
-----END PGP SIGNATURE-----

--/2994txjAzEdQwm5--


