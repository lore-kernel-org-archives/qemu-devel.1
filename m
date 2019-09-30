Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B73C32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F6420679
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 15:05:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F6420679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iExEq-0005eH-T5
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 11:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iExAo-00033C-0B
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iExAm-0000SA-L9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 11:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58092)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iExAe-0000Na-Or; Mon, 30 Sep 2019 11:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3544C0568FA;
 Mon, 30 Sep 2019 15:01:03 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-240.brq.redhat.com
 [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C6B7A5D712;
 Mon, 30 Sep 2019 15:01:02 +0000 (UTC)
Subject: Re: [PATCH 09/18] iotests: Drop IMGOPTS use in 267
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-10-mreitz@redhat.com>
 <1c6c86af32c3de1b473b48704cf506694c10c597.camel@redhat.com>
 <ee7488a7-9c85-1b37-0a28-d7cfee890f2d@redhat.com>
 <f7095f775cfae1b5dd7d317b16ec9deaf903435b.camel@redhat.com>
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
Message-ID: <c981dc5e-297d-1c7d-783e-0d9b87005448@redhat.com>
Date: Mon, 30 Sep 2019 17:01:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <f7095f775cfae1b5dd7d317b16ec9deaf903435b.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qr7gj6FlyVARjYeHkH2pu85lJtyI7GqTK"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 30 Sep 2019 15:01:04 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qr7gj6FlyVARjYeHkH2pu85lJtyI7GqTK
Content-Type: multipart/mixed; boundary="wjN7MzpkED0aAuX0Phs9ksu1Fh2CXOe7c"

--wjN7MzpkED0aAuX0Phs9ksu1Fh2CXOe7c
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.09.19 16:32, Maxim Levitsky wrote:
> On Mon, 2019-09-30 at 15:01 +0200, Max Reitz wrote:
>> On 29.09.19 18:33, Maxim Levitsky wrote:
>>> On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
>>>> Overwriting IMGOPTS means ignoring all user-supplied options, which =
is
>>>> not what we want.  Replace the current IMGOPTS use by a new BACKING_=
FILE
>>>> variable.
>>>>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/267 | 12 ++++++++----
>>>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
>>>> index 95f885442f..529f5f9afe 100755
>>>> --- a/tests/qemu-iotests/267
>>>> +++ b/tests/qemu-iotests/267
>>>> @@ -68,7 +68,11 @@ size=3D128M
>>>> =20
>>>>  run_test()
>>>>  {
>>>> -    _make_test_img $size
>>>> +    if [ -n "$BACKING_FILE" ]; then
>>>> +        _make_test_img -b "$BACKING_FILE" $size
>>>> +    else
>>>> +        _make_test_img $size
>>>> +    fi
>>>>      printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qem=
u "$@" | _filter_date
>>>>  }
>>>> =20
>>>> @@ -119,12 +123,12 @@ echo
>>>> =20
>>>>  TEST_IMG=3D"$TEST_IMG.base" _make_test_img $size
>>>> =20
>>>> -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
>>>> +BACKING_FILE=3D"$TEST_IMG.base" \
>>>>  run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-n=
ame=3Dbacking-file \
>>>>           -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3D=
file \
>>>>           -blockdev driver=3D$IMGFMT,file=3Dfile,backing=3Dbacking-f=
ile,node-name=3Dfmt
>>>> =20
>>>> -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" \
>>>> +BACKING_FILE=3D"$TEST_IMG.base" \
>>>>  run_test -blockdev driver=3Dfile,filename=3D"$TEST_IMG.base",node-n=
ame=3Dbacking-file \
>>>>           -blockdev driver=3D$IMGFMT,file=3Dbacking-file,node-name=3D=
backing-fmt \
>>>>           -blockdev driver=3Dfile,filename=3D"$TEST_IMG",node-name=3D=
file \
>>>> @@ -141,7 +145,7 @@ echo
>>>>  echo "=3D=3D=3D -blockdev with NBD server on the backing file =3D=3D=
=3D"
>>>>  echo
>>>> =20
>>>> -IMGOPTS=3D"backing_file=3D$TEST_IMG.base" _make_test_img $size
>>>> +_make_test_img -b "$TEST_IMG.base" $size
>>>>  cat <<EOF |
>>>>  nbd_server_start unix:$TEST_DIR/nbd
>>>>  nbd_server_add -w backing-fmt
>>>
>>> qemu's master (pulled today), don't have iotest 267,
>>> you probably based this on some not yet merged branch.
>>> Or I made some mistake with pulling the master branch.
>>
>> Yep, it=E2=80=99s only in Kevin=E2=80=99s block branch (and thus mine,=
 too).  He sent a
>> pull request for it, which was rejected though (because this test is
>> broken on anything but x64, but that doesn=E2=80=99t stop this patch).=

>>
>=20
> I figured out that it must be something like that.
> Being lazy, I would like to ask if we have maybe a list of these=20
> branches somewhere in the wiki?

The MAINTAINERS file has at least Kevin=E2=80=99s branch:

$ scripts/get_maintainer.pl --scm --no-email --no-l -f block
git https://repo.or.cz/qemu/kevin.git block

Max


--wjN7MzpkED0aAuX0Phs9ksu1Fh2CXOe7c--

--Qr7gj6FlyVARjYeHkH2pu85lJtyI7GqTK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2SGK0ACgkQ9AfbAGHV
z0AwAwf/Z+HTNqK3fAvAU69rBk8YuUcUQxzb0Fg/dWa4ZZkdHUb5BZ5eB1BpcXzB
o0wOzFJFTP90LjiJaq0Yj6kjOHSUjBd+a0d+gLGQqqXJEDdgGM/fa6fJVPxgR69U
j/OTqO5Y3/mBTqS4BZBhHTlWpWo8CVdUJrwq6qzvsNXU7LajdmLOwXZ4xQazDgy3
yCWDrt7ePMqlLJKhnHu65SUGbm4fA2QHA9uGxQFtJJfJBh89Z80vzbzG8XCT4Al0
K0PRwtLWlcubn1fZVtXwBTL3YQtbxk1bSYWhVaEEITyuRez54IfuhBkpFdjcW7qA
MA1zH8AVK5n4T8UX1+fLgyXyTcZlQg==
=rCRK
-----END PGP SIGNATURE-----

--Qr7gj6FlyVARjYeHkH2pu85lJtyI7GqTK--

