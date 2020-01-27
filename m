Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D4C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B42214AF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="fyGwHPV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B42214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0Pw-0000tO-Ed
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54091)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1iw0PI-0000Op-TM
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1iw0PH-0001tB-LR
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:10:08 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::2]:24417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1iw0PH-0001qD-0G
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:10:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580116202;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=sSIU6r6hRIdgeVmDEceNZxmA2hGuyuEnauCPB1f5h0k=;
 b=fyGwHPV7esPt0Ba6mNXsBzV376vh6ct0tarJHZBZBq8qXrlF0UQIaS/cCQFAjP3zwQ
 GY5Gtj2DKL7TzTWU5LT11n2otYMiO7OhNayPuoj+uYwZSpZzd4V5NJYCNsdt3uU0Kj3Q
 iDS8D4JP1AyAglTDUukRXIrKTOzPeALWZj6hgBCXVyXWFqrII1UbDlMvOBaucV0v5Kwk
 +5NCykdNpPP50EAqqrOiKoUS28He4JWecIfW7ymuOSO3MSHDSLotPXpRh/eAgzqRU2ii
 Fmbjxe89QVQ4XzxkFKe6/gt8BZlhXs54+rg4DJW7OQLChWl0+Jl/LiDn8FnlqHCYhWtq
 8WPQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX92EW4mFvNjTRB"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.7 AUTH)
 with ESMTPSA id j07b1dw0R9A1BIg
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 27 Jan 2020 10:10:01 +0100 (CET)
Date: Mon, 27 Jan 2020 10:09:51 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paul Durrant <pdurrant@gmail.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200127100951.0803d167.olaf@aepfle.de>
In-Reply-To: <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/es3fHPvEDX_VZIDDF8ItNpI"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::2
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/es3fHPvEDX_VZIDDF8ItNpI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 20 Jan 2020 11:18:41 +0000
schrieb Paul Durrant <pdurrant@gmail.com>:

> On Fri, 17 Jan 2020 at 13:06, Olaf Hering <olaf@aepfle.de> wrote:
> > What would future domUs lose if 'xenfv' would be locked to 'pc-i440fx-3=
.0'?

> I guess eventually that pc type would be removed and then we'd have a
> compat issue. Ideally I think libxl should simply not use xenfv and
> then it can be deprecated and removed, and then such issues can be
> dealt with directly in xl/libxl.

I think this does not answer the question at all.
What future versions of libxl do is one thing.
What existing versions of libxl do with future versions of qemu is another.


IMO it was wrong to map "xenfv" to "pc", simply because it entirely
ignores live migration. We were just lucky until qemu-3.1. Maybe the
creators of 'xenfv' just meant it to be "do everything to make it
compatible with HVM".

What about a variant of this change, to lock 'xenfv' to 'qemu-3.0'?


--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -490,6 +490,13 @@ static void pc_i440fx_3_0_machine_options(MachineClass=
 *m)
     pc_i440fx_3_1_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
     compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
+
+    m->alias =3D "xenfv";
+    if (xen_enabled()) {
+        m->desc =3D "Xen Fully-virtualized PC";
+        m->max_cpus =3D HVM_MAX_VCPUS;
+        m->default_machine_opts =3D "accel=3Dxen";
+    }
 }
=20
 DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
@@ -500,6 +507,7 @@ static void pc_i440fx_2_12_machine_options(MachineClass=
 *m)
     pc_i440fx_3_0_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
+    m->alias =3D NULL;
 }
=20
 DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12", NULL,
@@ -946,14 +954,3 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
                   isapc_machine_options);
=20
=20
-#ifdef CONFIG_XEN
-static void xenfv_machine_options(MachineClass *m)
-{
-    m->desc =3D "Xen Fully-virtualized PC";
-    m->max_cpus =3D HVM_MAX_VCPUS;
-    m->default_machine_opts =3D "accel=3Dxen";
-}
-
-DEFINE_PC_MACHINE(xenfv, "xenfv", pc_xen_hvm_init,
-                  xenfv_machine_options);
-#endif


Olaf

--Sig_/es3fHPvEDX_VZIDDF8ItNpI
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl4uqN8ACgkQ86SN7mm1
DoClMxAAi4ThJHLQhVHEiiFxzUjMVPVmE1JIKFJhX8Mrgdh2Jkzf2O1YG/L6hjPA
J0epHgb+TwgDeHLfWUp26v8bV+duxNETt9VU7qyCgpwgNtQe3GzSyJGpTrRSTjLe
BtbT3rJoPWLl8UiZ1ukJHy+BaaaTx/6CIHPBEyvFtu9DyjqYqM3e8K2rxvWpZtmT
aCz7S83jt9TThUwyB+qyIRdjntcH8dWlQK7y9SsDPxwdlZrYkXYN21UJ0KhZHtBy
auHq4ZT3NjT3Q+31g07AZK94fFCl3w3krn44EJLo0ek+HTnzYm1s7QQ2umH66wYe
fDjYXSuCAh6CKnFh9u6nwX9pIyTe+T2oiotdMCvfgC8OfkAIDcr8JLTAr1on2BXz
5I3enTtMukyyBxIEfsWKbQpwu4wYxflIunzlJ5QOpeGWI1C+tjGUzqDQAfynTSwv
2FOAmsaudivR3IEnviXv5lzPkmdZqpolxeHoYW1hHajN0rtzoKCvvy5KDeDfYSIy
2Tn4Ox6Lu8m7EYsiydM1BcSx+yhHO5Xwqt7nLfxb4Gp8z0M6PJk5wKrWAZmScO2M
HuTyBz+lEJAoKnDx8yHFGoYWEeQ6NyVoKFkaPW30BJJjAx0iVIPIJCp4930TJzFR
sIhu/MWGGtPKDkRXrs9tk4RIUX6IIxh8h7v4jnUpe+5tOzzXB3k=
=ZMPM
-----END PGP SIGNATURE-----

--Sig_/es3fHPvEDX_VZIDDF8ItNpI--

