Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51444C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 08:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A28B2253D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 08:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A28B2253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifgaW-0007EL-Az
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 03:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ifgZf-0006ak-3Z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 03:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ifgZe-0001Wl-0Z
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 03:45:23 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:55501)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1ifgZb-0001Q0-KY; Fri, 13 Dec 2019 03:45:19 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MXYAj-1iDKUR3wyd-00Yy05; Fri, 13 Dec 2019 09:45:13 +0100
To: David Gibson <david@gibson.dropbear.id.au>
References: <20191212194359.13508-1-laurent@vivier.eu>
 <20191213014419.GA207300@umbus.fritz.box>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] mos6522: remove anh register
Message-ID: <68431265-fd33-89de-6a61-0c823beaa16e@vivier.eu>
Date: Fri, 13 Dec 2019 09:45:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191213014419.GA207300@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SPf22y5OKl0BjgXK5D5AvFnt5K7iAgp8I"
X-Provags-ID: V03:K1:eNPV6CvwN5KgFxg+SJs2ZbGsUjrL888us40gHsUd0ch5Gy5j6jV
 +VskudJhsWW8QrBVQaFARgfWmLBaEUmoTEydRQH+8cLV7MP3QxgawnW5i1GWhUUoGYODD2t
 hyw6kHj+n0fhQG+hnrFBMTlVbJvQtOcBQQzuP8XJpVVEKVqz4luF1XY5rPnwca9T8QKlbuP
 ojcLvyUx8wNYI66kMvK4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KuBGLt9EL7s=:vrZBaxl3fB/xxs58O4Q8BB
 C66+FKDOkWSN8xCVy0iHKhaTrBLhPnNgUiTRkRau1hNg41/FWt7nYAA/lCdHja6CO65Qn1Hno
 cCpkUosSYXc0YUTtCulRnNCdY6ZY7ZQFzcEcu9JKUKmbBl0LZqbiko5wuYMCdIUiFhPxwvRX5
 w4JRnSYdda2uKOXPLr9ywdfwNf0F0rA3aP2K5faV9hLPLSiROCkJU4oqWaip98P9KHXNGRHiK
 jQQI1qYMw/w8fgHiwodvYsdSeVgaiRlcYg8CyTQA1nJ+4Nt/JoA23vn1Zk6tMQypq5dA60O8y
 Utnh6lbAjRvL59xR7HJVAvo1Yy7z4gyQSo2vmBDKt/X/o6/CHLdSanEZFhFpr19kbIfN8af7A
 zhflZXIBmPlOtxXFw45Xjmm20weENDJQY8yrv+xBxUNGrNwWYvYEWSFxLEP+neOkdD/5CNz69
 BkA+vPF/55fJkBHL9IUMW1lbciUCy1MqyIDVdqdKNyQ4NM3K34KLhVlZ2RB9te7zmghE0V6Tz
 oyV6AiH8VEaagTkvGxvx5YpDbkwP7gdSYi4CVDcYw/Dl/dzjpc7sDNtkRf9lc+ohjNeWL1UPU
 MLr3koYnWp+56etNu1a8IYwPy9OJ0lnBe6tNom1NwP+OCJrcpSvwuppxRVf9p9wstiZmzoe1P
 zwyHuCG+tg9ZFRVEJsMvPiUWHPTDCes9T2k+e8q/Q6lHbQKx4A3EhzkQRP1NfM56yluMrOdyO
 8UN/UP+9m7Y5UIJc1G/PKb/KejnC4hPCspRoZde3Hy/eGjW/pdtlX9LQJ/e1J+X4G7rXu/rv3
 UW2jrCFZPhzavpILeVPHLTkGVC/7IfXMavSD8KeP2sJRp2PxxSrmeNHfotKD5clQLFevDplBJ
 ni79YovBh7wxRu2wRUgg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SPf22y5OKl0BjgXK5D5AvFnt5K7iAgp8I
Content-Type: multipart/mixed; boundary="eHV0s9Z4fbVUf5TKjkERSSsky7JcfX75d";
 protected-headers="v1"
From: Laurent Vivier <laurent@vivier.eu>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <68431265-fd33-89de-6a61-0c823beaa16e@vivier.eu>
Subject: Re: [PATCH] mos6522: remove anh register
References: <20191212194359.13508-1-laurent@vivier.eu>
 <20191213014419.GA207300@umbus.fritz.box>
In-Reply-To: <20191213014419.GA207300@umbus.fritz.box>

--eHV0s9Z4fbVUf5TKjkERSSsky7JcfX75d
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: quoted-printable

Le 13/12/2019 =C3=A0 02:44, David Gibson a =C3=A9crit=C2=A0:
> On Thu, Dec 12, 2019 at 08:43:59PM +0100, Laurent Vivier wrote:
>> Register addr 1 is defined as buffer A with handshake (vBufAH),
>> register addr 15 is also defined as buffer A without handshake (vBufA)=
=2E
>>
>> Linux kernel has a big "DON'T USE!" next to the register 1 addr
>> definition (vBufAH), and only uses register 15 (vBufA).
>>
>> So remove the definition of 'anh' and use only 'a' (with VIA_REG_ANH a=
nd
>> VIA_REG_A).
>=20
> I'm not actually following the rationale for removing the register.
> Linux doesn't use it, but if it's part of the real hardware model we
> should keep it, no?

It's actually two methods to access the same register (with handshake,
without handshake).

In the datashit Register 15 is described as "Same as register 1 except
no handshake".

Thanks,
Laurent


--eHV0s9Z4fbVUf5TKjkERSSsky7JcfX75d--

--SPf22y5OKl0BjgXK5D5AvFnt5K7iAgp8I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAl3zT5UACgkQ8ww4vT8v
vjyAoBAAtQG3c3jBz6oOCAmA+FL18iYcfq0ZXPuHA4gyE7OHp5FRt0atkxeBbbV8
0w+/fEkbCtPc9HOzj147aAdSBvZhESh/Ua/cIMtr5+vGNpZv0ZCPscPI+KS2QVUR
co7ZtgtpT3BoThUCuab6YzuNSiwB2IEfupgl+l5NWqyDs9VdLbMxJw8hkF1Jpzrb
Z+WkosnvNaBqcTCbhAk6il8V4EkU41dWyl0FfI7PGdA4dPY9T64ur37l4DGIwkWe
RcI8lLDmDT+FxV+Ah4ebWrogiOTNQMaChdULBwsizB/Aj0C2gG2vuzDgIVad/U+h
DwGYnzlV27Sy0ZTgb/yfS5S+R8Y8OQ4fO80yXbr5txOWtBq6iHP9pPe1qucu852/
UKmSer22iXbtPKYKkS1uYWu7smCHgdsu5Eg0OXUPM2OWAVGwOO9Q/ry13CJyYAMj
ElW3WCIcAnLlbfXdHP8VO2LJM7qe16RCTr5p5srVhbG3va1mkLntD3Js0SY8ZGOc
L1O7CiHwZoXyiXB+X64S6LhR3mOr/ue4yMNWU8NQ+x0x4VDNEfTeEgjUEFbJuqhN
3hV9Pgg+wRQtlDXPGqj09OtW4cPTQ6TYxfVyHuMOAP7s7MNEbaIxGYm6D1tVZsH4
N8b/SWHsVmaleqL8bWP7l7JIcPtMtMwWDun/JS5CeZBuNW9qZQo=
=kOep
-----END PGP SIGNATURE-----

--SPf22y5OKl0BjgXK5D5AvFnt5K7iAgp8I--

