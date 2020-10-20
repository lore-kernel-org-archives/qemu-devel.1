Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0473C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:53:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA86022250
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 12:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="tkriJ9Yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA86022250
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUr9B-0003OT-JM
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 08:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1kUr8K-0002xH-CA
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 08:52:56 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:18962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <olaf@aepfle.de>) id 1kUr8I-0004AF-1D
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 08:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1603198370;
 s=strato-dkim-0002; d=aepfle.de;
 h=References:In-Reply-To:Message-ID:Subject:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=DlIHe7hvcRKSNnBj+8l/slaer4uDvQWX5ccKTqpji9M=;
 b=tkriJ9YuU2YF/ltDyqXfoOX0Ks2VukTBZ5QAu4hBP2sngmXWg3F0If4sRCw3uCIgoo
 IBGi/W7fMTkpW5BNwTHqOpmNsNozln9Ymh43eRsuLF0R0SDxkUici9i3ndweelmHzH6b
 W1GYXuVnZvccYGdGXE5xuT0lsskswpC6EVAd2tXAp7vLEWg4caO4jHdu6Gx+wfw6pcw2
 RVXa81c1xn7j3TH3/NMWpLKiR3Kjdo0KiATWeP6HqUOlLam/chIIWAiP+mFFQzFAs1Mh
 SbxoFzT4jdHXXC5JYVYjd0va13/yi4Idj/S7wyBaT+N5JX/d+zibHc65sptHUkwA4/b7
 nkNQ==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QLpd5ylWvMDXdoX8l8pYAcz5OTW+r+/A=="
X-RZG-CLASS-ID: mo00
Received: from sender by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
 with ESMTPSA id e003b5w9KCqoCFr
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 20 Oct 2020 14:52:50 +0200 (CEST)
Date: Tue, 20 Oct 2020 14:52:43 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own
 submodules first
Message-ID: <20201020145243.47871b60.olaf@aepfle.de>
In-Reply-To: <20201020091605.GA2301@aepfle.de>
References: <20201020091605.GA2301@aepfle.de>
X-Mailer: Claws Mail 2020.08.19 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OeqqbMJEhurHNXvN85ySL_8"; protocol="application/pgp-signature"
Received-SPF: none client-ip=81.169.146.219; envelope-from=olaf@aepfle.de;
 helo=mo4-p00-ob.smtp.rzone.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 08:52:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/OeqqbMJEhurHNXvN85ySL_8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Am Tue, 20 Oct 2020 11:16:18 +0200
schrieb Olaf Hering <olaf@aepfle.de>:

> > +	cd edk2/BaseTools && git submodule update --init --force

After looking further, there are more bugs:

configure has a --with-git knob, which this patch ignores.
configure has a --enable-git-update knob, which this patch should most like=
ly use.

Olaf

--Sig_/OeqqbMJEhurHNXvN85ySL_8
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE97o7Um30LT3B+5b/86SN7mm1DoAFAl+O3ZsACgkQ86SN7mm1
DoBhUhAAjtkQs89IGdg5kNTljNpC17CrkXA0uJrMkKmIgk+PPTrRN0Rs4a0UuQK6
OuIvpKJXCw0tn2f7VcrLliK+hpa8k1Nn05xHNaMYXYljl4YMAD7C9zf9ofyG02OL
ktzBTNiTYOXmlvRxoEEwFWhC4vK4VbPWWiQKqzMAMjvxI8V78ZikDZQ+t2xr1Vpn
GnduMmzmqfbgNFkp6599RAGAx4McHLe9hnSCiWZ163lrOr3+ntinejX2W6Ng7SOp
/bBpVtm7NlyVPWLfDfYAOkWewZPE6W5ylO4wiTzezkoGvKQaZS70sAvrNNsBavDS
K23F6zcDWq2ZTN37SbNUZoHp8Y6Ddzt70nHArwGepm2YhDDpJiaErTR2IpVqVPoI
f6vs8vVhOge4QL0hnbN1VennJF6AJsQBXU5Rb6x1OPMj8XseXI6pQdI9KRIA0ykk
2vBxF3+Dng9e4VMPYGa64r+BQMLiEV+erh/EY31A9NUC2/E2JZq9W9i0eYnQKQa1
5QJ7siG7TNNdtSJetLjOZiCOsGem3xN48dXEkOhlvYm4Jd0qF9rZUz85Jkhqh2D5
8wFpNCWajzPAHlb8xCkOLVXyAhb12K70i5+5x7ahXzIDMH+/Aa1gHtn6AiFYBAFj
W4catag/Vj9JpB3fSvHwK1UjLKY1igIWGdpe3nhoA3847yifHY8=
=vWMG
-----END PGP SIGNATURE-----

--Sig_/OeqqbMJEhurHNXvN85ySL_8--

