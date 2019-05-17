Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F30EC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98D320848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98D320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRbJR-0002mN-9M
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:46:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRbIR-0002IE-Ct
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hRbIQ-0002Bj-CZ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:45:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hRbIK-00028C-Vn; Fri, 17 May 2019 07:45:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45A87308FBAF;
	Fri, 17 May 2019 11:45:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E37860BE0;
	Fri, 17 May 2019 11:44:59 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190517095628.10119-1-mreitz@redhat.com>
	<20190517095628.10119-4-mreitz@redhat.com>
	<20190517110038.GD7009@localhost.localdomain>
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
Message-ID: <48ca4b2d-5174-bfd0-48dc-ef748b04fa08@redhat.com>
Date: Fri, 17 May 2019 13:44:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517110038.GD7009@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kGKuzf3I3iJ93icuFaBacTPdwIzUiZidl"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 17 May 2019 11:45:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 3/4] iotests: Test driver whitelisting in
 093
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kGKuzf3I3iJ93icuFaBacTPdwIzUiZidl
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <48ca4b2d-5174-bfd0-48dc-ef748b04fa08@redhat.com>
Subject: Re: [PATCH 3/4] iotests: Test driver whitelisting in 093
References: <20190517095628.10119-1-mreitz@redhat.com>
 <20190517095628.10119-4-mreitz@redhat.com>
 <20190517110038.GD7009@localhost.localdomain>
In-Reply-To: <20190517110038.GD7009@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.05.19 13:00, Kevin Wolf wrote:
> Am 17.05.2019 um 11:56 hat Max Reitz geschrieben:
>> null-aio may not be whitelisted.  If it is not, fall back to null-co.
>> This may run tests twice in the same configuration, but this is the
>> simplest way to effectively skip the tests in setUp() (without changin=
g
>> the output, and while having the respective driver in a class
>> attribute).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/093 | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
>> index bd56c94708..d6f285001a 100755
>> --- a/tests/qemu-iotests/093
>> +++ b/tests/qemu-iotests/093
>> @@ -22,9 +22,11 @@
>>  import iotests
>> =20
>>  nsec_per_sec =3D 1000000000
>> +supported_null_drivers =3D list(filter(lambda f: f.startswith('null-'=
),
>> +                                     iotests.supported_formats()))
>=20
> Is this just a convoluted way of writing the following?
>=20
>     supported_null_drivers =3D [ f for f in iotests.supported_formats()=

>                                if f.startswith('null-') ]

Well, it=E2=80=99s a different way, yes.  I would call it the Ruby way, b=
ut that
would have been "iotests.supported_formats() & ['null-co', 'null-aio']".
 (And with list(set() & set()) it suddenly isn=E2=80=99t short anymore.)

Sorry, I=E2=80=99m just not suited for Python.

>>  class ThrottleTestCase(iotests.QMPTestCase):
>> -    test_img =3D "null-aio://"
>> +    test_driver =3D "null-aio"
>>      max_drives =3D 3
>> =20
>>      def blockstats(self, device):
>> @@ -36,9 +38,14 @@ class ThrottleTestCase(iotests.QMPTestCase):
>>          raise Exception("Device not found for blockstats: %s" % devic=
e)
>> =20
>>      def setUp(self):
>> +        global supported_null_drivers
>> +        if self.test_driver not in supported_null_drivers:
>> +            # Silently fall back to supported driver
>> +            self.test_driver =3D supported_null_drivers[0]
>=20
> I think this is what you mentioned in the cover letter:
>=20
>> Final note: The best thing would probably to skip the null-aio tests i=
n
>> 093/136 if there is no null-aio support.  However, I didn=E2=80=99t ge=
t anything
>> to work: Annotating with @iotests.skip_if_unsupported() didn=E2=80=99t=
 work
>> because the format name is a class instance attribute; and just
>> iotests.skipTest() didn=E2=80=99t work because that would print 's' ch=
aracters
>>  instead of '.' in the output (and emit the number of skipped tests), =
so
>> the comparison against the reference output fails...
>=20
> With a little modification to the @skip_if_unsupported() decorator it
> can be done. I think I'd prefer this (hacked up on top of this series):=


Hm.  I really don=E2=80=99t like having to put it above every single test=

method, and putting it above setUp() has the problem of not actually
skipping the test.

I guess I=E2=80=99ll look back into filtering the test output to remove t=
he
=E2=80=9Cskipped=E2=80=9D stuff.

Max


--kGKuzf3I3iJ93icuFaBacTPdwIzUiZidl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzenrkACgkQ9AfbAGHV
z0B1QQf/SNEnv5XT0oG7YOlCiV34YK+XqUyQ5prfya5+mq3/smaGcJ0SFxBqGiM0
ioK5S7mVmwynpKHifUXu3FB50WAL4iZCy5Xr4Bcbp1ZbjYkLmJqb1hzMSeFc5l5n
GVjmpy/sTLxPlDB0wmZE4dpQECT60kqXofyiKwqjHLPf+R3O0llhN4hv//5SPZkK
ljbNgFAd2ahVdpMokksztHRK8zrQr0aK+uQVfBFf89Hvecuhv3ggzkuOR/KCroeW
cWs0v2KSRYLu6SWzfQUp17JNYsCSMkafhMeqdT4D1RCkYUusR1IcsD0KpTxc6FFw
qBkM3EznF6gD18OFq+SQBTHAtuPh1w==
=I9Gu
-----END PGP SIGNATURE-----

--kGKuzf3I3iJ93icuFaBacTPdwIzUiZidl--

