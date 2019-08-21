Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA1C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C2C22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C2C22D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Tfd-0006sa-E9
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1i0TZn-0006qZ-AC
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1i0TOq-0000jL-I8
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:23:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>)
 id 1i0TOp-0000il-6I; Wed, 21 Aug 2019 12:23:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08393859FE;
 Wed, 21 Aug 2019 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-35.brq.redhat.com
 [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7175B17D2F;
 Wed, 21 Aug 2019 16:23:48 +0000 (UTC)
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Andrew Jones <drjones@redhat.com>
References: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
 <b9129921-91cb-4339-0a3e-eb73ae5f6390@virtuozzo.com>
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
Message-ID: <db5bc7fa-a943-24fa-700b-9a675bdda79a@redhat.com>
Date: Wed, 21 Aug 2019 18:23:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b9129921-91cb-4339-0a3e-eb73ae5f6390@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="32yWQD6eeANNEXxJcJ5CkNC64SAHHRSCu"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 21 Aug 2019 16:23:50 +0000 (UTC)
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
--32yWQD6eeANNEXxJcJ5CkNC64SAHHRSCu
Content-Type: multipart/mixed; boundary="Med2PnU6H5KSgRwbAZ9DiFVa8Naa9mwdy";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Andrew Jones <drjones@redhat.com>
Message-ID: <db5bc7fa-a943-24fa-700b-9a675bdda79a@redhat.com>
Subject: Re: Broken aarch64 by qcow2: skip writing zero buffers to empty COW
 areas [v2]
References: <db672a84-0f30-bb82-ef94-c543e444372e@redhat.com>
 <b9129921-91cb-4339-0a3e-eb73ae5f6390@virtuozzo.com>
In-Reply-To: <b9129921-91cb-4339-0a3e-eb73ae5f6390@virtuozzo.com>

--Med2PnU6H5KSgRwbAZ9DiFVa8Naa9mwdy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 21. 08. 19 v 17:49 Anton Nefedov napsal(a):
> On 21/8/2019 5:14 PM, Luk=C3=A1=C5=A1 Doktor wrote:
>> Hello guys,
>>
>> First attempt was rejected due to zip attachment, let's try it again w=
ith just Avocado-vt debug.log and serial console log files attached.
>>
>> I bisected a regression on aarch64 all the way to this commit: "qcow2:=
 skip writing zero buffers to empty COW areas" c8bb23cbdbe32f5c326365e0a8=
2e1b0e68cdcd8a. Would you please have a look at it?
>>
>> My reproducer is running kickstart installation of RHEL-8 from DVD on =
aarch64 gicv3 machine, which never finishes since this commit, where anac=
onda complains about package installation, occasionally there are also XF=
S metadata corruption messages on serial console:
>>
>=20
> hi,
>=20
> this looks scary :( I doubt that it can have anything to do with aarch6=
4
> but rather a really tricky timing (or, possibly, a broken environment
> like broken fallocate() on a host? who knows..)
>=20
> Is it always the same machine you observe this issue on? Did you try
> others?
>=20
> I just wonder if it's worth to try to reproduce it on my machine
> (and I don't have aarch64 on hand now). I can probably come up with
> some torture test that will continuously write to qcow2 with random
> offsets/sizes and verify the result.
>=20
> If you could kindly reproduce it again then we can probably start with
> enabling qemu traces by appending
>   " -trace bdrv* -trace qcow2* -trace file=3D/some_huge_partition/qemu.=
log"
> to the command line.
>=20
> Beware that it's going to produce a huge amount of logs.
>=20
> Also, the corrupted image and the serial log will be required for
> investigation.
>=20
> thanks,
>=20
> /Anton
>=20

Hello Anton,

I have only tried that on a single machine, but colleague of mine reporte=
d similar issues even on TCG installing Fedora using x86_64 host. I'll tr=
y to reproduce it on my x86_64 box which should simplify the debugging.

Luk=C3=A1=C5=A1


--Med2PnU6H5KSgRwbAZ9DiFVa8Naa9mwdy--

--32yWQD6eeANNEXxJcJ5CkNC64SAHHRSCu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl1dcBMACgkQJrNi5H/P
IsHN7AgAyNTfdgJ9+TwDbdrf26NgNwwkZsZeiGC2Fdo3dfKJ2WE0cZOZbHXRU8sB
NOU+hPqTDyrzQdJEluWpbhj1iFb4wd7NewgcZtAGxqMmOGdmeRI4+UJfCYId5Ucf
NAWfXcUSDoZCVeMUs8nsxfIjSgewjk58vWLB5BSF86BddYwyZO/cuh4xtlv5Nk7O
4sZG3Gyb8HAWFRlH4Hxbtvhl3Xj6965jSZO7kP9yATysPPbfFUWVid1ldaVAy4gq
5+SCY7et5COV6GtcOhmwpyJA2MYEIrvnFN4m1BgFyYqCX9QS3PGASroFXxA0Q6gK
qaJXgOba7rNDY9bsRCgb7Ctz7vareQ==
=rXH2
-----END PGP SIGNATURE-----

--32yWQD6eeANNEXxJcJ5CkNC64SAHHRSCu--

