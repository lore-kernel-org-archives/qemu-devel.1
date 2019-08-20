Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9631C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 18:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFFD822DA7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 18:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFD822DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i09CK-0006kS-Uw
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 14:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i09BQ-0006Fi-9d
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 14:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i09BO-0007te-FT
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 14:48:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52468)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i09BJ-0007rJ-Hb; Tue, 20 Aug 2019 14:48:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 88F993CBC3;
 Tue, 20 Aug 2019 18:48:32 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3667B1001948;
 Tue, 20 Aug 2019 18:48:30 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190819075348.4078-1-thuth@redhat.com>
 <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
 <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <b35ee5a6-e3b1-d134-0a28-bfd45f5c8de4@redhat.com>
Date: Tue, 20 Aug 2019 20:48:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wrHb1BvVzymlXkwb7aAn43yT0ao0OdFv9"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 20 Aug 2019 18:48:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: Check for enabled drivers before
 testing them
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wrHb1BvVzymlXkwb7aAn43yT0ao0OdFv9
Content-Type: multipart/mixed; boundary="LKkr0BWfh7RGj8PjdKyK68pUfrzUEJP1b";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b35ee5a6-e3b1-d134-0a28-bfd45f5c8de4@redhat.com>
Subject: Re: [PATCH] iotests: Check for enabled drivers before testing them
References: <20190819075348.4078-1-thuth@redhat.com>
 <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
 <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
In-Reply-To: <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>

--LKkr0BWfh7RGj8PjdKyK68pUfrzUEJP1b
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.08.19 18:01, Thomas Huth wrote:
> On 8/20/19 5:01 PM, Max Reitz wrote:
>> On 19.08.19 09:53, Thomas Huth wrote:
>>> It is possible to enable only a subset of the block drivers with the
>>> "--block-drv-rw-whitelist" option of the "configure" script. All othe=
r
>>> drivers are marked as unusable (or only included as read-only with th=
e
>>> "--block-drv-ro-whitelist" option). If an iotest is now using such a
>>> disabled block driver, it is failing - which is bad, since at least t=
he
>>> tests in the "auto" group should be able to deal with this situation.=

>>> Thus let's introduce a "_require_drivers" function that can be used b=
y
>>> the shell tests to check for the availability of certain drivers firs=
t,
>>> and marks the test as "not run" if one of the drivers is missing.
>>
>> Well, the reasoning for generally not making blkdebug/blkverify explic=
it
>> requirements was that you should just have both enabled when running
>> iotests.
>=20
> Well, we disable blkverify in our downstream RHEL version of QEMU - so
> it would be great if the iotests could at least adapt to that missing
> driver.

I would like to say that RHEL is not a gold standard, but then I have
this series of selfish patches that specifically addresses RHEL
whitelisting issues.

It feels a bit weird to me to say =E2=80=9Cblkverify is not essential, be=
cause
RHEL disables it, but null-co is=E2=80=9D =E2=80=93 even though there is =
no reason why
anyone would need null-co except for testing either.

>> Of course, that no longer works as an argument now that we
>> unconditionally run some iotests in make check.
>>
>> But still, the question is how strict you want to be.  If blkdebug
>> cannot be assumed to be present, what about null-co?  What about raw?
>=20
> I tried to disable everything beside qcow2 - but that causes so many
> things to fail that it hardly makes sense to try to get that working.

Hm, really?  I just whitelisted qcow2 and file and running the auto
group worked rather well (except for the failing tests you address here,
and the two others I mentioned).

> I think we can assume that at least null-co, qcow2 and raw are enabled.=

> (If anybody still wants to try to run "make check" with one of these
> drivers disabled, I think we should rather add a superior check to
> tests/check-block.sh or tests/qemu-iotests/check instead and skip the
> iotests completely in that case).

I=E2=80=99m OK either way: We can add a global check, or we just make a d=
ecision
on what users definitely have to have enabled or the qemu build would be
a bit boring.

Assuming file, qcow2, and raw to be enabled seems reasonable.  I=E2=80=99=
m not
so sure about null-co.

(I mean, I personally don=E2=80=99t really care.  I never added such chec=
ks
myself, even a bit purposefully so, because it was my opinion that you
should probably have all block drivers whitelisted before running the
iotests.  But then came CI and make check-block integration...)

((Also, you=E2=80=99ll notice that I was really inconsequential about add=
ing
null-co checks in my =E2=80=9Cselfish patches=E2=80=9D series, precisely =
because I
assumed everyone would have whitelisted null-co.  So I=E2=80=99m indeed O=
K with
just making it an implicit prerequisite.))

>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  tests/qemu-iotests/071       |  1 +
>>>  tests/qemu-iotests/081       |  1 +
>>>  tests/qemu-iotests/099       |  1 +
>>>  tests/qemu-iotests/184       |  1 +
>>>  tests/qemu-iotests/common.rc | 13 +++++++++++++
>>>  5 files changed, 17 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
>>> index 1cca9233d0..fab526666b 100755
>>> --- a/tests/qemu-iotests/071
>>> +++ b/tests/qemu-iotests/071
>>> @@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>> =20
>>>  _supported_fmt qcow2
>>>  _supported_proto file
>>> +_require_drivers blkdebug blkverify
>>
>> Because this test also requires the raw driver.
>=20
> The test also works for me when I configured QEMU with:
>=20
>  --block-drv-rw-whitelist=3D"qcow2 file null-co blkdebug blkverify"
>=20
> i.e. the raw driver should be disabled in that case?

Ah, it=E2=80=99s just used by qemu-io, which of course ignores whitelisti=
ng.

>>> =20
>>>  do_run_qemu()
>>>  {
>>> diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
>>> index c418bab093..1695781bc0 100755
>>> --- a/tests/qemu-iotests/081
>>> +++ b/tests/qemu-iotests/081
>>> @@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>>  _supported_fmt raw
>>>  _supported_proto file
>>>  _supported_os Linux
>>> +_require_drivers quorum
>>
>> This test has already a check whether quorum is supported, that should=

>> be removed now.
>=20
> Hmm, true ... apparently that test was not working for my case ... coul=
d
> it be that qemu-img ignores the whitelist and simply says that all
> drivers are supported?

Ah, yeah.  The whitelist is relevant only for the system emulator.

I forgot why we even had the existing check, then.  Maybe just a mistake
to use qemu-img.

>> (Also, this test requires the raw driver.)
>=20
> Agreed, this test indeed does not work without 'raw'. But it is already=

> marked with "_supported_fmt raw", so you can indeed only run it with
> "raw". And running a raw-only test with a qemu binary where raw is
> disabled could be considered as user error, I guess ;-)

Oops, didn=E2=80=99t even notice somehow. O:-)

>>> diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
>>> index cb0c181228..33dd8d2a4f 100755
>>> --- a/tests/qemu-iotests/184
>>> +++ b/tests/qemu-iotests/184
>>> @@ -33,6 +33,7 @@ trap "exit \$status" 0 1 2 3 15
>>>  . ./common.filter
>>> =20
>>>  _supported_os Linux
>>> +_require_drivers throttle
>>
>> This test also requires null-co.
>>
>>>  do_run_qemu()
>>>  {
>>
>> I found two more check-block tests that may or may not require use of
>> _require_drivers (depending on which drivers we deem absolutely essent=
ial):
>> - 120: Needs raw
>> - 186: Needs null-co
>=20
> I think we really have to assume that null-co is available, otherwise
> too many things break... (also some qtests are using null-co).
>=20
> But I could for sure add a check for raw in 120 if desired.

If we assume that null-co is there, raw is definitely going to be there.

Max


--LKkr0BWfh7RGj8PjdKyK68pUfrzUEJP1b--

--wrHb1BvVzymlXkwb7aAn43yT0ao0OdFv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1cQH0ACgkQ9AfbAGHV
z0B0DQf+MLr7lFpdYcwbvJpxU2AzBZB5U/IDHXZaKE9Jp5nRTFw/ppnZrBgj3rPA
JoVXcPP4y6b4RwVzBeDZMw+UHpSHCJt3KJV+LX/jhf5uHW/xIl1ceJ2g4s3z+KF6
Nn3WcsYHnoitDH2a43ffS7PpEQr4AhfZMcbneIHE7lqml96jWLrnHFhYF4tI3/ia
fxae1cnAdPQ6Rou16xu03XYKXMnZ8qbGjBFU7ofXlVtXd3XNNHjwJoQizJVAv24Q
7G/orM6vhKu7vxg4/XrObn9o7Z2K7Z4jiG3hSsTIVsnsWiqQwWFMEPhypOm01QAM
I+tGm7dq5d9IRLdCCgJsGTegBC2uVA==
=GDZz
-----END PGP SIGNATURE-----

--wrHb1BvVzymlXkwb7aAn43yT0ao0OdFv9--

