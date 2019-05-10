Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C38C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E112208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 17:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E112208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47905 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP9mN-00075y-CB
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 13:57:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hP9Vw-0007xr-QG
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hP9Vv-0003Ur-3Y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 13:40:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hP9Vr-0003Rx-EK; Fri, 10 May 2019 13:40:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4474356D5;
	Fri, 10 May 2019 17:40:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-59.brq.redhat.com
	[10.40.204.59])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 45D2D6015A;
	Fri, 10 May 2019 17:40:40 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190502084506.8009-1-thuth@redhat.com>
	<20190502084506.8009-8-thuth@redhat.com>
	<413645a6-385c-e112-ad9c-8525ef3d9e52@redhat.com>
	<eda4c5c1-45b8-79d2-1337-f5ee4c68f759@redhat.com>
	<a3ef5755-4c5d-98d9-3f22-e776d5b48b73@redhat.com>
	<60bbf536-fd61-aade-dbff-f0914615c412@redhat.com>
	<3f86e4a2-a985-7c70-d8ea-fe28740b4c1b@redhat.com>
	<ffdd7491-92dc-aacb-8912-92ddba450761@redhat.com>
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
Message-ID: <22bd2d94-80ae-fef3-5a48-80a4f6f8ef74@redhat.com>
Date: Fri, 10 May 2019 19:40:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ffdd7491-92dc-aacb-8912-92ddba450761@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NEABNleZ2s88P12IEIv1KuwJjOADHi42E"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Fri, 10 May 2019 17:40:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 7/7] tests: Run the iotests during "make
 check" again
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
	Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Markus Armbruster <armbru@redhat.com>,
	Christophe Fergeau <cfergeau@redhat.com>,
	Wainer dos Santos Moschetta <wainersm@redhat.com>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NEABNleZ2s88P12IEIv1KuwJjOADHi42E
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Christophe Fergeau <cfergeau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Message-ID: <22bd2d94-80ae-fef3-5a48-80a4f6f8ef74@redhat.com>
Subject: Re: [PATCH v3 7/7] tests: Run the iotests during "make check" again
References: <20190502084506.8009-1-thuth@redhat.com>
 <20190502084506.8009-8-thuth@redhat.com>
 <413645a6-385c-e112-ad9c-8525ef3d9e52@redhat.com>
 <eda4c5c1-45b8-79d2-1337-f5ee4c68f759@redhat.com>
 <a3ef5755-4c5d-98d9-3f22-e776d5b48b73@redhat.com>
 <60bbf536-fd61-aade-dbff-f0914615c412@redhat.com>
 <3f86e4a2-a985-7c70-d8ea-fe28740b4c1b@redhat.com>
 <ffdd7491-92dc-aacb-8912-92ddba450761@redhat.com>
In-Reply-To: <ffdd7491-92dc-aacb-8912-92ddba450761@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.05.19 18:20, Thomas Huth wrote:
> On 10/05/2019 15.47, Max Reitz wrote:
>> On 10.05.19 15:36, Thomas Huth wrote:
>>> On 10/05/2019 15.34, Max Reitz wrote:
>>>> On 10.05.19 06:29, Thomas Huth wrote:
>>>>> On 09/05/2019 20.08, Max Reitz wrote:
>>>>>> On 02.05.19 10:45, Thomas Huth wrote:
>>>>>>> People often forget to run the iotests before submitting patches =
or
>>>>>>> pull requests - this is likely due to the fact that we do not run=
 the
>>>>>>> tests during our mandatory "make check" tests yet. Now that we've=
 got
>>>>>>> a proper "auto" group of iotests that should be fine to run in ev=
ery
>>>>>>> environment, we can enable the iotests during "make check" again =
by
>>>>>>> running the "auto" tests by default from the check-block.sh scrip=
t.
>>>>>>>
>>>>>>> Some cases still need to be checked first, though: iotests need b=
ash
>>>>>>> and GNU sed (otherwise they fail), and if gprof is enabled, it sp=
oils
>>>>>>> the output of some test cases causing them to fail. So if we dete=
ct
>>>>>>> that one of the required programs is missing or that gprof is ena=
bled,
>>>>>>> we still have to skip the iotests to avoid failures.
>>>>>>>
>>>>>>> And finally, since we are using check-block.sh now again, this pa=
tch also
>>>>>>> removes the qemu-iotests-quick.sh script since we do not need tha=
t anymore
>>>>>>> (and having two shell wrapper scripts around the block tests seem=

>>>>>>> rather confusing than helpful).
>>>>>>>
>>>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>>>> ---
>>>>>>>  tests/Makefile.include      |  8 +++----
>>>>>>>  tests/check-block.sh        | 44 ++++++++++++++++++++++++++++---=
------
>>>>>>>  tests/qemu-iotests-quick.sh |  8 -------
>>>>>>>  3 files changed, 38 insertions(+), 22 deletions(-)
>>>>>>>  delete mode 100755 tests/qemu-iotests-quick.sh
>>>>>>
>>>>>> Can I interest you in a Makefile target that explicitly excludes
>>>>>> check-block?  I run the iotests anyway, but I also run make check.=

>>>>>> Running some iotests twice would be a bit pointless.
>>>>>
>>>>> Can't you simply run
>>>>>
>>>>>  ./check -qcow2 -x auto
>>>>>
>>>>> instead?
>>>>
>>>> I don=E2=80=99t run just qcow2 tests.  I run qcow2, qcow2 with compa=
t=3D0.10,
>>>> qcow2 with refcount_bits=3D1, raw, nbd, qed, vmdk, vhdx, ...  A lot.=

>>>>
>>>> So for which of the protocol/format combinations do I exclude the au=
to
>>>> group?  check-block.sh says it runs raw, qcow2, qed, vmdk, and vpc. =
 But
>>>> may that not be subject to change?
>>>
>>> With my patch series, the auto group is only used for qcow2.
>>
>> And that is not subject to change?  Like, maybe someone wants to add n=
bd
>> in the future?
>=20
> The current set of qcow2 auto tests takes already quite a while, so I
> don't think that this will change soon.
> And if the "normal" users want to run more tests, they can simply use
> "make check SPEED=3Dslow" or SPEED=3Dthorough, so IMHO no need to exten=
d the
> quick default list right now.
>=20
>> I mean, I have a test branch anyway which collects a number of patches=

>> on top of master that make everything pass more or less reliably for m=
e
>> (11 patches currently...).  I suppose I can just revert your patch on
>> top of that.  But that doesn=E2=80=99t feel right.
>=20
> Hmm, sure, non-upstream patches are always a bad thing. But I still
> don't see why you really need an extra Makefile target for this. In the=

> worst case, you could also simply change your script to run something
> this instead:
>=20
>  make $(grep ^check: tests/Makefile.include | sed s/check-block//)
>=20
> ?

Hm.  I didn=E2=80=99t think of that.  Thanks. :-)

Max


--NEABNleZ2s88P12IEIv1KuwJjOADHi42E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzVt5YACgkQ9AfbAGHV
z0Baagf+IzuF3VEJ8zq/CoJv73W3i35Hn2+/K3daTkwVlUQkMeqmD02SzanSZb8n
drihmcpK+CcVVURK9Q2I6WNPJIUyY0QtD1L/2sBbzIxINwYpnjc36MeH2jNLYFzC
nQJQO/JDtcmYuDgbyn350S+KQv28lys+ZZ38Kn8f6sHHEgfLigtB57c7rdenTwVy
ZE2dB+dxKdtdRrVL39IiOlcFBlrXLubMpDX17Gbg7TOpzgJdTouqblqOmmlColIs
hocV2jLZiWRDhRdLhAJ8O1J9tXz7RjqQKFiSHL70A+f+onlwJpGbnhII6JWLleDB
bE2EvR9/S5ng0IiDORvqwXzQX/CnAg==
=yshR
-----END PGP SIGNATURE-----

--NEABNleZ2s88P12IEIv1KuwJjOADHi42E--

