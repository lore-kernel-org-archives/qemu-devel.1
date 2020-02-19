Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A6C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80112176D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="kfmKJAVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80112176D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4QBY-0000FZ-T3
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 09:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1j4QAm-0007le-EB
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:17:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1j4QAl-0005re-9e
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:17:56 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::5]:34796)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1j4QAk-0005lo-Jx
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 09:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582121871;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=UVPNF82+RNhZgt/NAaYu9NHVoKzqzHa3nZyXizsjufw=;
 b=kfmKJAVD474XR/V2x975cfXnZztlfyOiTHfDAyQXMfWf1iPRzRFWHcTuXfzgr+rpg9
 O768ufXeDEYRBlGjH5gR2R2Xpxlm6uoGphG0L3pzRg2kA40G8ybG/UVWK7Gc0z5sQQOa
 yJvI1CDCtxlkh03CR8+EfL1dM8cVwll0y5TNgcgv9e/6cPQpO5qUzid5/7VavlMGZGcE
 zpBYRlV/XIx93iRuPRj9fHW1MLxzNu94R+1K3LNJbbCKp8nxeUPZ7zyX5tAMzvmhDDNY
 fbidnR39XOXigpn4q2N9JnddEJCH4jUlIWJAnFG7MGsGZ1H7ots9zytUKPo4I3S3imLp
 32kw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYMlkjQ=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.12 SBL|AUTH)
 with ESMTPSA id 605caew1JEHnIQR
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 19 Feb 2020 15:17:49 +0100 (CET)
Date: Wed, 19 Feb 2020 15:14:59 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200219151459.5a6b9690.olaf@aepfle.de>
In-Reply-To: <20200219123530.11064fc5.olaf@aepfle.de>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200219123530.11064fc5.olaf@aepfle.de>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/As7/Ds2mdVShl99YKe.=4/u"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::5
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
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/As7/Ds2mdVShl99YKe.=4/u
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Wed, 19 Feb 2020 12:35:30 +0100
schrieb Olaf Hering <olaf@aepfle.de>:

> Is any of the things done by pc_i440fx_5_0_machine_options and
> pc_i440fx_machine_options a desired, or even breaking, change for the
> current result of pc_xen_hvm_init?

I tried to follow a few of the initialized members:

default_nic_model, perhaps the involved code paths are not called, so the N=
ULL pointer does not matter.

pvh_enabled, does this mean the PVH domU type? If yes, this would be lost w=
hen xenfv is locked at v3.1.


Olaf

--Sig_/As7/Ds2mdVShl99YKe.=4/u
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl5NQuMACgkQ86SN7mm1
DoC4pQ/9E0iPzaAKczFTEpr7rDGUiIQ5nO/0atPPa48IFlkkDKBinBX2g2gugtku
ssY3rbs/r/DCBXuGHtaMJovGtSIWnpKI+l+ak9kJZ8tSPCIQKFF1P5tiO2RsUwOP
PlMnOmRwBiiMcgNHxoT/02FzuU79u/eUKjQBoZaJhAWQp/PDEPl4zN5FM1jOj9r0
zZw0QrV+Jf4zeLQ73LaQyPMVghILS+T/Z4CLIwSwX6Ibdno8Nc1AIfxuV4+Ept8m
dRVYQornS7c77RwpxK5ALe803H7p6AY2gUhyHQ7fGlDi2tuvhZBSb2e68yVwkjyf
zVRP9+8BoFEuiE2WQIyg0JOpl4tx2A+z16Wi0VKCPmdhUV8AQjooS+JyIA10kKmI
Ud8lisQYgQZqCwEmtix14xHz0fOmRbuoauYjJdaP1mXXCchZ+EfKyvXSAeuw/LAz
vUZQVuswx5QcyUxEpkgEGVr88syyRddjMOds/BDjKoJap71n1xKcOH8LojHHy+v/
+1MkN5877YA51FmGEE1RXcvW3m52mEKCjWIJ4o0TqiWupFh+jeRyOZItD9vDyGgr
UWznV8DDBZeFD7UY2wIOvdsL/RFCQlsLU98QQVPkaA19w+dgRcGRbsX4H4FICigB
UrS7zVHdEl1mCZSjodlCO587LXDElZPpT7jiWZwbWK/axLPr+mE=
=ZA+P
-----END PGP SIGNATURE-----

--Sig_/As7/Ds2mdVShl99YKe.=4/u--

