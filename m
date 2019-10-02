Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D9AC352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1528F2133F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1528F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFe0K-0003fk-4Z
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFdyj-0002v3-FE
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFdyi-0002ug-4x
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:43:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38376)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFdye-0002rZ-5f; Wed, 02 Oct 2019 08:43:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 650D3300D1CA;
 Wed,  2 Oct 2019 12:43:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04E9060BC6;
 Wed,  2 Oct 2019 12:43:29 +0000 (UTC)
Subject: Re: [PATCH 20/22] iotests: Add tests for invalid Quorum @replaces
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-21-mreitz@redhat.com>
 <0851cb70-6c1c-13f6-43f1-05eca75e64e6@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <3f4e2675-4069-fb7e-ce1d-df211a4ad1f7@redhat.com>
Date: Wed, 2 Oct 2019 14:43:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <0851cb70-6c1c-13f6-43f1-05eca75e64e6@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9OBOweHUJkmhBzOz3Vssqib3O2UGcQJC2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 02 Oct 2019 12:43:31 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9OBOweHUJkmhBzOz3Vssqib3O2UGcQJC2
Content-Type: multipart/mixed; boundary="e609cZBMl6OcoDkydU8xGk9noq0Bd9NlT"

--e609cZBMl6OcoDkydU8xGk9noq0Bd9NlT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.09.19 16:30, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 18:28, Max Reitz wrote:
>> Add two tests to see that you cannot replace a Quorum child with the
>> mirror job while the child is in use by a different parent.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/041     | 57 ++++++++++++++++++++++++++++++++++++=
+-
>>   tests/qemu-iotests/041.out |  4 +--
>>   2 files changed, 58 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>> index 20ae9750b7..148dc47ce4 100755
>> --- a/tests/qemu-iotests/041
>> +++ b/tests/qemu-iotests/041
>> @@ -34,6 +34,8 @@ quorum_img3 =3D os.path.join(iotests.test_dir, 'quor=
um3.img')
>>   quorum_repair_img =3D os.path.join(iotests.test_dir, 'quorum_repair.=
img')
>>   quorum_snapshot_file =3D os.path.join(iotests.test_dir, 'quorum_snap=
shot.img')
>>  =20
>> +nbd_sock_path =3D os.path.join(iotests.test_dir, 'nbd.sock')
>> +
>>   class TestSingleDrive(iotests.QMPTestCase):
>>       image_len =3D 1 * 1024 * 1024 # MB
>>       qmp_cmd =3D 'drive-mirror'
>> @@ -901,7 +903,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
>>  =20
>>       def tearDown(self):
>>           self.vm.shutdown()
>> -        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_f=
ile ]:
>> +        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_f=
ile,
>> +                                 nbd_sock_path ]:
>>               # Do a try/except because the test may have deleted some=
 images
>>               try:
>>                   os.remove(i)
>> @@ -1075,6 +1078,58 @@ class TestRepairQuorum(iotests.QMPTestCase):
>>           self.assert_has_block_node("repair0", quorum_repair_img)
>>           self.vm.assert_block_path('quorum0/children.1', 'repair0')
>>  =20
>> +    '''
>> +    Check that we cannot replace a Quorum child when it has other
>> +    parents.
>> +    '''
>=20
> you constantly use ''', when PEP8 recommends """ for doc-strings. I can=
't
> complain, as our python code is something not related to PEP8 unfortuna=
tely..

I just use what I see in existing code.

(And additionally, in scripting languages I tend to just use what works.)=


>> +    def test_with_other_parent(self):
>=20
> don't we need
>          if not iotests.supports_quorum():
>              return
> like in neighbors?

Good point.  Or a decorator, probably.

>> +        result =3D self.vm.qmp('nbd-server-start',
>> +                             addr=3D{
>> +                                 'type': 'unix',
>> +                                 'data': {'path': nbd_sock_path}
>> +                             })
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', dev=
ice=3D'quorum0',
>> +                             sync=3D'full', node_name=3D'repair0', re=
places=3D'img1',
>> +                             target=3Dquorum_repair_img, format=3Diot=
ests.imgfmt)
>> +        self.assert_qmp(result, 'error/desc',
>> +                        "Cannot replace 'img1' by a node mirrored fro=
m "
>> +                        "'quorum0', because it cannot be guaranteed t=
hat doing "
>> +                        "so would not lead to an abrupt change of vis=
ible data")
>> +
>> +    '''
>> +    The same as test_with_other_parent(), but add the NBD server only=

>> +    when the mirror job is already running.
>> +    '''
>> +    def test_with_other_parents_after_mirror_start(self):
>> +        result =3D self.vm.qmp('nbd-server-start',
>> +                             addr=3D{
>> +                                 'type': 'unix',
>> +                                 'data': {'path': nbd_sock_path}
>> +                             })
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', dev=
ice=3D'quorum0',
>> +                             sync=3D'full', node_name=3D'repair0', re=
places=3D'img1',
>> +                             target=3Dquorum_repair_img, format=3Diot=
ests.imgfmt)
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        # The full error message goes to stderr, so we unfortunately
>> +        # cannot check it here
>=20
> We can, iotests 169 and 245 do it with help of vm.get_log()

Uh, thanks, I=E2=80=99ll look into it.

Max

>> +        self.complete_and_wait('mirror',
>> +                               completion_error=3D'Operation not perm=
itted')
>> +
>> +        # Should not have been replaced
>> +        self.vm.assert_block_path('quorum0/children.1', 'img1')
>> +
>> +
>>   # Test mirroring with a source that does not have any parents (not e=
ven a
>>   # BlockBackend)
>>   class TestOrphanedSource(iotests.QMPTestCase):
>> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
>> index f496be9197..ffc779b4d1 100644
>> --- a/tests/qemu-iotests/041.out
>> +++ b/tests/qemu-iotests/041.out
>> @@ -1,5 +1,5 @@
>> -.....................................................................=
=2E.....................
>> +.....................................................................=
=2E.......................
>>   --------------------------------------------------------------------=
--
>> -Ran 91 tests
>> +Ran 93 tests
>>  =20
>>   OK
>>
>=20
> With supports_quorum checked like in neighbor test-cases (or use @iotes=
ts.skip_if_unsupported):
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20



--e609cZBMl6OcoDkydU8xGk9noq0Bd9NlT--

--9OBOweHUJkmhBzOz3Vssqib3O2UGcQJC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2Um3AACgkQ9AfbAGHV
z0DpuAf9GCd4y88k25UyM4qDiViim+ar/gAe3wKuImwbF47YomyPm3g6wwiWqpVb
bMVZ1c79+HD+FKq09sqZMleRc3pLDZny2dPL76gHbRRGno+fAndWzmEYKexdQ8pc
AEDUOdnMHuRQFw2JLmn8qxpZldnbe4bBc0OFLzy2G2JSr7TfwMfiHrCtmg0dhLs7
6ZeRi+gLoXCEdMi62z+h+qN+U6syiWeXRu5fqRiIAXl0bofIY+z/fhID5Dx7StYI
QknH3M4mhkDAb5pyAkaLmDIVf3YwOCnvE8SdVmPk6LhDADd457X80emEeA5jBr2S
jV6t8lZ5PL3EGfxuHX74TCous8yOOw==
=7N0m
-----END PGP SIGNATURE-----

--9OBOweHUJkmhBzOz3Vssqib3O2UGcQJC2--

