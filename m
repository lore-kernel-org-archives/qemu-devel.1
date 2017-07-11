Received: from eggs.gnu.org ([2001:4830:134:3::10]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUwGd-0003Wo-J9
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUwGc-000510-NY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 10:35:59 -0400
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
	<CAFEAcA_=YZFScbOU_nBLpzGuupo6EKNcSZhJGDZQZeTu7KVq4A@mail.gmail.com>
	<20170710111649.GB5772@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e7a547a2-132d-bc4e-c249-7f802b74d249@redhat.com>
Date: Tue, 11 Jul 2017 16:35:44 +0200
MIME-Version: 1.0
In-Reply-To: <20170710111649.GB5772@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wsKHu5XDBWk8E41rNTIQ2NIXfIOC4BLHr"
Subject: Re: [Qemu-devel] [Qemu-block]  [PULL 000/100] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wsKHu5XDBWk8E41rNTIQ2NIXfIOC4BLHr
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Message-ID: <e7a547a2-132d-bc4e-c249-7f802b74d249@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PULL 000/100] Block layer patches
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
 <CAFEAcA_=YZFScbOU_nBLpzGuupo6EKNcSZhJGDZQZeTu7KVq4A@mail.gmail.com>
 <20170710111649.GB5772@noname.redhat.com>
In-Reply-To: <20170710111649.GB5772@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-07-10 13:16, Kevin Wolf wrote:
> Am 10.07.2017 um 11:28 hat Peter Maydell geschrieben:
>> On 7 July 2017 at 18:07, Kevin Wolf <kwolf@redhat.com> wrote:
>>> The following changes since commit b11365867568ba954de667a0bfe0945b8f=
78d6bd:
>>>
>>>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-201707=
06' into staging (2017-07-06 11:42:59 +0100)
>>>
>>> are available in the git repository at:
>>>
>>>
>>>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>>>
>>> for you to fetch changes up to 7d982302db173616d011e07ee43be3b0aae872=
b1:
>>>
>>>   Merge remote-tracking branch 'mreitz/tags/pull-block-2017-07-07' in=
to queue-block (2017-07-07 18:11:41 +0200)
>>>
>>> ----------------------------------------------------------------
>>>
>>> Block layer patches
>>
>> Hi -- I'm afraid this doesn't build with clang:
>=20
> My clang didn't complain, unfortunately.
>=20
>>   CC      block/qcow2-bitmap.o
>> /home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1183:9:
>> error: variable 'ret' is used uninitialized whenever 'if' condition is=

>> true [-Werror,-Wsometimes-uninitialized]
>>     if (tb_offset < 0) {
>>         ^~~~~~~~~~~~~
>> /home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1222:12:
>> note: uninitialized use occurs here
>>     return ret;
>>            ^~~
>> /home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1183:5:
>> note: remove the 'if' if its condition is always false
>>     if (tb_offset < 0) {
>>     ^~~~~~~~~~~~~~~~~~~~
>> /home/petmay01/linaro/qemu-for-merges/block/qcow2-bitmap.c:1165:12:
>> note: initialize the variable 'ret' to silence this warning
>>     int ret;
>>            ^
>>             =3D 0
>> 1 error generated.
>>
>> Looking at the code, the compiler appears to be correct
>> that that error-exit path has forgotten to set ret.
>=20
> Indeed. This is from commit 519d4789 ('qcow2: add persistent dirty
> bitmaps support') and came through Max' tree.
>=20
> Max, I'll split the pull request and send only my tree in v2. Please
> submit a separate pull request for the patches in your tree once the
> build is fixed.

OK, will do.

Max


--wsKHu5XDBWk8E41rNTIQ2NIXfIOC4BLHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZZOJAEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKLX
B/4mmVwOK/pfERJWS7jic5dsMg9cxIMJ3fT0SZo2LyeNBlBSFQ8YBGEE3PbKXhXs
JuaTNZkT0pmAE/cv33rVPTqMYOtJCZoFwEPdkU+5DcSn765QyZeCFMnwzxsqm/CO
O6Yqq3Qn3w2ELRrGvvinmcA2GFHyB41wH1A/99UJ/FJOlsZ2GkQytbwMhmy4YY3G
kDYpitlQNKdEVv0qU0ilrOGuqgCaYU6o+m0rKU7J/vjZ6eq+L/tPWdXouPj6wLbS
GwV0MPDqFF9e9/kkkcNrmOlpUjvmjFRyoF6c0WmJ3gJcyIqzk2VwbDhGUQMwqGdB
Rwh33qnfFx1cClpJwdmgRxRV
=06ec
-----END PGP SIGNATURE-----

--wsKHu5XDBWk8E41rNTIQ2NIXfIOC4BLHr--
