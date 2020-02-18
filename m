Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0FFC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96AAA2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="NGNRpNaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AAA2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48qH-0005fb-Ok
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1j48nB-0002us-9o
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1j48nA-0004Vw-0K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:44:25 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::4]:11919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1j48n9-0004La-AO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582055058;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=sTcDSHL+yBvt9jVZ6zPtONd5N9pXDxID0H/Qlze/nQs=;
 b=NGNRpNazZfsIhjthixlCKlhAKwn2YYj8LwRwd2AeNNVGsOFRPsJBzZhi4kiVFxq3GN
 ZVJYW2EFfKTQ/SpZ56Ap8qb7WW3a1jGHyCOLUmLxWmqF2wwTmI5alJSqX1VIOQplCaG3
 icsk0bF7QTZO6ac4wv5W2vxp/EVzATJts7XNta1DeBYFlQDt598vRn9yR8lDv9tXvoeB
 ++RFtMdVOok9Tc99M4Q24FmlYe/8DPNBFPmktV9pU52OXRDMoo1og+8XgM/LArV6wFIP
 /FS47BjUjmHpKILfwTcPxWEhOPCr704esPyVGeN10aOZyRQrWtLyFgxZn8peefkZ4RO9
 oIWA==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYMlkjQ=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.12 SBL|AUTH)
 with ESMTPSA id 605caew1IJiHF1U
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 18 Feb 2020 20:44:17 +0100 (CET)
Date: Tue, 18 Feb 2020 20:44:05 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200218204405.17047092.olaf@aepfle.de>
In-Reply-To: <b1313071-0eae-0465-4b3f-85c49c77a256@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
 <20200127100951.0803d167.olaf@aepfle.de>
 <20200218182728.4b7f17b7.olaf@aepfle.de>
 <b1313071-0eae-0465-4b3f-85c49c77a256@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/iwJDW8_lW4/g4r.IiyqyEZt"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::4
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
 Paul Durrant <pdurrant@gmail.com>, Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/iwJDW8_lW4/g4r.IiyqyEZt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 18 Feb 2020 18:37:09 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> On 18/02/20 18:27, Olaf Hering wrote:
> > The approach below (making 'xenfv' an alias of 'pc') does not work:
> > xen_enabled() is false when pc_i440fx_3_1_machine_options runs. =20
> Don't use an alias, copy the 3.1 code into the xenfv machine type and/or
> call the 3.1 functions from the xenfv machine type.

In the end it may look like this.

Let me know about any preferences regarding the naming of configure options=
 and variables.

Olaf

diff --git a/configure b/configure
index 6f5d850949..65ca345fd6 100755
--- a/configure
+++ b/configure
@@ -368,6 +368,7 @@ vnc_jpeg=3D""
 vnc_png=3D""
 xkbcommon=3D""
 xen=3D""
+xen_hvm_pc_i440fx_version_3_1=3D""
 xen_ctrl_version=3D""
 xen_pci_passthrough=3D""
 linux_aio=3D""
@@ -1162,6 +1163,10 @@ for opt do
   ;;
   --enable-xen-pci-passthrough) xen_pci_passthrough=3D"yes"
   ;;
+  --disable-xenfv-i440fx-version-3_1) xen_hvm_pc_i440fx_version_3_1=3D"no"
+  ;;
+  --enable-xenfv-i440fx-version-3_1) xen_hvm_pc_i440fx_version_3_1=3D"yes"
+  ;;
   --disable-brlapi) brlapi=3D"no"
   ;;
   --enable-brlapi) brlapi=3D"yes"
@@ -7836,6 +7841,9 @@ if supported_xen_target $target; then
     if test "$xen_pci_passthrough" =3D yes; then
         echo "CONFIG_XEN_PCI_PASSTHROUGH=3Dy" >> "$config_target_mak"
     fi
+    if test "$xen_hvm_pc_i440fx_version_3_1" =3D yes; then
+        echo "CONFIG_XEN_HVM_PC_I440FX_VERSION_3_1=3Dy" >> "$config_target=
_mak"
+    fi
 else
     echo "$target/config-devices.mak: CONFIG_XEN=3Dn" >> $config_host_mak
 fi
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fa12203079..83d1fcc0ba 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -949,6 +949,11 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
 #ifdef CONFIG_XEN
 static void xenfv_machine_options(MachineClass *m)
 {
+#ifdef CONFIG_XEN_HVM_PC_I440FX_VERSION_3_1
+    pc_i440fx_3_1_machine_options(m);
+#else
+    pc_i440fx_4_2_machine_options(m);
+#endif
     m->desc =3D "Xen Fully-virtualized PC";
     m->max_cpus =3D HVM_MAX_VCPUS;
     m->default_machine_opts =3D "accel=3Dxen";


--Sig_/iwJDW8_lW4/g4r.IiyqyEZt
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl5MPoUACgkQ86SN7mm1
DoBRwg//SR7OFZRU01CwGQ1IXyIZ9OM/GZkQKp+PAcR7xelPf3FToXXmbMZLRaeV
CC9XuGKH/c3wYUWKtvyfQsBDsjzlY0ozShLsSZmn820i+XVxrT+g8gcE0js6SNXd
Mzdc62GrIlnu6mbcQEyrE/2zLMyNpngDjWaEQPrNvIxDtZW3mYwdWHUebZ5o0CK3
qyAmsFZXkq51WL4vehzi/eDSa+BqOQwJ9MlKhCwNDYsI4hF99qHTgVdkeQkFDbBk
W0NO/fZvq4xaJDUs3uBVKFi2fQIpSjfWTEIhLN1UUhSNwgAi6lEQhO+aCpmqNybf
8dEQd3nCJGQCmkaWL1Ulpmua0uMy3/VNMq5+rBmGFKA23/0e6yO0zHKw4J6u/PEy
DzTMtcRRZBRb9ARA0DuPQ8P52rVVI3x/wxrc3DZ99jt3YBbG1uUg+Ur2gbSe3CFc
odsSkNc/iSfVez/00GKebbvYRxpjfUkNtwZIUiGhz/k1pfyWsftvOdKUJwRgE55K
ofUtPwgKyKPPbRDaOhCsW7AYFQq8YkLEk3bnc/lX2lda1yycLHTs3nilVKLiQPFV
bKaCwgKiuT1vN1KkFjiOaMmC4v8t5SxGHSRav139LI/p4XoFKDxtXbCwPqn2jWlQ
iSrfdXi10+itny1mqwT/i1C28uOaNQjKPSlg8CEyYL4MhK24UOM=
=oQNA
-----END PGP SIGNATURE-----

--Sig_/iwJDW8_lW4/g4r.IiyqyEZt--

