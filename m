Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8F3C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C183E2084D
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C183E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSo1-00006j-Tt
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 09:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iHSnM-00082Y-Iq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iHSnL-0004vG-5D
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 09:11:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48442)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iHSnH-0004tb-Tu; Mon, 07 Oct 2019 09:11:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D54388384B;
 Mon,  7 Oct 2019 13:11:19 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6F5119C7F;
 Mon,  7 Oct 2019 13:11:15 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
 <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
 <e7d5cc8a-7a61-70a2-7efc-8f1af8e7a41f@redhat.com>
 <8a6b9c09-70f2-e2cc-4c65-33375396d319@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <793fa056-2fc5-8d15-c563-046d3a336f2f@redhat.com>
Date: Mon, 7 Oct 2019 15:11:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8a6b9c09-70f2-e2cc-4c65-33375396d319@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qrr7LBH75LoKpmpG5UfWdIaIZk4EJR16I"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 07 Oct 2019 13:11:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qrr7LBH75LoKpmpG5UfWdIaIZk4EJR16I
Content-Type: multipart/mixed; boundary="I3WDd7irAdziwVGeuxDn2Jt83IHbbJHCC";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Message-ID: <793fa056-2fc5-8d15-c563-046d3a336f2f@redhat.com>
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
 <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
 <e7d5cc8a-7a61-70a2-7efc-8f1af8e7a41f@redhat.com>
 <8a6b9c09-70f2-e2cc-4c65-33375396d319@redhat.com>
In-Reply-To: <8a6b9c09-70f2-e2cc-4c65-33375396d319@redhat.com>

--I3WDd7irAdziwVGeuxDn2Jt83IHbbJHCC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/10/2019 14.52, Max Reitz wrote:
> On 07.10.19 14:16, Thomas Huth wrote:
>> On 04/10/2019 14.44, Max Reitz wrote:
>>> On 04.10.19 12:19, Kevin Wolf wrote:
>>>> Am 02.10.2019 um 19:47 hat Max Reitz geschrieben:
>>>>> On 02.10.19 18:44, Kevin Wolf wrote:
>>>>>> Am 02.10.2019 um 13:57 hat Max Reitz geschrieben:
>>>>>>> It usually worked fine for me because it=E2=80=99s rather rare th=
at non-block
>>>>>>> patches broke the iotests.
>>>>>>
>>>>>> I disagree. It happened all the time that someone else broke the i=
otests
>>>>>> in master and we needed to fix it up.
>>>>>
>>>>> OK.
>>>>>
>>>>> (In my experience, it=E2=80=99s still mostly block patches, only th=
at they tend
>>>>> to go through non-block trees.)
>>>>
>>>> Fair enough, it's usually code that touches block code. I assumed "b=
lock
>>>> patches" to mean patches that go through one of the block trees and =
for
>>>> which iotests are run before sending a pull request.
>>>>
>>>> In the end, I don't care what code these patches touched. I do an
>>>> innocent git pull, and when I finally see that it's master that brea=
ks
>>>> iotests and not my patches on top of it, I'm annoyed.
>>>
>>> Hm.  Part of my point was that this still happens all the time.
>>>
>>> Which is why I=E2=80=99d prefer more tests to run in CI than a handfu=
l of not
>>> very useful ones in make check.
>>
>> Ok, so let's try to add some more useful test to the "auto" group. Kev=
in
>> mentioned 030, 040 and 041, and I think it should be ok to enable them=

>> (IIRC the only issue was that they run a little bit longer, but if the=
y
>> are very useful, we should include them anyway).
>=20
> I agree on those.  (Maybe not 040, but definitely 030 and 041.)
>=20
> Maybe one of the issues was the =E2=80=9Cpath too long=E2=80=9D thing f=
or Unix sockets?

Ah, right. I've applied John's "remove 'linux' from default" patch and
added the three iotests to the "auto" group, and indeed, they fail now
on cirrus-ci due to the "path too long" socket problem. "We" (royal we,
I guess) should likely fix that first...

>> Do you have any other tests in mind which could be very useful?
>=20
> I=E2=80=99d like a test for iothreads, it doesn=E2=80=99t look like the=
re currently is
> one in auto.  (The problem of course is that they have a higher chance
> of being flaky, but I think they also have a higher probability of
> breaking because of non-block stuff.)
>=20
> 127 and 256 look promising to me.
>=20
>=20
> Also, I don=E2=80=99t see any migration tests in auto (156 doesn=E2=80=99=
t really count).
>=20
> The ones that looks interesting here are 091, 181 (but I seem to
> remember that 181 is flaky under load, I should investigate that), 183,=

> and 203 (which also tests iothreads).
>=20
>=20
> Those are the two area that I spontaneously think of when considering
> what is more likely to be broken by non-block patches.  Unfortunately,
> those are also the two areas with the tests that tend to be the
> flakiest, I guess...

Ok, thanks for the list. I'll have a look at them whether it's feasible
to get them enabled...

>>> OTOH, keeping the iotests in make check means we have to act on failu=
re
>>> reports immediately.  For example, someone=E2=84=A2 needs to investig=
ate the 130
>>> failure Peter has reported.  I=E2=80=99ve just replied =E2=80=9CI don=
=E2=80=99t know=E2=80=9D, CC=E2=80=99d
>>> Thomas, and waited whether anyone else would do anything.  Nobody did=
,
>>> and that can=E2=80=99t work.  (I also wrote that I wouldn=E2=80=99t a=
ct on it, precisely
>>> because I didn=E2=80=99t see the point.  I assumed that if anyone dis=
agreed with
>>> that statement, they would have said something.)
>>>
>>> So acting on such reports means pain, too.  I consider it greater tha=
n
>>> the previous kind of pain, because I prefer =E2=80=9CThis sucks, I=E2=
=80=99ll have to
>>> fix it this week or so=E2=80=9D to =E2=80=9COh crap, I=E2=80=99ll hav=
e to investigate now,
>>> reproduce it, write an email as soon as possible, and fix it=E2=80=9D=
=2E
>>
>> I think that "I have to investigate now ..." mindset is not the right
>> way to handle these kind of issues. If a test is shaky and can not be
>> fixed easily, we should simply disable it from the "auto" group again.=

>> So if you like, I can send a patch to remove 130 from the "auto" group=

>> (personally, I'd rather wait to see if it fails anytime soon again, or=

>> if this was maybe rather a one-time issue due to a non-clean test syst=
em
>> ...)
>=20
> Waiting for another failure sounds OK to me.  (OTOH, 130 doesn=E2=80=99=
t seem
> like something that needs to be in auto, in case we want to take
> something out to save time for more important tests.)
>=20
> But that reminds me that iotest failures probably should be
> automatically signaled to me and Kevin instead of Peter having to write=

> an email himself.  Would that be possible?

Not sure whether an automatic e-mail is feasible, but you could register
a github account to test with Travis (and maybe Cirrus-CI) before
sending pull requests to Peter, I guess that will catch most of the
issues on other machines already.

 Thomas


--I3WDd7irAdziwVGeuxDn2Jt83IHbbJHCC--

--qrr7LBH75LoKpmpG5UfWdIaIZk4EJR16I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl2bOW4ACgkQLtnXdP5w
LbV2ug//SscPZD9PhK7Svid78z2EyEb7DfqfgQtlTHp3j/pNDZaoCxAIzqu+gmsu
QIFxoOLo5FRc7+T5BaaRZqUc/5ijDiIu//bF5GiF9WxRJyHtIZj2WV1c8ScTogZm
sCy27frFedR0Oz6+eKfoW5UXLIYMRg+9gEwF/EBwrlx3Blg286rp4ozC0qK7rD1m
ufopWf1PxT+PIwaULszzcWxVlJapNaMkYhLfAzyPbpE1H4K+EjAYBX7/bdCjZS9p
0FmeTz0bT3sL1d8JpddRpTegYEfGouP3YsbO8HTni8jDHOzhsSHg2EmA4omCpM0u
OmTqG03gFo4kq0mrJj0psdrqSS1peJXmAewoRJHmiG2J8ABMQepS8FOWWXi4QtJ3
+7H6W5RN3CIBff5hUUfBcWliBcOyIKYFAtbls06ScVXHP7zVYSqXysCBvmdMNO2Y
1d5Lv5GvkaA+8f/rzsqe7BnCBxfwf3b089l2fyKxmu3pGVGo3903vCYKorSef62R
62hrWCDBeo9hnVzqjipWJlsq//Ds4CC2j1bLTmzQRq/kQ86nN4D4SV0COnZYJmaJ
+v1JarmNQDUXDKN6nO2IQVwqnTgDl4jCjoCJV3Yd6qqVZZG6AVX8ShCSpNRMgbUk
a0vt9VHrIj4VDQubB6iUg07Sf2V1uAkZ2BClGMmqSGi6FCG3Qs0=
=cKJJ
-----END PGP SIGNATURE-----

--qrr7LBH75LoKpmpG5UfWdIaIZk4EJR16I--

