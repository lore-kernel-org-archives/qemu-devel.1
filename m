Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B751BC34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A802464E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="BeUFetQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A802464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46fq-00055Y-3w
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1j46er-0004AY-Vz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:27:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1j46eq-0006T9-O6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:27:41 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::1]:9000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1j46eq-0006Qq-1v
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582046855;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=Ff/wq2qeTBvgVwlC81ubw2qkKaUmpRrx0qp7mJ3m5fE=;
 b=BeUFetQ/E0TFMwj6tYLSPN7Bg3bvTeHwc+hN7cln2z41BLhvXxVtCumFxXa+CEzzOT
 lNphFzk8AXi5KFWQypi5RFpgDv3LAHKPLKJG//XzIktcVZFO3RNbIsj0O51iv/Df4zFR
 3NAzAxkpDmb9MOf7tPNBQPofqXx5NYUSaMIMDvxStVv38yTGL5czZf0RsN3uvDlE4s11
 hoikgVFO8qKR/iVzI5qgfTz+4q7JWYKYLN8JmuYnp5UiEUj1wQGkrb54I+YoCvy5e12P
 gKogFJx8fduF6AadP7vERfzl61ArGQjUbVwFC92kOVIXSuEuKYY4BwnrAKo33GJuzWCe
 SMvw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYMlkjQ=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.12 SBL|AUTH)
 with ESMTPSA id 605caew1IHRYEfA
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 18 Feb 2020 18:27:34 +0100 (CET)
Date: Tue, 18 Feb 2020 18:27:28 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Durrant <pdurrant@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard
 <anthony.perard@citrix.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200218182728.4b7f17b7.olaf@aepfle.de>
In-Reply-To: <20200127100951.0803d167.olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
 <20200127100951.0803d167.olaf@aepfle.de>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/=Z.Dw7LDdvHEakSPEF3OwCo"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::1
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/=Z.Dw7LDdvHEakSPEF3OwCo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

The approach below (making 'xenfv' an alias of 'pc') does not work:
xen_enabled() is false when pc_i440fx_3_1_machine_options runs.

So, how is this incompatibility between qemu2/3 and qemu4+ supposed to be f=
ixed?
Using '-machine pc,accel=3Dxen -device xen-platform' is incompatible with '=
-machine xenpv' because the platform device has a different PCI address. As=
 such it is not migrateable.

Olaf

Am Mon, 27 Jan 2020 10:09:51 +0100
schrieb Olaf Hering <olaf@aepfle.de>:

> Am Mon, 20 Jan 2020 11:18:41 +0000
> schrieb Paul Durrant <pdurrant@gmail.com>:
>=20
> > On Fri, 17 Jan 2020 at 13:06, Olaf Hering <olaf@aepfle.de> wrote: =20
> > > What would future domUs lose if 'xenfv' would be locked to 'pc-i440fx=
-3.0'? =20
>=20
> > I guess eventually that pc type would be removed and then we'd have a
> > compat issue. Ideally I think libxl should simply not use xenfv and
> > then it can be deprecated and removed, and then such issues can be
> > dealt with directly in xl/libxl. =20
>=20
> I think this does not answer the question at all.
> What future versions of libxl do is one thing.
> What existing versions of libxl do with future versions of qemu is anothe=
r.
>=20
>=20
> IMO it was wrong to map "xenfv" to "pc", simply because it entirely
> ignores live migration. We were just lucky until qemu-3.1. Maybe the
> creators of 'xenfv' just meant it to be "do everything to make it
> compatible with HVM".
>=20
> What about a variant of this change, to lock 'xenfv' to 'qemu-3.0'?
>=20
>=20
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -490,6 +490,13 @@ static void pc_i440fx_3_0_machine_options(MachineCla=
ss *m)
>      pc_i440fx_3_1_machine_options(m);
>      compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
>      compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
> +
> +    m->alias =3D "xenfv";
> +    if (xen_enabled()) {
> +        m->desc =3D "Xen Fully-virtualized PC";
> +        m->max_cpus =3D HVM_MAX_VCPUS;
> +        m->default_machine_opts =3D "accel=3Dxen";
> +    }
>  }
> =20
>  DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
> @@ -500,6 +507,7 @@ static void pc_i440fx_2_12_machine_options(MachineCla=
ss *m)
>      pc_i440fx_3_0_machine_options(m);
>      compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len=
);
>      compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len=
);
> +    m->alias =3D NULL;
>  }
> =20
>  DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
> @@ -946,14 +954,3 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
>                    isapc_machine_options);
> =20
> =20
> -#ifdef CONFIG_XEN
> -static void xenfv_machine_options(MachineClass *m)
> -{
> -    m->desc =3D "Xen Fully-virtualized PC";
> -    m->max_cpus =3D HVM_MAX_VCPUS;
> -    m->default_machine_opts =3D "accel=3Dxen";
> -}
> -
> -DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
> -                  xenfv_machine_options);
> -#endif
>=20
>=20
> Olaf


--Sig_/=Z.Dw7LDdvHEakSPEF3OwCo
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl5MHoAACgkQ86SN7mm1
DoDlhhAAo+DqI2O/IG3kln4cdAJjdASJfEMVjsKUqKoM0fiVW+Flo7NoSn2R6yrj
tcfloiCnTgXfYt4Sa+x9N1RoQtETaf8wT+FPdtlYLIKj3Gh7mt8GmRcQH9BIKgCc
M19GZEWBdYXNzGTBRQWyRActSV4MxU6txgUlWu3YHn5xfDE29R0y22X0FQVrqcdD
tB88DXeo8htPX6r/EzJeIjxvlQgCqPnvRMSIPVVF1Ei9d/L92qJdiQWvtU4k6Cun
odtfyAVmS1WEitL6JoZZ3nbBngr7E/O+SHh5AuOeD7TW6AZEJpFruz8j/8GG5Ui9
mjNr0MQ6bmvoJMQZjBYahhquE9WBiLKB7n2KvLuiap5mLIIhcuud+/5WViEEs3BO
l3NRol3FrFVSSKeRhWS/V0J3YZZ6PgAZOT8Zlp/ovEQCyZnAL8xMsY7tNXkBUUWG
GJOUqNA5npagbZFCDPkvkTFBgCRMgFxnyGkkktl1cdaB0SHFAyIIKAG7GZegI4mw
brp9xXKiox/jCQdc+irvXLnFjYJodW+lfLrhNratuOwQv8ke1mGmCxEsDAHEQBzA
mkH7iqcR53o32vrVo8P57xVNnAepG4Ltd+ooikww1VnKahzWNP5cY5Dur3HAPKta
G2zXlOp6MdnmlBdu/R0VrF3nKkvXlllewPSu9Mj2JUMcCh6jyV4=
=CKUq
-----END PGP SIGNATURE-----

--Sig_/=Z.Dw7LDdvHEakSPEF3OwCo--

