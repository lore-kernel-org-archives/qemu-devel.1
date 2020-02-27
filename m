Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5904C4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631D32067C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 09:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=xcancerberox.com.ar header.i=@xcancerberox.com.ar header.b="sBS2zPPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631D32067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xcancerberox.com.ar
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7FU7-0002cE-Im
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 04:29:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <me@xcancerberox.com.ar>) id 1j7FT8-00021I-UH
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:28:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1j7FT7-0007bP-TL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:28:34 -0500
Received: from [51.158.76.159] (port=43718 helo=mail.xcancerberox.com.ar)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <me@xcancerberox.com.ar>) id 1j7FT7-0007aj-Jq
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 04:28:33 -0500
To: QEMU Developers <qemu-devel@nongnu.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xcancerberox.com.ar;
 s=mail; t=1582795709;
 bh=AxrIayGbg6+5/QRnqXzIAe5pF1n+seg8TkN0xGE3nBg=; h=To:From:Subject;
 b=sBS2zPPN3NYOJF6NbYoGtATkjMOgIv5x+C0dR0tw4160lD3s0Yvn3D+nHAFCbIYHS
 TU9ZOyBfFDNDfoGdhcr6jlFglLUeuQa5e1Gw9uJ70GyVVZMu/cX0v3v/YoW7Id2E7k
 mcsIlrgHLyVlSWsr0Igpncyt8B1NIRENeBN1Ox6IPVM508c3eMfSCLaQnn61UYd32Z
 R5x/cbkhDvjfE8ZqiK5yq9amk4g3RLMmbsNFtU+RzWDEgor8dPA3H7oBNiwmvtsj3K
 C34asGilGPNQ8+p2pcqpxlWhNl0ruIGLuEKhwnsG9jnV0ukl31S3CtWAo1LsR678hm
 cioeaF4SvhFmQ==
From: Joaquin de Andres <me@xcancerberox.com.ar>
Subject: Wiki user request
Autocrypt: addr=me@xcancerberox.com.ar; keydata=
 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
 OZRo+ULKJ1xXuVGe8hnP9Q==
Message-ID: <b4440411-cc60-cd7e-988e-458baf0c8b6d@xcancerberox.com.ar>
Date: Thu, 27 Feb 2020 10:28:21 +0100
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7m0I0Cyqk6Fx9nNQS5N0Otbql8mz8Lhkf"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 51.158.76.159
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7m0I0Cyqk6Fx9nNQS5N0Otbql8mz8Lhkf
Content-Type: multipart/mixed; boundary="5keE6czyosgxE5tI85Qp4i4w1pN541Nd3"

--5keE6czyosgxE5tI85Qp4i4w1pN541Nd3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi!

I wonder if I can get write access to the wiki page. I'm working with
Philippe Mathieu-Daud=C3=A9 in the GSoC Arduino Visualization project ([1=
])
and I need to modify and add pages.

Thanks!
--joa

[1] https://wiki.qemu.org/Internships/ProjectIdeas/ArduinoVisualisation


--5keE6czyosgxE5tI85Qp4i4w1pN541Nd3--

--7m0I0Cyqk6Fx9nNQS5N0Otbql8mz8Lhkf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEUqEiz9cph90MYsVLwbNfcmJGyaEFAl5Xi7sACgkQwbNfcmJG
yaHTYQ//bg3XlYJNGtkodun5BoJ2mHlCubvyhkHnEe41zHeoxIGXS7I772ia4s5L
g8faxv1O04LfnGA+HGxjbn4e7KUInntqsj/BP9RYzlwGTBRAqwzkm4HbRyTgqIH7
PdHcyPAKQ5V7aMh3kfWOaGCOl3zGk2mhLqwDoPUX9yuo9Xr76Xt2kI6yB4n6Tu/l
ZbTY3bxA9klECARYoI0mm3/kK0JcUBxx+Llz30TjgTkbG5O+wAvqc+s0z8yDnhL7
F8mgmoKxAWkNWsxGqgZWYz3qTbJasZ9VTsg6woOU7zhDuMsVBjyS0mjwEqg1dQ/f
OIzZ3zQdRTcMcUdiAzJLvcN/GaSUbVf+7ADvHoZEP/fkbxIdg0OHzn0LENaV8Olm
jCdO5NRU55GlvUcvtg9BEbSKf5YHbVoT9X9EdELsoZRho5WF2L1meSTvlrk/1QAf
Yrolk1R5i2HaeQv2WhxUJleXGKXLFO0jul4WA518fuANeIk5k2V5RA8cVc+vs8RY
9MSAwrWWats1AaAPnWztMcA66pCCLp6JwMJDj7Fo92ITMczeE4o28YrTsZHO+sQH
5/y2Uq3v1BMVobkCjz+hMGEaIMipbTCY73xHHuT+4VTj/JaEFxNybFGF0XB8xR7c
b5FNOlWWKyz6Fy6YDYEawjumvd7zvK/GyKWtUCKK4Ics7mGjk0I=
=FLAw
-----END PGP SIGNATURE-----

--7m0I0Cyqk6Fx9nNQS5N0Otbql8mz8Lhkf--

