Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F625C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B88C24654
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 11:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="K4yTKVC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B88C24654
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Neg-0007BW-4q
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 06:36:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40704)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1j4Ndl-0006hj-Vc
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1j4Ndk-0006ac-QP
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:35:41 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::11]:16467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1j4Ndk-0006X5-3W
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 06:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1582112137;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=WGdI8I6Uos/rom+dJCvaGJiG0CIinRsTshzGtpXwpe0=;
 b=K4yTKVC/OCdEdb8OEk1w21T5PHYv7V5o6646JnzWStv9XycQxFQ7uMl1DJsj9zuuon
 QbmL2+NjxYxg2xN0PgF5CJoIFJgwWMoxIfg58nWAqKKB6VThqnQX5vLABp4C1qEaTwsr
 xsUV7WAB3SEGzekq7K1OeM3VpTkx23n+A/mrn7mlMnwjIkqtuhnQPDU0SWVoj2xuin4q
 VYseE+vRcNEconjba9hSZ+tyC+7Z11qVl8LyxXl/MLMSF/279DHJezznDrT+FWkqSBSQ
 +gb4D9g81kzIBanrYG20X4mFdDidEVHuHx9rYKyYzexEZiYXXU7Ft44wnAwLRj61Q3XM
 8DXw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4AUztn93FPS2dyuYMlkjQ=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.12 SBL|AUTH)
 with ESMTPSA id 605caew1JBZaHcZ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 19 Feb 2020 12:35:36 +0100 (CET)
Date: Wed, 19 Feb 2020 12:35:30 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200219123530.11064fc5.olaf@aepfle.de>
In-Reply-To: <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4RTwmXpjc1lcdKDJREWIMXv"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::11
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

--Sig_/4RTwmXpjc1lcdKDJREWIMXv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Thu, 16 Jan 2020 19:26:39 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> On 16/01/20 19:03, Olaf Hering wrote:
>  [...] =20
>=20
> This patch is wrong; xenfv does not support cross-version migration
> compatibility.  Even if the migration stream does not change, the
> hardware exposed to the guest will.
>=20
> My understanding is that Xen is able to use "-M
> pc-i440fx-VERSION,accel=3Dxen".  The presence of the version in the
> machine type guarantees that the migration stream is compatible and that
> the hardware exposed to the guest is the same on the source and destinati=
on.

The current idea is to make 'xenfv' a copy of 'pc-i440fx-3.1'.
But is this actually the desired behavior?

Lets assume xenfv_machine_options calls pc_i440fx_5_0_machine_options.
What impact that that have on the result of pc_init1()?
Is any of the things done by pc_i440fx_5_0_machine_options and
pc_i440fx_machine_options a desired, or even breaking, change for the
current result of pc_xen_hvm_init?

Also, do the calls to compat_props_add have negative impact on compatibility
for running domUs?

Olaf

--Sig_/4RTwmXpjc1lcdKDJREWIMXv
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl5NHYIACgkQ86SN7mm1
DoDclBAAm3Pe2dW2GbiN4lunCx0//5Kol04JQv9LugdEnVcr3KuqsYjfqA0X9Lqf
iGOunf1BM1uiwuaNmFJmtQAM3HSDQm6FfRXgeONQaBdO3Mrx0FJl4PDQycL7y1PG
b5cCaLJ8VkZXZP3IWydhAcs4JQeP/sxrmr/MLx0hJtY6HQhx1Xf5UQ3wy13+UMjk
ZkdpXYLd0NAeQdM3UrU7r3MDlTBU4jASB1mOwU9SN5ctJ+NM37yTkZcRBU4yVvBF
ZO6SjNdoOZ9pIOvZgO0xbCDoxdlpGgKgYsk4Z/prPHDXlti8gpzpr70KAlwuPCca
nHA1GEDpvMSmRtWccdC8WMFemkeDGn/d48TBf2WfrJvo1NqLLfGLxOm777s3FgVQ
GMQHX7IM3SW6gz5RHdPwJgdMuPs3otoQDzz3ZAgaOHufE4t6Uo2myWAvbyxVZcOR
L79BnCNJuWYJUU30bW9KOcAKaw9dLayWRbyXNWtvMFyfpNKaR7lVYzoHKmc4SaGa
zcyjKhkwU1kHCGZUrAYgf/l8DaDcK4+Tm8KJZoMJOXXksc570n7UAAiImnb0opE3
dv9hvwde/y3LeUe8a7tjVXrBu8xeM+O6Dzr+XQ+U7FVnv/7wlFvvngdMmnc/Y6km
CZA/3Bw2r7O2U6KGgObKJTQ6KEqkJiqad89Z6GzDs9FT4g8frHM=
=rYPp
-----END PGP SIGNATURE-----

--Sig_/4RTwmXpjc1lcdKDJREWIMXv--

