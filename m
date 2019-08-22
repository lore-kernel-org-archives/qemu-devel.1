Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EE6C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35CB206DD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35CB206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0lHK-0004wx-Q6
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1i0lFf-0004Dy-Gs
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1i0lFe-0002UZ-Gx
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:27:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>)
 id 1i0lFc-0002Sf-3V; Thu, 22 Aug 2019 07:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A18D43695F;
 Thu, 22 Aug 2019 11:27:30 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-35.brq.redhat.com
 [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6383360603;
 Thu, 22 Aug 2019 11:27:29 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Andrew Jones <drjones@redhat.com>
References: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
 <b0b27c5c-c07a-527b-294a-c4e7ec6d4204@redhat.com>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=ldoktor@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAG0K0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT6JAVUEEwEC
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 AlqVjq0FCQdCCrIACgkQJrNi5H/PIsFF1Qf+K23kB5iOvsbe/swQda9nJZSgKkbXLCF3KCdw
 jCY3qdneHzro696qosRhWn+tpLQ6Mp8sgnXuJk96qaptXtx0R1Ci2oHFo01WfcSLZ1f99/0q
 dWGWJhTt2TPNP6A5rrw//FZlQOYNTYG9vn7euLE0el32ZQp/0HCO7XpLiujEX48fWdlaPmDO
 nalJEpzzJJNu8WnHIG2eLS8lGrNdnPbkxHyeERxPuWDAmHmWyZSaDMtMd40XVKfLfkyY83jz
 +uq8uMxPMzq116YvFygsXqJPgWGYX39BdasEssr/GABHqgKY54dtTdMnFZZFVowkoCSh2Al/
 X/OSk5wpyYZrEYeKNLkBDQRXFer7AQgAw8JIK9pZUfZWNZirBIwOevkdZu1aLhgH84EfXw40
 ynMEFa1t/c0baOiuLNcVbdnHLGvUAQJ2oN/+rdGpEWITVSjDxFYf3JOnySZJhLnQgGMG4j3m
 dFZMubPG1GJEuubPAAB0huRfjQTvOvpIK03J2H5cMoug862OHOnT+mfonGruTkSO0PBq3wtf
 P+Z3gLCuEDkmEZSh4IKxs0CoLU4KxWRQHpoTOxcAiHzj8cm5qbu3Cb1KrXz8dEmYhCq2fpFf
 /h+GfEO8gU/ICJD8WQUHYcVK0bbiZskCcSOGtStjwq0QqitZMbcsPEset/2L3z44MLPuVApv
 c9wORs/3iT9BhwARAQABiQE8BBgBAgAmAhsMFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAlqV
 j3sFCQdCC4AACgkQJrNi5H/PIsG+JAf/emslPCAW4gmn3Ep1ON0V0xPGxFOUbH2m+f079pVP
 Jo3dGT6ZFF8q00GEsqxjpxO/c0opsTFrAN3qyTS3Kr4435ua66J5eP+TBkjN+vljmRi3T9Xg
 h/dHp0JkZQCtcnmNsm/9F0/GzMvc7CnsptDp4aT0KGMfpvv7XrQOkprSr2wgWeAdNVhCP2ZQ
 y+yAzLmHe5OGPW1qPmIBBvEnU2C8av0ONGKIxIAUCF8UCm+YJzPwIwJLhkzrhANiqNwQXwfn
 j8HaEsOCIX26S4GYYmIaY1+GBeHkeh0R/GzERRPh6jfhg2JiCE6ftgZ+DKRjsK3o1uw40aYe
 s/q9jwLlkaqraQ==
Message-ID: <84dd318a-28d4-b2f3-b03b-d870a5f618d5@redhat.com>
Date: Thu, 22 Aug 2019 13:27:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b0b27c5c-c07a-527b-294a-c4e7ec6d4204@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JMETg6tLlCW7WLdINt3fgZ7aE2LuyV16y"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 22 Aug 2019 11:27:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Broken aarch64 by qcow2: skip writing zero buffers
 to empty COW areas [v2]
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
--JMETg6tLlCW7WLdINt3fgZ7aE2LuyV16y
Content-Type: multipart/mixed; boundary="to2uG6j22FkBTv5upfPviss6Q3teC94fZ";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Max Reitz <mreitz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-block@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Andrew Jones <drjones@redhat.com>
Message-ID: <84dd318a-28d4-b2f3-b03b-d870a5f618d5@redhat.com>
Subject: Re: Broken aarch64 by qcow2: skip writing zero buffers to empty COW
 areas [v2]
References: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
 <b0b27c5c-c07a-527b-294a-c4e7ec6d4204@redhat.com>
In-Reply-To: <b0b27c5c-c07a-527b-294a-c4e7ec6d4204@redhat.com>

--to2uG6j22FkBTv5upfPviss6Q3teC94fZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 21. 08. 19 v 19:51 Max Reitz napsal(a):
> On 21.08.19 16:14, Luk=C3=A1=C5=A1 Doktor wrote:
>> Hello guys,
>>
>> First attempt was rejected due to zip attachment, let's try it again w=
ith just Avocado-vt debug.log and serial console log files attached.
>>
>> I bisected a regression on aarch64 all the way to this commit: "qcow2:=
 skip writing zero buffers to empty COW areas" c8bb23cbdbe32f5c326365e0a8=
2e1b0e68cdcd8a. Would you please have a look at it?
>=20
> I think I can see the issue on my x64 system (I don=E2=80=99t see the X=
FS
> corruption, but the installation fails because of some segfaults).
>=20
> I haven=E2=80=99t found a simpler way to reproduce the problem yet, tho=
ugh,
> which is a pain... :-/
>=20
> It looks like the problem disappears when I configure qemu with
> =E2=80=9C--disable-xfsctl=E2=80=9D.  Can you try that?
>=20
> Max
>=20

Hello Max,

yes, I'm getting the same behavior. With "--disable-xfsctl" it works well=
=2E Also looking at the option I understand why it only failed on aarch64=
 for me, I don't have libs installed on the other machines, therefor it w=
as disabled by "./configure" there. Anyway I guess disabling it in my bui=
lds won't really fix the issue, right? :-)

Regards,
Luk=C3=A1=C5=A1


--to2uG6j22FkBTv5upfPviss6Q3teC94fZ--

--JMETg6tLlCW7WLdINt3fgZ7aE2LuyV16y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl1efCAACgkQJrNi5H/P
IsG3AQgAm4ro8ZCCtmPFPYaL9s9cNFPB5IM7lfeJJkWhXCJFCHSTojB9hIhjdVer
YmkLqDR6ukp9WmjJUyvd1bcc8BPh3DuI+hZE3JV0iW7OfVIKGyxrDWH27TaBRnhh
gR1oS+WC63nmM4kN49sHcO1cn2cdtYkgy28Xuq7jXPG7Bz5aowlt4g59+woPV2+3
OySLKq5FsCerPpaTtl1+9mFV9O8dH2jP0VQrPhbhAD/1gdRgltP1YxJHiNpw7gbH
OO1AE/7qXl/7MtZA7TiF65tle525Sp6Qji6mm/TFhkzhvl6T9VCrukZibaR7SlLp
PqLR2JSwY5MgCuUx3cftxnqtatL+Fg==
=CRBq
-----END PGP SIGNATURE-----

--JMETg6tLlCW7WLdINt3fgZ7aE2LuyV16y--

