Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A02BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059BB2070B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059BB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1385-0007ZH-4m
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 02:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1i133i-0005Yz-EF
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1i133h-0001aM-DB
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:28:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>)
 id 1i133e-0001VV-Ml; Fri, 23 Aug 2019 02:28:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9ABD31752A0;
 Fri, 23 Aug 2019 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-35.brq.redhat.com
 [10.40.204.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 20B6F600CD;
 Fri, 23 Aug 2019 06:28:19 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
References: <20190822162618.27670-1-mreitz@redhat.com>
 <47d2cafd-da56-eb81-b54f-4f666aff016f@redhat.com>
 <dfafe489-9e42-e37c-7695-e42b7c413c4b@redhat.com>
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
Message-ID: <dc3e9573-d6a9-fd40-ff2f-0918c95de342@redhat.com>
Date: Fri, 23 Aug 2019 08:28:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dfafe489-9e42-e37c-7695-e42b7c413c4b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l1AVhAU988DTqnJLSgjHMPRKQLL8y6wcC"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 23 Aug 2019 06:28:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix
 xfs_write_zeroes()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l1AVhAU988DTqnJLSgjHMPRKQLL8y6wcC
Content-Type: multipart/mixed; boundary="TIRhFImLdiqk2bzoRwT5hYMZhMPE9ILN9";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <dc3e9573-d6a9-fd40-ff2f-0918c95de342@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block/file-posix: Fix xfs_write_zeroes()
References: <20190822162618.27670-1-mreitz@redhat.com>
 <47d2cafd-da56-eb81-b54f-4f666aff016f@redhat.com>
 <dfafe489-9e42-e37c-7695-e42b7c413c4b@redhat.com>
In-Reply-To: <dfafe489-9e42-e37c-7695-e42b7c413c4b@redhat.com>

--TIRhFImLdiqk2bzoRwT5hYMZhMPE9ILN9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 22. 08. 19 v 19:09 Max Reitz napsal(a):
> On 22.08.19 18:53, Paolo Bonzini wrote:
>> On 22/08/19 18:26, Max Reitz wrote:
>>> Luk=C3=A0=C5=A1 ran over a nasty regression in our xfs_write_zeroes()=
 function
>>> (sorry, my fault) made apparent by a recent patch from Anton that mak=
es
>>> qcow2 images heavily exercise the offending code path.
>>>
>>> This series fixes the bug and adds a test to prevent it from
>>> reoccurring.
>>>
>>>
>>> Max Reitz (2):
>>>   block/file-posix: Fix xfs_write_zeroes()
>>>   iotests: Test reverse sub-cluster qcow2 writes
>>>
>>>  block/file-posix.c         | 16 ++++++---
>>>  tests/qemu-iotests/265     | 67 ++++++++++++++++++++++++++++++++++++=
++
>>>  tests/qemu-iotests/265.out |  6 ++++
>>>  tests/qemu-iotests/group   |  1 +
>>>  4 files changed, 85 insertions(+), 5 deletions(-)
>>>  create mode 100755 tests/qemu-iotests/265
>>>  create mode 100644 tests/qemu-iotests/265.out
>>>
>>
>> What about just killing libxfs support and only use fallocate?
>> FALLOC_FL_ZERO_RANGE was added in Linux 3.15 (2014) and the only
>> platform we probably support with such an old kernel is of course
>> RHEL/CentOS 7 which has had it backported.
>=20
> Works just as well for me. :-)
>=20
> Max
>=20

Whatever you decide, anyway this patch fixes my arm installation issue an=
d the attached qemu iotest is also passing on my system.

Thank you,
Luk=C3=A1=C5=A1

Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>


--TIRhFImLdiqk2bzoRwT5hYMZhMPE9ILN9--

--l1AVhAU988DTqnJLSgjHMPRKQLL8y6wcC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl1fh4MACgkQJrNi5H/P
IsG5OwgAplP9e1kFEEe3XDuv7pstdIS7PptPqeyfQPAYtrycVvpsrpKpkYV5eZp1
WLjuvMpj5ZLQfE+WWlrGfyjby9su1hHPYgQFrCJlePQqKyHZ94OFjV7LTHFavziv
e4l9RLPda4hn78sL02IfL/4XDvivm0Ix2XKo4ewoQQFluAzlZXp74WIM16NMV3yd
5++U2KFHHKcM4GG2PH8lmHlw5HPC6oVJtJaH8dHVUqeQ2uONwhrwIB1TpeXcnnNb
mX4zEEwY4VfxU/mxxh8MBfhjzyI/Hc5Lmuy48tPKb17glUEHPBVHlm+YFV98hQT4
jw4iOKOwMtjRvGY+opuI1wL1GE2aXw==
=tBYV
-----END PGP SIGNATURE-----

--l1AVhAU988DTqnJLSgjHMPRKQLL8y6wcC--

