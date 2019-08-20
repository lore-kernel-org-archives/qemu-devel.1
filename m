Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF52C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:10:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5112F2087E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5112F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06ih-0006PW-BG
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i06a3-0003wl-A3
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:01:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i06a1-0007aG-Fl
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:01:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i06Zx-0007XC-LZ; Tue, 20 Aug 2019 12:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 774E330001D8;
 Tue, 20 Aug 2019 16:01:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 334731001281;
 Tue, 20 Aug 2019 16:01:47 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190819075348.4078-1-thuth@redhat.com>
 <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
Date: Tue, 20 Aug 2019 18:01:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="y8ghsyWgMeHhHbcHSyz5m1zjS1V6r5RxF"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 20 Aug 2019 16:01:48 +0000 (UTC)
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
--y8ghsyWgMeHhHbcHSyz5m1zjS1V6r5RxF
Content-Type: multipart/mixed; boundary="Zy6N6YddBIY0XO5RYbO1rdgHjrXTZfrnL";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8e0ff9ce-c770-6ff6-3e41-494fef4bd40a@redhat.com>
Subject: Re: [PATCH] iotests: Check for enabled drivers before testing them
References: <20190819075348.4078-1-thuth@redhat.com>
 <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>
In-Reply-To: <5e753b9d-dd21-ce31-7f5c-7bc68c39cd2e@redhat.com>

--Zy6N6YddBIY0XO5RYbO1rdgHjrXTZfrnL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 5:01 PM, Max Reitz wrote:
> On 19.08.19 09:53, Thomas Huth wrote:
>> It is possible to enable only a subset of the block drivers with the
>> "--block-drv-rw-whitelist" option of the "configure" script. All other=

>> drivers are marked as unusable (or only included as read-only with the=

>> "--block-drv-ro-whitelist" option). If an iotest is now using such a
>> disabled block driver, it is failing - which is bad, since at least th=
e
>> tests in the "auto" group should be able to deal with this situation.
>> Thus let's introduce a "_require_drivers" function that can be used by=

>> the shell tests to check for the availability of certain drivers first=
,
>> and marks the test as "not run" if one of the drivers is missing.
>=20
> Well, the reasoning for generally not making blkdebug/blkverify explici=
t
> requirements was that you should just have both enabled when running
> iotests.

Well, we disable blkverify in our downstream RHEL version of QEMU - so
it would be great if the iotests could at least adapt to that missing
driver.

> Of course, that no longer works as an argument now that we
> unconditionally run some iotests in make check.
>=20
> But still, the question is how strict you want to be.  If blkdebug
> cannot be assumed to be present, what about null-co?  What about raw?

I tried to disable everything beside qcow2 - but that causes so many
things to fail that it hardly makes sense to try to get that working. I
think we can assume that at least null-co, qcow2 and raw are enabled.
(If anybody still wants to try to run "make check" with one of these
drivers disabled, I think we should rather add a superior check to
tests/check-block.sh or tests/qemu-iotests/check instead and skip the
iotests completely in that case).

>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/071       |  1 +
>>  tests/qemu-iotests/081       |  1 +
>>  tests/qemu-iotests/099       |  1 +
>>  tests/qemu-iotests/184       |  1 +
>>  tests/qemu-iotests/common.rc | 13 +++++++++++++
>>  5 files changed, 17 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
>> index 1cca9233d0..fab526666b 100755
>> --- a/tests/qemu-iotests/071
>> +++ b/tests/qemu-iotests/071
>> @@ -38,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>> =20
>>  _supported_fmt qcow2
>>  _supported_proto file
>> +_require_drivers blkdebug blkverify
>=20
> Because this test also requires the raw driver.

The test also works for me when I configured QEMU with:

 --block-drv-rw-whitelist=3D"qcow2 file null-co blkdebug blkverify"

i.e. the raw driver should be disabled in that case?

>> =20
>>  do_run_qemu()
>>  {
>> diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
>> index c418bab093..1695781bc0 100755
>> --- a/tests/qemu-iotests/081
>> +++ b/tests/qemu-iotests/081
>> @@ -41,6 +41,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>>  _supported_fmt raw
>>  _supported_proto file
>>  _supported_os Linux
>> +_require_drivers quorum
>=20
> This test has already a check whether quorum is supported, that should
> be removed now.

Hmm, true ... apparently that test was not working for my case ... could
it be that qemu-img ignores the whitelist and simply says that all
drivers are supported?

> (Also, this test requires the raw driver.)

Agreed, this test indeed does not work without 'raw'. But it is already
marked with "_supported_fmt raw", so you can indeed only run it with
"raw". And running a raw-only test with a qemu binary where raw is
disabled could be considered as user error, I guess ;-)

>> diff --git a/tests/qemu-iotests/184 b/tests/qemu-iotests/184
>> index cb0c181228..33dd8d2a4f 100755
>> --- a/tests/qemu-iotests/184
>> +++ b/tests/qemu-iotests/184
>> @@ -33,6 +33,7 @@ trap "exit \$status" 0 1 2 3 15
>>  . ./common.filter
>> =20
>>  _supported_os Linux
>> +_require_drivers throttle
>=20
> This test also requires null-co.
>
>>  do_run_qemu()
>>  {
>=20
> I found two more check-block tests that may or may not require use of
> _require_drivers (depending on which drivers we deem absolutely essenti=
al):
> - 120: Needs raw
> - 186: Needs null-co

I think we really have to assume that null-co is available, otherwise
too many things break... (also some qtests are using null-co).

But I could for sure add a check for raw in 120 if desired.

>> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.=
rc
>> index 5502c3da2f..7d4e68846f 100644
>> --- a/tests/qemu-iotests/common.rc
>> +++ b/tests/qemu-iotests/common.rc
>> @@ -520,5 +520,18 @@ _require_command()
>>      [ -x "$c" ] || _notrun "$1 utility required, skipped this test"
>>  }
>> =20
>> +# Check that a set of drivers has been whitelisted in the QEMU binary=

>> +#
>> +_require_drivers()
>> +{
>> +    available=3D$($QEMU -drive format=3Dhelp | grep 'Supported format=
s:')
> Seems a bit shortcut-y to not remove the =E2=80=9CSupported formats:=E2=
=80=9D prefix,
> but I don=E2=80=99t suppose we=E2=80=99ll ever have block drivers with =
either name...

I can remove it, just to be sure.

>> +    for driver
>> +    do
>> +        if ! echo "$available" | grep -q "$driver"; then
>=20
> 162 greps like this:
>=20
>> grep '^Supported formats:.* ssh\( \|$\)'
>=20
> Maybe the same should be done here, i.e. grep -q " $driver\( \|\$\)"?  =
I
> can well imagine that something like =E2=80=9Cssh=E2=80=9D might appear=
 as a substring
> in some other driver.

Fair, I'll add the spaces.

> (Speaking of which, why not change 162 to using this new function?  Yes=
,
> it isn=E2=80=99t in auto, but still...)

Yes, I can add that.

 Thomas


--Zy6N6YddBIY0XO5RYbO1rdgHjrXTZfrnL--

--y8ghsyWgMeHhHbcHSyz5m1zjS1V6r5RxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1cGWQACgkQLtnXdP5w
LbWkOxAAgEvDb8KFwEQEnx+BG6OtlH6Cea0Qo84Q7An3ifbu/CJt5PZvJobf+Ht2
vLbbO0ScV326ipsAvkTjh09uRaAuLk27lgBYG4stJLUA7RMiNmhBDcmVSEIUuAwY
oiElhhccE6eZtnWoalvhw+SXzP8CoqJYjhn81dVKAivRwhRNTUVSJXdHbsBoliwu
tk+THZ/tgmCZPX1DHur2c0QUP92oDN1w23xjWxhqagfaqrHjXqrmpiI0WpUmwGCu
Ko1yJcCRjk9vy/1D3p8TEyOMdk4ug1MPGUnCI/8aWYGQ3a7HFswMccnwG5XOg/mR
2bQObX3WdEKYIki23N0r4mvrP+TYkfaXLMTJbIk4vgN8m0iERh4KomTc0gAPx1bW
DUoXFX55bkG/Oaakmjulk3Oe8Czz7Ckknn09mnwYh4PfeorIyiYQssPf/0tPQKDZ
xKqAZ9F4ICn4LgkaIHtL1vIZ4WMRdLs/xk8DwrmOMS0eJMEE/vVWJ2B6fTzP+RnW
bfSqLOzVDWaRx5bL+IQfAyoQjbmFgWhXs+uZDr5ythlrGePKtm09WYthE3pFqCQY
6f+H5xvumrlatFvblc4G6IVI0OPqHFqE+id457axfjIUOXYpdCdlW3pZeqXND+rT
Syx5hWjMQOvgNgQW1GdMmrqWwJLkgRQHallSisBChP1IX39GgmE=
=Zjtg
-----END PGP SIGNATURE-----

--y8ghsyWgMeHhHbcHSyz5m1zjS1V6r5RxF--

