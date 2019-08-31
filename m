Return-Path: <SRS0=aRDT=W3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94176C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 02:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538A22343B
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2019 02:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="C62sukx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538A22343B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3tOr-00065Y-H8
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 22:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1i3tNR-0005VZ-1s
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 22:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1i3tNO-000336-8w
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 22:44:31 -0400
Received: from m12-11.163.com ([220.181.12.11]:54452)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <liq3ea@163.com>) id 1i3tNM-0002rb-2t
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 22:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=MIME-Version:From:Subject:Date:Message-Id; bh=+6Uix
 7AwjX2mZXtpIQ2/UYjvB8gPno+EIQrFLclxWpc=; b=C62sukx8x+D4UAHNXFlw8
 watYdo+/dWt3Dgcq3XKK6sy2HcRx+81k1RsPz+lgRolHwEwTTFtDOPJJW8wnQekw
 AY9KZPl5ZIw5nOl9k6u0BF/FJTSeUZ5vKnMVZDJ9hx2b07szwTcxPI9R+jewMYe4
 EJ1u/oxORrQhtnb7pyiKP4=
Received: from [IPv6:::ffff:192.168.0.5] (unknown [183.158.152.47])
 by smtp7 (Coremail) with SMTP id C8CowAAHhxsE32ldnHecLA--.48889S3;
 Sat, 31 Aug 2019 10:44:21 +0800 (CST)
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
From: Li Qiang <liq3ea@163.com>
Date: Sat, 31 Aug 2019 10:44:22 +0800
Importance: normal
X-Priority: 3
In-Reply-To: <20190830202340.3815dde8@x1.home>
References: <5D69CE0F.011DCE.26140@m12-11.163.com>
 <20190830202340.3815dde8@x1.home>
X-CM-TRANSID: C8CowAAHhxsE32ldnHecLA--.48889S3
Message-Id: <5D69DF05.02B605.26140@m12-11.163.com>
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4fAr1UWryrKFy8Xr1rXrb_yoW8Kr13p3
 y3uFy3JryDZr15tr45XrWxJFW8ZFsrtrWrZFy5XFySkr15GFyxXr4qgFy5J3ZrJrZ7ArWF
 vrZ5KF97Way3ZrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U_cTdUUUUU=
X-Originating-IP: [183.158.152.47]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTwUibVsGRD9WxwAAsy
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 220.181.12.11
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] =?utf-8?b?562U5aSNOiAgUXVlc3Rpb25zIGFib3V0ICdlbXVs?=
 =?utf-8?q?ated=5Fconfig=5Fbits=27_in_vfio_pci?=
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

So detailed explanation, I got the point.

Thank you Alex!

Li Qiang


=E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Williamson
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2019=E5=B9=B48=E6=9C=8831=E6=97=A5 10=
:23
=E6=94=B6=E4=BB=B6=E4=BA=BA: Li Qiang
=E6=8A=84=E9=80=81: Alex Williamson; qemu-devel@nongnu.org
=E4=B8=BB=E9=A2=98: Re: [Qemu-devel] Questions about 'emulated_config_bits'=
 in vfio pci

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

> But there are two places I got confused in =E2=80=98vfio_realize=E2=80=99=
.
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

