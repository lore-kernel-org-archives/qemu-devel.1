Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE18C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:51:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B6332173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 12:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bv5AUU1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B6332173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j42LF-0000uz-EU
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 07:51:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j42JN-0006fd-B9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:49:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j42JL-0004Yy-T7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:49:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24275
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j42JL-0004Yq-NU
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 07:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582030151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=G9rQDcCwGV6U/E4nFmQHJsvUD4A1EkEfp6d505tHkh4=;
 b=Bv5AUU1H2hoBONUN3vVx4p2bXAyJS7nI1fgc8r3SCXUNna/KIIFvpcEDXQ1Ks4c5/b2cHx
 gYXa+pDLJm4MDuMyqpmjvT244T9LQAUVdutdDnJkmK6GQRvb0Oaqsc4QBwABRlCz8BBnho
 vvP9DJFnPuTEfTb02jJaE6KOCn5kDgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-eLhF3vMdN7yXJKHu_UQaIw-1; Tue, 18 Feb 2020 07:49:09 -0500
X-MC-Unique: eLhF3vMdN7yXJKHu_UQaIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26042800D50;
 Tue, 18 Feb 2020 12:49:08 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 887D95DA60;
 Tue, 18 Feb 2020 12:49:06 +0000 (UTC)
Subject: Re: [PATCH v4 18/19] iotests: Add tests for invalid Quorum @replaces
To: Kevin Wolf <kwolf@redhat.com>
References: <20200218103454.296704-1-mreitz@redhat.com>
 <20200218103454.296704-19-mreitz@redhat.com>
 <20200218123827.GC6157@linux.fritz.box>
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
Message-ID: <49c02a45-dc13-078a-fb16-4ef57feb04e1@redhat.com>
Date: Tue, 18 Feb 2020 13:49:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218123827.GC6157@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Sufev5kDQKLYthbyRrprWuqYv2YlcsRgR"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sufev5kDQKLYthbyRrprWuqYv2YlcsRgR
Content-Type: multipart/mixed; boundary="1bEEq9P6EEa76EMWRndatjGfvbtKEG3V1"

--1bEEq9P6EEa76EMWRndatjGfvbtKEG3V1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.02.20 13:38, Kevin Wolf wrote:
> Am 18.02.2020 um 11:34 hat Max Reitz geschrieben:
>> Add two tests to see that you cannot replace a Quorum child with the
>> mirror job while the child is in use by a different parent.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>  tests/qemu-iotests/041     | 70 +++++++++++++++++++++++++++++++++++++-
>>  tests/qemu-iotests/041.out |  4 +--
>>  2 files changed, 71 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>> index 1d9e64ff6d..53c8671969 100755
>> --- a/tests/qemu-iotests/041
>> +++ b/tests/qemu-iotests/041
>> @@ -20,6 +20,7 @@
>> =20
>>  import time
>>  import os
>> +import re
>>  import iotests
>>  from iotests import qemu_img, qemu_io
>> =20
>> @@ -34,6 +35,8 @@ quorum_img3 =3D os.path.join(iotests.test_dir, 'quorum=
3.img')
>>  quorum_repair_img =3D os.path.join(iotests.test_dir, 'quorum_repair.img=
')
>>  quorum_snapshot_file =3D os.path.join(iotests.test_dir, 'quorum_snapsho=
t.img')
>> =20
>> +nbd_sock_path =3D os.path.join(iotests.test_dir, 'nbd.sock')
>> +
>>  class TestSingleDrive(iotests.QMPTestCase):
>>      image_len =3D 1 * 1024 * 1024 # MB
>>      qmp_cmd =3D 'drive-mirror'
>> @@ -892,7 +895,8 @@ class TestRepairQuorum(iotests.QMPTestCase):
>> =20
>>      def tearDown(self):
>>          self.vm.shutdown()
>> -        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_fil=
e ]:
>> +        for i in self.IMAGES + [ quorum_repair_img, quorum_snapshot_fil=
e,
>> +                                 nbd_sock_path ]:
>>              # Do a try/except because the test may have deleted some im=
ages
>>              try:
>>                  os.remove(i)
>> @@ -1032,6 +1036,70 @@ class TestRepairQuorum(iotests.QMPTestCase):
>>          self.assert_has_block_node("repair0", quorum_repair_img)
>>          self.vm.assert_block_path('quorum0', '/children.1', 'repair0')
>> =20
>> +    def test_with_other_parent(self):
>> +        """
>> +        Check that we cannot replace a Quorum child when it has other
>> +        parents.
>> +        """
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
>> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', devic=
e=3D'quorum0',
>> +                             sync=3D'full', node_name=3D'repair0', repl=
aces=3D'img1',
>> +                             target=3Dquorum_repair_img, format=3Diotes=
ts.imgfmt)
>> +        self.assert_qmp(result, 'error/desc',
>> +                        "Cannot replace 'img1' by a node mirrored from =
"
>> +                        "'quorum0', because it cannot be guaranteed tha=
t doing "
>> +                        "so would not lead to an abrupt change of visib=
le data")
>> +
>> +    def test_with_other_parents_after_mirror_start(self):
>> +        """
>> +        The same as test_with_other_parent(), but add the NBD server
>> +        only when the mirror job is already running.
>> +        """
>> +        result =3D self.vm.qmp('nbd-server-start',
>> +                             addr=3D{
>> +                                 'type': 'unix',
>> +                                 'data': {'path': nbd_sock_path}
>> +                             })
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', devic=
e=3D'quorum0',
>> +                             sync=3D'full', node_name=3D'repair0', repl=
aces=3D'img1',
>> +                             target=3Dquorum_repair_img, format=3Diotes=
ts.imgfmt)
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('nbd-server-add', device=3D'img1')
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        # The full error message goes to stderr, we will check it later
>> +        self.complete_and_wait('mirror',
>> +                               completion_error=3D'Operation not permit=
ted')
>> +
>> +        # Should not have been replaced
>> +        self.vm.assert_block_path('quorum0', '/children.1', 'img1')
>> +
>> +        # Check the full error message now
>> +        self.vm.shutdown()
>> +        log =3D self.vm.get_log()
>> +        log =3D re.sub(r'^\[I \d+\.\d+\] OPENED\n', '', log)
>> +        log =3D re.sub(r'^Formatting.*\n', '', log)
>> +        log =3D re.sub(r'\n\[I \+\d+\.\d+\] CLOSED\n?$', '', log)
>> +        log =3D re.sub(r'^qemu-system-[^:]*: ', '', log)
>=20
> I would have applied the series, but:
>=20
> +.........................F..............................................=
......................
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +FAIL: test_with_other_parents_after_mirror_start (__main__.TestRepairQuo=
rum)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "041", line 1099, in test_with_other_parents_after_mirror_start
> +    "it can no longer be guaranteed that doing so would " +
> +AssertionError: "qemu: Can no longer replace 'img1' by 're[107 chars]dat=
a" !=3D "Can no longer replace 'img1' by 'repair0'[101 chars]data"
> +- qemu: Can no longer replace 'img1' by 'repair0', because it can no lon=
ger be guaranteed that doing so would not lead to an abrupt change of visib=
le data
> +? ------
> ++ Can no longer replace 'img1' by 'repair0', because it can no longer be=
 guaranteed that doing so would not lead to an abrupt change of visible dat=
a
> +
> +
>=20
> If you agree, I can just change this line while applying into:
>=20
>     log =3D re.sub(r'^qemu[^:]*: ', '', log)

Sure, thanks!  I just hope noone uses the QEMU environment variable to
point to something that isn=E2=80=99t prefixed by =E2=80=9Cqemu=E2=80=9D...

Max


--1bEEq9P6EEa76EMWRndatjGfvbtKEG3V1--

--Sufev5kDQKLYthbyRrprWuqYv2YlcsRgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5L3UAACgkQ9AfbAGHV
z0B+dgf7BXYhJZhRfAN1KVN46lXqOqIQXKdGobQWvPNWHeY+5bNSXwpraanRN4lY
NpZtySBlfzlXUXqkl542isKIcobFatRZZivR0ssevbjjgktNKk6JMERz7RGku4UG
BZP4SKId3NVDnX0Pc3gaeIAo3d90Yt6G0TWvh7qWhge6lVwoZ/LSnueFwGWUnVES
ccRa5an9qlzy++kpdlEg+ZXhvrjj4EzWFNAgMSbaN5oB48sjLALehkPqkMxqrK+v
4U79c89+jeEsG0nQJoLZNZ4EluhILYdzHEdvDZyCuNuQzFpjwux4SSciB+hEboia
PUlYAWAEQUj2+DM6TcMt490Nu+6FFA==
=92ME
-----END PGP SIGNATURE-----

--Sufev5kDQKLYthbyRrprWuqYv2YlcsRgR--


