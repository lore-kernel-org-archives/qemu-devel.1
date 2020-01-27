Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CA0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF239207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 13:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="IZvkZsJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF239207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw4QW-00071l-2S
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 08:27:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49501)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <olaf@aepfle.de>) id 1iw4Pc-0006Qj-KC
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <olaf@aepfle.de>) id 1iw4Pa-0006wR-GN
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:26:44 -0500
Received: from mo6-p01-ob.smtp.rzone.de ([2a01:238:20a:202:5301::8]:11074)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1iw4PZ-0006sS-QS
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 08:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580131598;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=QP4etj++K9qY8hELfrmPLMMuHBtJ3RkRMHnRBP/E6cY=;
 b=IZvkZsJn8IDEOBSCg0ip/YEirfeISCiGojaDhahKnSJGYfioYAwHrQMOS4DRZQh+//
 QE+IsqNmtDwt0GgphYSd2JlcOsKwAVGTFOc8FDLDdvPY4+G9+zdWVM/aEUDtuHPIAk3n
 0zoxGjDoWuR6lEQpgqdGS1b4zxHpD6v3M0syhyAoEDJjWklho0W0GtEJ4W7FWt6LNKc0
 PgkFBY+GmtLR/bMQbzb81DSFY+n6Ee2OXFVeYmDwkN5+ha6/LD73bfcgw6SRWqzAvNpH
 lTp7WLX9IAZGUMY/EnnAZoOiLnEFek0aG3N19VjVcWTLoz7Ybcrbwup3paFaLIcpgM+x
 jgWw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QED/SSGq+wjGiUC4kV1cX92EW4mFvNjTRB"
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 46.1.7 AUTH)
 with ESMTPSA id j07b1dw0RDQaCtY
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Mon, 27 Jan 2020 14:26:36 +0100 (CET)
Date: Mon, 27 Jan 2020 14:26:30 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
Message-ID: <20200127142630.48551ea3.olaf@aepfle.de>
In-Reply-To: <d8d31bb7-01d1-8bb9-889e-c03c55818df3@redhat.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
 <d8d31bb7-01d1-8bb9-889e-c03c55818df3@redhat.com>
X-Mailer: Claws Mail 2019.12.31 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bG4V3aRAJE1KqfP3CqcxoOR"; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 2a01:238:20a:202:5301::8
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

--Sig_/bG4V3aRAJE1KqfP3CqcxoOR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Mon, 27 Jan 2020 10:35:59 +0100
schrieb Paolo Bonzini <pbonzini@redhat.com>:

> That's years away, so ideally libxl would have migrated away from xenfv
> before that.  For now, sticking to a fixed version as in Olaf's patch is
> a good stopgap measure.

Is there a way to inspect a running qemu process to see what version it is?=
 I assume one thing is to poke at /proc/$PID/cmdline and make some guesses.=
 Would a running qemu report what pc-i440fx it supports? With such info an =
enlightened libxl might be able construct a compatible commandline for the =
receiving host.


Olaf

--Sig_/bG4V3aRAJE1KqfP3CqcxoOR
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl4u5QYACgkQ86SN7mm1
DoB49w/7BY4I6KaKyQRx2KaO0pHeVnG+K3uboqekOMkof2+NECBygjNSM3AxjBNf
vRYEFvZhld7sQVR++tG8ZFJ4SBSBHkTP+vUo2gSgZSqBlb9OMQrDGHkW35PynRbk
ezGfnoeGEiHYjU4mTxYFL0yT23UIdbJSAah2K8srt5jIOD8tDWHywuBXYGaO2Ahm
ARb+6uq+ZPU1957uG5xlegpaHCPO+vsjfpK+kcKi87ctIdbL+xGcgF48HnUEvSlF
ZMVuVfr55OzpP8E9e4wRAXjNIUEkDi9mVHQahg0PmUco0qBeAJBJBfpND9gemKrC
hs+WexfpbdOUngauHNuJ6ZShbIW7yAZzJ0Qmqm92BgBwhFzxg9lDXL1qWTA2i5xN
5ngn0yUv8oNp95wymWvlG5vk7e9n0o2DqBEk3ua74Vkl4GnNKHSdwD2ay9czbb7y
by01LcjHPFDiDo0MtC6Ebv7v70Ma7V1A+ThInVIhiUs9x935vEx+Rl14XvceL+VG
/WdDI4a0WgmHzQUmd3dY6W+dMrtAFtgXrp16nYNvG4fSaC9VH3FsvnXjJRFGuGAR
Y8ECcGaLM1RX734XK6vR9GRJdb3mUOd1kBcMzDCwUiyU96bqINGop+w4QgbOGYfN
0xkZDZ/gBVsZT4wvmttPTQd4e/FM/7SFcCakcsUYzt95hlUot8Q=
=oRAj
-----END PGP SIGNATURE-----

--Sig_/bG4V3aRAJE1KqfP3CqcxoOR--

