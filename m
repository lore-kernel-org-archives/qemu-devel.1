Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B333C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC77822CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC77822CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BFh-0001Ms-Gw
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34742)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1i5BC1-0008FE-D2
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1i5BBz-0005G9-Vi
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:58:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1i5BBz-0005Fi-Mw
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:58:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEFED190C022;
 Tue,  3 Sep 2019 15:58:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-32.brq.redhat.com
 [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A47EB60923;
 Tue,  3 Sep 2019 15:57:57 +0000 (UTC)
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
 <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
 <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
 <20190903150824.GA14836@localhost.localdomain>
 <db34f470-5983-7965-c5b4-2b624fbe8e1b@redhat.com>
 <20190903154702.GA16524@localhost.localdomain>
 <0e4a9880-5669-af44-a122-65dc6072e406@redhat.com>
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
Message-ID: <8acd5748-e130-e3ef-8b5a-7034dacce95f@redhat.com>
Date: Tue, 3 Sep 2019 17:57:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0e4a9880-5669-af44-a122-65dc6072e406@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="b5FxkDSKB95IuhR039SaCiT6GG9bRoxOT"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Tue, 03 Sep 2019 15:58:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b5FxkDSKB95IuhR039SaCiT6GG9bRoxOT
Content-Type: multipart/mixed; boundary="NJRCzT8mDKGwFIa2NcLlnNd2v2I7vb8do";
 protected-headers="v1"
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <8acd5748-e130-e3ef-8b5a-7034dacce95f@redhat.com>
Subject: Re: [Qemu-devel] Cryptic errors from PIP install if missing
 openssl-devel
References: <20190829013125.GG16342@umbus.fritz.box>
 <20190829015117.GH16342@umbus.fritz.box>
 <20190829032746.GA488@localhost.localdomain>
 <24d0d5be-d206-33a0-cd8c-29825e2f8516@redhat.com>
 <ecfc63f3-d208-4a79-c26c-3d8fa031b3d3@redhat.com>
 <20190903150824.GA14836@localhost.localdomain>
 <db34f470-5983-7965-c5b4-2b624fbe8e1b@redhat.com>
 <20190903154702.GA16524@localhost.localdomain>
 <0e4a9880-5669-af44-a122-65dc6072e406@redhat.com>
In-Reply-To: <0e4a9880-5669-af44-a122-65dc6072e406@redhat.com>

--NJRCzT8mDKGwFIa2NcLlnNd2v2I7vb8do
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 03. 09. 19 v 17:56 Luk=C3=A1=C5=A1 Doktor napsal(a):
> Dne 03. 09. 19 v 17:47 Cleber Rosa napsal(a):
>> On Tue, Sep 03, 2019 at 05:22:48PM +0200, Philippe Mathieu-Daud=C3=A9 =
wrote:
>>> On 9/3/19 5:08 PM, Cleber Rosa wrote:
>>>> On Thu, Aug 29, 2019 at 11:46:15AM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>>
>>>>> class avocado.utils.ssh.Session(address, credentials)
>>>>>
>>>>>   Parameters:=09
>>>>>
>>>>>     credentials (tuple)
>>>>>          username and path to a key for authentication purposes
>>>>>
>>>>> The current test uses username + password.
>>>>> Can we use this credentials with the Avocado module?
>>>>> (The image used is prebuilt).
>>>>>
>>>>
>>>> I'm working on adding password based authentication.  To keep the AP=
I
>>>> the same, I'm thinking of checking if the second credential item is =
an
>>>> existing file, if it is, assume one containing a key.  If not, assum=
e
>>>> it's a password.
>>>
>>> Why not use a dictionary? Keys would be explicit.
>>>
>>
>> Now it's clear that a dict would've been the best option from the
>> beginning, but I was wrongly optimistic, and biased by the
>> "avocado.utils.vmimage" + "avocado.utils.cloudinit" combination, that
>> we'd only have to deal with key based auth.
>>
>> So the question now is really how to evolve the API, either breaking
>> the current version or not.  At this time, I'd try to keep the API
>> unchanged, given that it still feels logical that the tuple is about
>> credentials, just that the second item can be either a path to a key
>> or password.
>>
>> Thoughts?
>> - Cleber.
>>
>=20
> How old is this feature? I guess it's not yet widely used so it's proba=
bly better to change it now than suffer the consequences when hundreds of=
 people rely on it...
>=20
> Regards,
> Luk=C3=A1=C5=A1
>=20
> PS: My favorited solution would be:
>=20
>     with Session(addr=3D(hostname, port), username=3D"user", key=3D"/pa=
th/to/key", password=3D"pass"):
>         ...

=2E.. actually I'd even avoid the use of tuple and simply add `addr=3Dhos=
tname, port=3DNone, username...`. (basically the way it's in Avocado-vt, =
it works well there with some additional options ;-) )

Regards,
Luk=C3=A1=C5=A1

>=20
>=20
>>>> This should make the use simple in the case of keys:
>>>>
>>>>   with Session(('hostname', port),
>>>>                ('username', '/path/to/key')) as session:
>>>>       session.cmd('cmd')
>>>>
>>>> And passwords:
>>>>
>>>>   with Session(('hostname', port),
>>>>                ('username', 'p@ssw0rD')) as session:
>>>>       session.cmd('cmd')
>>>>
>>>> It's being tracked here:
>>>>   https://trello.com/c/uetpIgML/1517-avocadoutilssh-implement-passwo=
rd-based-auth
>>>>
>>>> I'll try to have it in Avocado's 72.0 release due next week.
>>>>
>>>> Let me know how that sounds, and thanks for the feedback.
>>>> - Cleber.
>>>>
>=20
>=20



--NJRCzT8mDKGwFIa2NcLlnNd2v2I7vb8do--

--b5FxkDSKB95IuhR039SaCiT6GG9bRoxOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl1ujYQACgkQJrNi5H/P
IsHFZwf+MKra+iibnHp7aUe0tSMDtJRNDo4yyhLyGWXR6GrzZCWZnsVqmaME6Kb3
unwlULWfvCCwWGCiI+Uv7YSnb40HX1QyxrVS7PX6G1Q0+Ks0YclE+k5iasxSbTCX
CdTO8EnecA9DovXKpaQu5VvMmLkMPDKNl6MMo1QoKum98CHzp9w0SN6A5c/ZKUNd
wg1DBGsRCtSPKC2uNTmTpzHJlzlxsP/EYVZTa2TQRBcC26tmqBsv2NDmEBHedEHg
wSDvaDqF1ScYzFIajpk0rxdBnn8CRFCB9MSMMdS7Z5aceqfVBNEfF+pjFsW3u7qc
KsmjS3JoWiqxlr3QFhKaKDAXUD8IMw==
=nXAE
-----END PGP SIGNATURE-----

--b5FxkDSKB95IuhR039SaCiT6GG9bRoxOT--

