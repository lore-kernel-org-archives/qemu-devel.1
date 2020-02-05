Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E5C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B7E20702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:45:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B7E20702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKzd-0001bb-JL
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izKyc-0000u8-ST
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izKyb-0001bt-5m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:44:22 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:58001)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1izKya-0001Yv-Rk
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:44:21 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MpDRp-1jJsTR1HAN-00qg9B; Wed, 05 Feb 2020 14:44:14 +0100
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <CAFEAcA8E9s2wZWVxanUDXu=5qcjn6XY5_6t8vUO+LjuJnA7nOQ@mail.gmail.com>
 <CAL1e-=j=nVJd9Q3JmZsimgSPy=noYhqE8hz4r5RjwgTPw9WwuA@mail.gmail.com>
 <CAFEAcA_FbFub4_z+e0YPMT8UTbm1SWmfovkKnLKODvMZMfGa+A@mail.gmail.com>
 <CAL1e-=jMnEpOw+fOqGfY2+uiUTYr0zgnMZxpVUK2Y=PA3YAFMQ@mail.gmail.com>
 <20200205111603.GD58062@stefanha-x1.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0299a57c-2b7f-22bd-ac12-5ce429c173c4@vivier.eu>
Date: Wed, 5 Feb 2020 14:44:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200205111603.GD58062@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="E99hCULAJK85AxLFLxxSyWPd8GTR1iGk8"
X-Provags-ID: V03:K1:Z/iD9hEv+TO8jUhWR+Ck2uvkcUQbVX7jX/qGiguFmyMYi4wFp4r
 hzdTl9m1YeuXrBs+8I3YlWdsOz0kuONxsMwUfCX3JuhIk5ch6xp0G4BO+03EWOs4kMo2hb4
 cr6Le6qzTEcLciuMv8IvzWBCOUQX4zMfqVCA7DgaLd9kat89kD+gy17+6BVuvmobGJXao73
 5IFUKc1RTfmbiDch5VT9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z150p+oKIMg=:qINHVLnFIO26+Yvr0jD0s0
 2NXQS6MlzRIE0elwcVis/ddtuTv5ROrV2XY7h8uapo10Ty47sB4pGVgl4CZkqFckAIxNenB5s
 Z66jezo0S7Ukpeoc0BD81bKSufgd988QXrl++ZcbTise9xQSL8Qxg8WvnWfP12dI8Zn1PHdxn
 q2peTL9MYiaINzaaK/9W9l+E/RXZUENg9n9yb4PGrGM+Ae48ouHaIRC3pRpsPP+dUphbwE4nE
 ajhn6uwDT6MWnaDkio5peF9ruMyIwyHmii5DhT0bFP5OTCHRKUi30f9EWq0RWmJt7JmZnJ6w2
 vqRQ2+vwCWlHydHkPJ5OU3T3vUwDQ3XfmtMBxAzLd66rRm076DYBc3NXqzRSoIl9fnZhGhA9o
 AYxiFkCZrELTUkAWhCNOiNiKAJ4u+2BTPGCJuQ203wXqjpYJR/EUjhilgHPqscbEk7GCfmrWV
 mYmyGvwEWQmadW0WmDPOoL4QHJMzF2HuQWsBwHG5IrjAEqnZkA6uh/iLLxISoTDMGY4S9d3nX
 oY1OZFGd1C+qpokP6otkCp0H0aGF3OOGY0R8C5ckTeXjH04RoLokBvjKrm+OVpu8OHV6/tYCd
 i2meNwjm2W1uP2LqTyUCUWUgiftzijx3Kwcf5uhWybRpvfrAzGhQGag7rmV3C+JJxwNB44oqu
 jDmDzQm4BOxfLZ1VJ26Z04HPpoLbXhfOnOpIbQ+dvAvfsP/5AUjZCj1fiRV5WW2frw10vnXjy
 v+miyrcSlhWDpiivphcbt9vFb+zgoJRnwwm2KBQK20qZOVZQcFmTEKZVhcdOs/yUTkSSBgSdY
 VaKlRIZ9I3U8AykbHnMVQXQzN2j/UJtDR/LwqB7W2GvsuBCSsW6qspFffC1x3v8IVG4TZUg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E99hCULAJK85AxLFLxxSyWPd8GTR1iGk8
Content-Type: multipart/mixed; boundary="mTtvYA7YXmhgbQsaiIbdaJG6Bg9OO12jI";
 protected-headers="v1"
From: Laurent Vivier <laurent@vivier.eu>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <0299a57c-2b7f-22bd-ac12-5ce429c173c4@vivier.eu>
Subject: Re: [GSoC/Outreachy QEMU proposal] Extend support for ioctls in QEMU
 linux-user mode
References: <CAL1e-=j5WJkV=X+KkfBuS3pjf6z3aJrtu4xpYeVbjEUYiWxxTQ@mail.gmail.com>
 <CAFEAcA8E9s2wZWVxanUDXu=5qcjn6XY5_6t8vUO+LjuJnA7nOQ@mail.gmail.com>
 <CAL1e-=j=nVJd9Q3JmZsimgSPy=noYhqE8hz4r5RjwgTPw9WwuA@mail.gmail.com>
 <CAFEAcA_FbFub4_z+e0YPMT8UTbm1SWmfovkKnLKODvMZMfGa+A@mail.gmail.com>
 <CAL1e-=jMnEpOw+fOqGfY2+uiUTYr0zgnMZxpVUK2Y=PA3YAFMQ@mail.gmail.com>
 <20200205111603.GD58062@stefanha-x1.localdomain>
In-Reply-To: <20200205111603.GD58062@stefanha-x1.localdomain>

--mTtvYA7YXmhgbQsaiIbdaJG6Bg9OO12jI
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: quoted-printable

Le 05/02/2020 =C3=A0 12:16, Stefan Hajnoczi a =C3=A9crit=C2=A0:
> On Tue, Jan 28, 2020 at 09:48:33PM +0100, Aleksandar Markovic wrote:
>> How about this:
>=20
> Thank you!  I have posted the idea here:
>=20
> https://wiki.qemu.org/Google_Summer_of_Code_2020#Extend_linux-user_sysc=
alls_and_ioctls

Thank you Stefan.

Laurent


--mTtvYA7YXmhgbQsaiIbdaJG6Bg9OO12jI--

--E99hCULAJK85AxLFLxxSyWPd8GTR1iGk8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAl46xqwACgkQ8ww4vT8v
vjyCbBAAs9+Va2y1MVvkqwgSTlTAvc1DomNlHbnVI8puKYf8K8xZkyj3bRenWawS
TW/3fV9tD0L0SNBDSZhs5u3U9DentAVjbN9YaPC4uv4npgeVDj3xcAGafL4ThGQt
Jaqm2CR8CHj4lJ8WOpqQrI68xbqrraNUwutQjGujImu894F7h5sGujxy5Q9iYKlc
x9jOtuHFmHFuvAytLv3Rtn9UMUBptk31GonK3HjYKA+kEJEU1DucTpZjMeJy4d75
T1L/jEGls+rgkvwV4nDm2up9culeQDLqsNmjpzqxRBrnq6ycFNnA6PIJ4SEyNanW
4WSmnJMSNnDQCJv8TphMmftHhJjo4PjN0COL6YjgSS3cf+y0pf8Jgwuy0eL4WYvH
T8Skd8Y5rf2jlXgMbA9nMHRDle02Od3OKuEcFXtmekpxJT/aMiFw5nAPU7+SvBg6
9kZXQ48x/y14XHxDRccvz+vsaU6btUBSGBACPqMeW3hMIS56/5VAZ/55jGDAdu/4
4aAkoqKVzu+6kPzlexMnabblhlKfkWFIU3CusEkuKHmhiYop+4mvEGnNi8awfHTA
N0uqZ1/0od8ATVveUSs8bDWBk8OjITFH+oxsIpPmnQu1rdNnVc8VNpCJvaRnzE1C
rfsescUJP61kYd/XmAGfx93wtXTNUhYf/WGSySIK+HB1k6XJT/4=
=lnNq
-----END PGP SIGNATURE-----

--E99hCULAJK85AxLFLxxSyWPd8GTR1iGk8--

