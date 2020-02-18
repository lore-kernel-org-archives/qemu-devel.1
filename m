Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F3AC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F9BD21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="Is6h8k8D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9BD21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47fK-000278-AD
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1j47e0-0001EX-GH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1j47dz-0000wx-DL
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:30:52 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::1]:19988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1j47dy-0000pU-NW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582050647;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=MI0EOsyM7oCJvD1r2skPvfflowkJhRKxQU4Q67vswFU=;
 b=Is6h8k8D8JfLFXqHjcSQkd90ZASZ+tsAU7xGhdLukIYroc/JxsU/YxqXaePV7ESYSy
 0EEIl0eZhC9bvyBtz7k5akbcOOBYsYg4Cke/6df+kcgJhxqLfeqzvfiGNpuYm0dzw6FC
 ib6/H1k43vII5ze4uTUQg7+Bi4JfU6UZsffXP4+9ziPF0YpkN7wRLqzAmlFbSKNgn0jp
 NmOZHyBabqfkCZ5JJ/KH7FTY/OoiEecW6Rxg6nC3weqhpZwXNdNpAZKEjULt3pMdSEWf
 BCdghQvA/2INjUYuSFUTHOSCDWY9h+MubcNkjLjHDo5XvoihSUS/h3z+808M/FAyI7YU
 7Y9w==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYMlkjQ=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.12 SBL|AUTH)
 with ESMTPSA id 605caew1IIUkEqf
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 18 Feb 2020 19:30:46 +0100 (CET)
Date: Tue, 18 Feb 2020 19:30:39 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200218193040.1612bf26.olaf@aepfle.de>
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
 boundary="Sig_/FS72whMJ3j.JQ/eCDRWgKDN"; protocol="application/pgp-signature"
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Paul Durrant <pdurrant@gmail.com>, Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/FS72whMJ3j.JQ/eCDRWgKDN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 18 Feb 2020 18:37:09 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> On 18/02/20 18:27, Olaf Hering wrote:
> > The approach below (making 'xenfv' an alias of 'pc') does not work:
> > xen_enabled() is false when pc_i440fx_3_1_machine_options runs. =20
> Don't use an alias, copy the 3.1 code into the xenfv machine type and/or
> call the 3.1 functions from the xenfv machine type.

Since pci_create_simple must be called after pc_init1, the change appears t=
o be as simple as this:

@@ -949,6 +953,7 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
 #ifdef CONFIG_XEN
 static void xenfv_machine_options(MachineClass *m)
 {
+    pc_i440fx_3_1_machine_options(m);
     m->desc =3D "Xen Fully-virtualized PC";
     m->max_cpus =3D HVM_MAX_VCPUS;
     m->default_machine_opts =3D "accel=3Dxen";

There will likely be an argument about making xenfv compatible with 3.1 or =
4.2. I guess the only consensus will be configure option.

Olaf

--Sig_/FS72whMJ3j.JQ/eCDRWgKDN
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl5MLVAACgkQ86SN7mm1
DoBCEg/+MBdA/4LL0IjaKfr/maHPipVMEuniIpHdUpUzLFqzQEPmeBtPqN1vsgXH
62U/owsB3lOYb032FSLDT74ND9IBp5Zap7YeKr8jq858mhhsdxMboAMyTxTjEcYa
tdACX6iYBmFl0wAbbPPxo/hPCUYh4FnJ+O+ndV4ZrY6WaxoMIDgcepTBdCwlV2sW
tm9d86sVSg4mj/VHA9+/9BXxWC/ErDpXZlRdAfkRzzDN9XN+e5EgXLo8Rbyw44Ai
G3Hb752gJe63ZvlvW5fVt2I2tEWCRVVlrcOwqcWoGenVGL0XMC914m18fnevxVk8
YG9xWuUJrsLK9o3K6O6VI83vVzxK+0NG34DcZslGP1ewuCC8wl57oqYblTAOkvlN
vPDsSpLlQN6e9Q74+71SspQMJbnlA9MAG/821VlXkQ6hhjxmZhdO0tczxbHovoS8
aoEbF4TAaG6dMLtecW/gihIMrIJ9gnrcPkCcMUed8E+eNes8JoJoWomweXZkDpBH
HM9h+TELnRo2pqTUV93VLxXhJJ66WdSz9kpcWSa7YIUBq1oW9ICSDnK7goIOO0N8
SzYMXLV+Z9GtXrjo2LpE9AJGV8rpamp1FxRDtC4rIKGltUy3EBtmvtUjb6IghCkF
e8TlYWyXafjuHDDMztiGy7tj4iS1qeHrdkuNo7H2pwftNvSQtjc=
=AqL/
-----END PGP SIGNATURE-----

--Sig_/FS72whMJ3j.JQ/eCDRWgKDN--

