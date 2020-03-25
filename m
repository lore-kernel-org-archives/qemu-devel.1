Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88220C1975A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:46:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5655D20719
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 15:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="qpwWpnv1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5655D20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH8F0-00021p-EN
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 11:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1jH8E2-0001PK-F2
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1jH8E0-00031R-Bv
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:45:49 -0400
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::11]:11640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1jH8Dz-0002zT-Mm
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 11:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1585151144;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=PKweOmqboJ9ln0CKf4OKLYqTdl0iXQliBFPIkLD7iSw=;
 b=qpwWpnv1r1IrGuP9/R5cE5N3DjUwXK2F82FGIqG9Aqq5RfuIUJAE9/g2lUh+eFpiAj
 fjem0wUt2Tf64ig1uxOLdCm8v2SNny52pdVpQP51U/T2+chANUNnoUt04YOc/NVqtNOy
 j88KGcxurA+0kRIoicNW+gpt5glTRuzrjTrkGI0Odg6FkqVjD1NvPprjjWGlGElUkM0k
 iBla8oSOAuOdBgcE9qiBbC5MgA/xIVOvYdtawa85W28v+w+iYN9nGuP0bC9IT+wdM/to
 es2LtKWvBKjZahev+ktGrig/du52mFgcfH4Upcqh2TF0wupELG79Rg9cb8XlqP0H+tTU
 Pmdg==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC44eztn93Z9OGdNZlAhh"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.2.1 DYNA|AUTH)
 with ESMTPSA id k0b757w2PFjeR75
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 25 Mar 2020 16:45:40 +0100 (CET)
Date: Wed, 25 Mar 2020 16:45:22 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] piix: fix xenfv regression, add compat machine
 xenfv-qemu4
Message-ID: <20200325164522.39869e56.olaf@aepfle.de>
In-Reply-To: <9123dcfd-862f-8986-b728-f4b3d806aea6@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200325064736.22416-1-olaf@aepfle.de>
 <9123dcfd-862f-8986-b728-f4b3d806aea6@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MJo9kP2hsGmI.TUp/d1QRmQ"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5300::11
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
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/MJo9kP2hsGmI.TUp/d1QRmQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 25 Mar 2020 16:39:54 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> hw_compat_3_1 and pc_compat_3_1

I have asked about this earlier, so again:

What do all these arrays do in the context of 'xenfv' to the emulated syste=
m?


Olaf

--Sig_/MJo9kP2hsGmI.TUp/d1QRmQ
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl57fJIACgkQ86SN7mm1
DoD62w//b+U9Kdz0H/jmjEDX3Bvgqzx/wSswAW6jUX633xdFKGjrIsSqBfODv6gE
IjgH7zItzxBRq6KIzzgWrZF9bkN0PuooK5mKqmiag1S78su67wnAJKpo2TReCKGm
KsMe1if8QzI45hfCcAipLmZ+/QHcIfBvmGi6XH2tk8XioYBHC6EmXCieSMsFEdWc
o3srYIbLK/KFjKiZeU72mh1MQghcXxxzdMQeuukvCX7+JURdr5MIrJtKjw/u1DIR
oFKgBIGaaElMlZzVlfVYt6Ygt4BGpDo5IQrGzcgo0p4xVYxY/pbRa8GxHMU3CbHa
3QAAqej3aWBFnj4p4OcTwwJgEEv4Y2vpFa9JNUMNXba9Ebt7gzudV6F7azRdVq1T
BdVvD67BhjqwcmGPa1F9Qjo2pjyZg5GdVQ5aY3WdZfOlMhzJFCe1preiP7Y5Stja
ThZz4ZteY9ZoMb/D/Y8r7pC/+ZgZSZ5rx4q0oKYeuB5r3pRCK99r7jD+sqyhe6YK
vqQHqmBb/dwuYyMRwgoskQfQidECKVhzFNZBha/TTsZf6XFjR+4PnK7wmjtjQ1ZE
I/0OrWmMbLpDM7plrTiMKkJspI/Vvkg80soVqt1e0k6Da5SLuGDKzb0kf+pcoKtw
dpoxE/KnZ4LRZFe72mKZeKIiXO2y98RoPs2c1f+fQSHySjvcKxM=
=Jia/
-----END PGP SIGNATURE-----

--Sig_/MJo9kP2hsGmI.TUp/d1QRmQ--

