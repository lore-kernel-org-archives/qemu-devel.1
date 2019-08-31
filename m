Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C30C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 02:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7AC423697
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 02:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AC423697
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3t4P-00037n-Gs
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 22:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1i3t3J-0002jE-Tx
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 22:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1i3t3G-0002Kz-Jb
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 22:23:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32940)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1i3t3G-0002HQ-EL
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 22:23:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C5B4E83F42;
 Sat, 31 Aug 2019 02:23:40 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75C9660BE1;
 Sat, 31 Aug 2019 02:23:40 +0000 (UTC)
Date: Fri, 30 Aug 2019 20:23:40 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Li Qiang <liq3ea@163.com>
Message-ID: <20190830202340.3815dde8@x1.home>
In-Reply-To: <5D69CE0F.011DCE.26140@m12-11.163.com>
References: <5D69CE0F.011DCE.26140@m12-11.163.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Sat, 31 Aug 2019 02:23:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Questions about 'emulated_config_bits' in vfio pci
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
Cc: Alex Williamson <alex.l.williamson@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 31 Aug 2019 09:31:59 +0800
Li Qiang <liq3ea@163.com> wrote:

> Hi Alex and all,
>=20
> My understanding for =E2=80=98emulated_config_bits=E2=80=99 in =E2=80=98V=
FIOPCIDevice=E2=80=99 is
> that this is the mask for PCI config space. If the bits is set in =E2=80=
=98
> emulated_config_bits=E2=80=99 then we can just use the qemu=E2=80=99s
> =E2=80=98vdev->pdev.config=E2=80=99, it the bits is not set, we need to a=
sk the
> physical device.=20

Yes.

> But there are two places I got confused in =E2=80=98vfio_realize=E2=80=99.
>=20
> Here in =E2=80=98vfio_realize=E2=80=99
>     /* QEMU can change multi-function devices to single function, or
> reverse */ vdev->emulated_config_bits[PCI_HEADER_TYPE] =3D
>                                               PCI_HEADER_TYPE_MULTI_FUNCT=
ION;
>=20
> In =E2=80=98vfio_add_std_cap=E2=80=99
>=20
>         /* Begin the rebuild, use QEMU emulated list bits */
>         pdev->config[PCI_CAPABILITY_LIST] =3D 0;
>         vdev->emulated_config_bits[PCI_CAPABILITY_LIST] =3D 0xff;
>         vdev->emulated_config_bits[PCI_STATUS] |=3D PCI_STATUS_CAP_LIST;
>=20
>=20
> Per my understanding, I think =E2=80=98emulated_config_bits=E2=80=99 shou=
ld be set to
> 0xff just as other places. But here use
> =E2=80=98PCI_HEADER_TYPE_MULTI_FUNCTION=E2=80=99 and =E2=80=98PCI_STATUS_=
CAP_LIST=E2=80=99. In fact,
> this doesn=E2=80=99t affect the results, but it=E2=80=99s confusion. Just=
 a typo? Or
> other reasons.

I'm not sure I understand the question.  We're only trying to emulate
the multi-function bit of the header-type register and the capability
list bit of the status register, therefore we set only these bits in
the emulated bits mask.  The header type is static, so it doesn't make
much difference if we emulate the entire 8-bit register or only this
bit (I don't think it's worth the optimization and doing so potentially
masks what we're trying to accomplish).  The status register though is
partially static and partially dynamic, some bits are reporting the
current device status.  So I don't see that we'd ever want to emulate
all of the bits in that register.  emulate_config_bits has bit level
granularity to which bits of config space are emulated in QEMU, so
we're not always going to set a full byte for emulation.  Thanks,

Alex

