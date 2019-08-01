Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6BFC19759
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A29B12064A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 17:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29B12064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htEc3-00008f-SL
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 13:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39036)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1htEXT-0006jN-QJ
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1htEXM-0004yc-6L
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 13:06:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1htEXH-0004rN-5O; Thu, 01 Aug 2019 13:06:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23BF430BE970;
 Thu,  1 Aug 2019 17:06:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-187.brq.redhat.com
 [10.40.204.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E0BF419C68;
 Thu,  1 Aug 2019 17:06:26 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190801151235.8434-1-mreitz@redhat.com>
 <20190801151235.8434-3-mreitz@redhat.com>
 <68653483-e7d2-154a-75c6-2dfef235d33d@virtuozzo.com>
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
Message-ID: <738d7105-f91e-76ad-c2e6-cd5b32b846ef@redhat.com>
Date: Thu, 1 Aug 2019 19:06:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <68653483-e7d2-154a-75c6-2dfef235d33d@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Kpou63JoEoQ8yi1sBPQer1ra86YYEq9U4"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 01 Aug 2019 17:06:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] iotests: Test backup job with
 two guest writes
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kpou63JoEoQ8yi1sBPQer1ra86YYEq9U4
Content-Type: multipart/mixed; boundary="rNb0Jbbl3rCf8AQACOSyM2LFtJW40dHlc";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <738d7105-f91e-76ad-c2e6-cd5b32b846ef@redhat.com>
Subject: Re: [PATCH for-4.1 2/2] iotests: Test backup job with two guest
 writes
References: <20190801151235.8434-1-mreitz@redhat.com>
 <20190801151235.8434-3-mreitz@redhat.com>
 <68653483-e7d2-154a-75c6-2dfef235d33d@virtuozzo.com>
In-Reply-To: <68653483-e7d2-154a-75c6-2dfef235d33d@virtuozzo.com>

--rNb0Jbbl3rCf8AQACOSyM2LFtJW40dHlc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.08.19 18:03, Vladimir Sementsov-Ogievskiy wrote:
> 01.08.2019 18:12, Max Reitz wrote:
>> Perform two guest writes to not yet backed up areas of an image, where=

>> the former touches an inner area of the latter.
>>
>> Before HEAD^, copy offloading broke this in two ways:
>> (1) The output differs from the reference output (what the source was
>>      before the guest writes).
>> (2) But you will not see that in the failing output, because the job
>>      offset is reported as being greater than the job length.  This is=

>>      because one cluster is copied twice, and thus accounted for twice=
,
>>      but of course the job length does not increase.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/056     | 34 ++++++++++++++++++++++++++++++++++
>>   tests/qemu-iotests/056.out |  4 ++--
>>   2 files changed, 36 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
>> index f40fc11a09..d7198507f5 100755
>> --- a/tests/qemu-iotests/056
>> +++ b/tests/qemu-iotests/056
>> @@ -133,6 +133,7 @@ class BackupTest(iotests.QMPTestCase):
>>           self.vm =3D iotests.VM()
>>           self.test_img =3D img_create('test')
>>           self.dest_img =3D img_create('dest')
>> +        self.ref_img =3D img_create('ref')
>>           self.vm.add_drive(self.test_img)
>>           self.vm.launch()
>>  =20
>> @@ -140,6 +141,7 @@ class BackupTest(iotests.QMPTestCase):
>>           self.vm.shutdown()
>>           try_remove(self.test_img)
>>           try_remove(self.dest_img)
>> +        try_remove(self.ref_img)
>>  =20
>>       def hmp_io_writes(self, drive, patterns):
>>           for pattern in patterns:
>> @@ -177,6 +179,38 @@ class BackupTest(iotests.QMPTestCase):
>>               self.assert_qmp(event, 'data/error', qerror)
>>               return False
>>  =20
>> +    def test_overlapping_writes(self):
>> +        # Write something to back up
>> +        self.hmp_io_writes('drive0', [('42', '0M', '2M')])
>> +
>> +        # Create a reference backup
>> +        self.qmp_backup_and_wait(device=3D'drive0', format=3Diotests.=
imgfmt,
>> +                                 sync=3D'full', target=3Dself.ref_img=
)
>> +
>> +        # Now to the test backup: We simulate the following guest
>> +        # writes:
>> +        # (1) [1M + 64k, 1M + 128k): Afterwards, everything in that
>> +        #     area should be in the target image, and we must not cop=
y
>> +        #     it again (because the source image has changed now)
>> +        #     (64k is the job's cluster size)
>> +        # (2) [1M, 2M): The backup job must not get overeager.  It
>> +        #     must copy [1M, 1M + 64k) and [1M + 128k, 2M) separately=
,
>> +        #     but not the area in between.
>> +
>> +        self.qmp_backup(device=3D'drive0', format=3Diotests.imgfmt, s=
ync=3D'full',
>> +                        target=3Dself.dest_img, speed=3D1)
>> +
>> +        self.hmp_io_writes('drive0', [('23', '%ik' % (1024 + 64), '64=
k'),
>> +                                      ('66', '1M', '1M')])
>> +
>> +        # Let the job complete
>> +        res =3D self.vm.qmp('block-job-set-speed', device=3D'drive0',=
 speed=3D0)
>> +        self.assert_qmp(res, 'return', {})
>> +        self.qmp_backup_wait('drive0')
>> +
>> +        self.assertTrue(iotests.compare_images(self.ref_img, self.des=
t_img),
>> +                        'target image does not match reference image'=
)
>> +
>>       def test_dismiss_false(self):
>>           res =3D self.vm.qmp('query-block-jobs')
>>           self.assert_qmp(res, 'return', [])
>> diff --git a/tests/qemu-iotests/056.out b/tests/qemu-iotests/056.out
>> index dae404e278..36376bed87 100644
>> --- a/tests/qemu-iotests/056.out
>> +++ b/tests/qemu-iotests/056.out
>> @@ -1,5 +1,5 @@
>> -.........
>> +..........
>>   --------------------------------------------------------------------=
--
>> -Ran 9 tests
>> +Ran 10 tests
>>  =20
>>   OK
>>
>=20
> Failed for me:
> -..........
> +qemu-img: Could not open '/work/src/qemu/master/tests/qemu-iotests/scr=
atch/dest.qcow2': Failed to get shared "write" lock
> +Is another process using the image [/work/src/qemu/master/tests/qemu-i=
otests/scratch/dest.qcow2]?
> +......F...
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test_overlapping_writes (__main__.BackupTest)
> +----------------------------------------------------------------------=

> +Traceback (most recent call last):
> +  File "056", line 212, in test_overlapping_writes
> +    'target image does not match reference image')
> +AssertionError: False is not true : target image does not match refere=
nce image
> +
>   ---------------------------------------------------------------------=
-
>   Ran 10 tests
>=20
> -OK
> +FAILED (failures=3D1)

Hm.  I hoped seeing BLOCK_JOB_COMPLETED would be enough.

> So, with applied
>=20
> @@ -207,6 +207,7 @@ class BackupTest(iotests.QMPTestCase):
>           res =3D self.vm.qmp('block-job-set-speed', device=3D'drive0',=
 speed=3D0)
>           self.assert_qmp(res, 'return', {})
>           self.qmp_backup_wait('drive0')
> +        self.vm.shutdown()
>=20
>           self.assertTrue(iotests.compare_images(self.ref_img, self.des=
t_img),
>                           'target image does not match reference image'=
)

I=E2=80=99d personally prefer auto_dismiss=3DFalse and then block-job-dis=
miss.
Although I can=E2=80=99t give a reason why.

> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

In any case, thanks!

Max


--rNb0Jbbl3rCf8AQACOSyM2LFtJW40dHlc--

--Kpou63JoEoQ8yi1sBPQer1ra86YYEq9U4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1DHBAACgkQ9AfbAGHV
z0CBrQf/X3W94j7XghYN7JAHQmDMsh0yExZ2ELVRbRcIoojshGIYV+fb49LpBbb2
Ain3yvo8UoZBH8ASfqQBJ/QZTyMDbVFOv2WLXr7kVyICWUJlCZOPtwoNG1SuGs9c
vU7cAJJL0g3vbS4bAD4wuo2u0mGVZI8Mc2musSuBUYZj4YL4VNZYzqTGo+IqwwNi
WcSlhebQ6PwdM2wO4ZW9HkASeFUa9x2I26La2z2x144YFUJjpTOiqN7L+WRhp4tj
+r9xPZh5aLGQfa+AxLxJPn10CV21OUV4uzBXQ8quDJdnKn9VwSf4NahSdR71wh8y
ft/UOhUGpTnYPyAF8MA03dbMf9YEpg==
=DjB4
-----END PGP SIGNATURE-----

--Kpou63JoEoQ8yi1sBPQer1ra86YYEq9U4--

