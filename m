Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8853CC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:58:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A80620737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 10:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A80620737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOfkG-0005da-JY
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 06:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wsa@the-dreams.de>) id 1jOfjW-0004Yz-RH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wsa@the-dreams.de>) id 1jOfjV-0003V8-K6
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:57:30 -0400
Received: from sauhun.de ([88.99.104.3]:45304 helo=pokefinder.org)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <wsa@the-dreams.de>) id 1jOfjV-0003Rk-D5
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 06:57:29 -0400
Received: from localhost (p54B33507.dip0.t-ipconnect.de [84.179.53.7])
 by pokefinder.org (Postfix) with ESMTPSA id 073202C1FF1;
 Wed, 15 Apr 2020 12:57:27 +0200 (CEST)
Date: Wed, 15 Apr 2020 12:57:26 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v6 2/8] i2c: i801: Use GPIO_LOOKUP() helper macro
Message-ID: <20200415105726.GL1141@ninjato>
References: <20200324135328.5796-1-geert+renesas@glider.be>
 <20200324135653.6676-1-geert+renesas@glider.be>
 <20200324135653.6676-2-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5VuzLDXibKSJvVYD"
Content-Disposition: inline
In-Reply-To: <20200324135653.6676-2-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 88.99.104.3
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Phil Reid <preid@electromag.com.au>, Jonathan Corbet <corbet@lwn.net>,
 Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>,
 linux-doc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Harish Jenny K N <harish_kandiga@mentor.com>, linux-i2c@vger.kernel.org,
 linux-gpio@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>, Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5VuzLDXibKSJvVYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2020 at 02:56:47PM +0100, Geert Uytterhoeven wrote:
> i801_add_mux() fills in the GPIO lookup table by manually populating an
> array of gpiod_lookup structures.  Use the existing GPIO_LOOKUP() helper
> macro instead, to relax a dependency on the gpiod_lookup structure's
> member names.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: linux-i2c@vger.kernel.org

Applied to for-next, thanks!


--5VuzLDXibKSJvVYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6W6JYACgkQFA3kzBSg
KbZydg/8DULg8EIKkSzuh9yI6MGrXGUqwwvyIQHaC4oNjuLWC+cZPSPccmfkU9uQ
o6AiQrnaN8DZR3q8QmuGEM1u8lWVsa41SjYPxIoqdYanYHCHb0SkajUh0nSCKpxF
l5o/rcx0eoQq0cfS3D+Zx5tSrFXvruFSDCvcRRTkpkrjSN+k3Xu9Ax3WN3tj4+6q
n2h254Z2JkFSDU5lLY/anLWJ8T9rw+o7TtuswdLV+whub9bZJqY9CMAMqAzJJyaG
wK7HKn5WHLLEYGLDboN93jsTUFSn+HFQHNaDX0VKxGe+SvuWBQuMNC3gXQ0d4m7D
tZtcW/6d4fVQ7GN5J+qgumLfjrWRpGgBSj5OSQtQhhlg1odDZEKediQXODLQe0Fl
Zhcc1eh+IG4gBmfQ6DS00DMbeOBxTbQhKIfMvM8kLkQii6aLRuGr3GXD56Ssuo3v
0U0h/L27isgQ/+EW1Bpncb03xpwkkF/x95sEFf2OsJDKmZwFKkI2vdlMYT78OLZc
w5R954iVPIi1MgZoxULGz8DJ7TYLBYjLJQsgH4rADEJ9qh057/uo2pdGJsaBp4tH
WDcpnmNMGjE96EhcdwgUWQ+jxhJJoaFofTDV8wdXIVApVW7h1mABRMk6Lnjfp+c9
O+TDbzFWsbskBkXKpgp8wuDujmh8FLz2CRkeVDkuvan7iy6oUh0=
=f8zu
-----END PGP SIGNATURE-----

--5VuzLDXibKSJvVYD--

