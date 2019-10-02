Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C81C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211DC20700
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 11:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211DC20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFcOh-0008PZ-8J
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 07:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60930)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFcMo-0007cp-AI
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFcMm-0002x0-I2
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 07:00:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51884)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFcMg-0002rw-PE; Wed, 02 Oct 2019 07:00:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 98698A44AE1;
 Wed,  2 Oct 2019 11:00:13 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DCCC5D9D3;
 Wed,  2 Oct 2019 11:00:05 +0000 (UTC)
Subject: Re: [PATCH 04/67] iotests.py: create_test_image, remove_test_image
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20191001194715.2796-1-mreitz@redhat.com>
 <20191001194715.2796-5-mreitz@redhat.com>
 <a65b0919-66ee-d1e6-2ba1-94e7ec8fb184@redhat.com>
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
Message-ID: <8604aec2-2a09-7bcc-792a-9e11e8b6fb11@redhat.com>
Date: Wed, 2 Oct 2019 13:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <a65b0919-66ee-d1e6-2ba1-94e7ec8fb184@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lamtfzGpM4woyTT17oERy5PyAc8KGEZx2"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 02 Oct 2019 11:00:13 +0000 (UTC)
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
--lamtfzGpM4woyTT17oERy5PyAc8KGEZx2
Content-Type: multipart/mixed; boundary="o6F1XBXkLpY1YUBbGELWVToGTZGbpnHlX"

--o6F1XBXkLpY1YUBbGELWVToGTZGbpnHlX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.10.19 01:20, John Snow wrote:
>=20
>=20
> On 10/1/19 3:46 PM, Max Reitz wrote:
>> Python tests should use these two new functions instead of
>> qemu_img('create', ...) + os.remove(), so that user-supplied image
>> options are interpreted and handled correctly.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/iotests.py | 56 ++++++++++++++++++++++++++++++++++=
+
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotest=
s.py
>> index b5ea424de4..fce1ab04c9 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -122,6 +122,62 @@ def qemu_img_create(*args):
>> =20
>>      return qemu_img(*args)
>> =20
>> +def create_test_image(filename, size=3DNone, fmt=3Dimgfmt, opts=3D[],=

>> +                      backing_file=3DNone, backing_fmt=3DNone,
>> +                      objects=3D[], unsafe=3DFalse):
>=20
> Python! It's the language that everybody loves and can do no wrong!
>=20
> Ah, wait, no, maybe the opposite.
>=20
> You want this:
>=20
> (..., opts=3DNone, ...):
>     opts =3D opts or []
>=20
> because, unfortunately, default parameters are bound at definition time=

> and not at call time, so the default list here is like a static local.

OK.  Interesting.

I suppose the same goes for @objects, then.

>> +    if fmt =3D=3D imgfmt:
>> +        # Only use imgopts for the default format
>> +        opts =3D imgopts + opts
>> +
>> +    for i, opt in enumerate(opts):
>> +        if '$TEST_IMG' in opt:
>> +            opts[i] =3D opt.replace('$TEST_IMG', filename)
>> +
>> +    # default luks support
>> +    if fmt =3D=3D 'luks':
>> +        if not any('key-secret' in opt for opt in opts):
>=20
> You can write "if not 'key-secret' in opts"

Oh, that=E2=80=99s recursive?

>> +            opts.append(luks_default_key_secret_opt)
>=20
> And here we might modify that default list.
>=20
>> +        objects.append(luks_default_secret_object)
>> +
>> +    args =3D ['create', '-f', fmt]
>> +
>> +    if len(opts) > 0:
>> +        args +=3D ['-o', ','.join(opts)]
>> +
>> +    if backing_file is not None:
>> +        args +=3D ['-b', backing_file]
>> +
>> +    if backing_fmt is not None:
>> +        args +=3D ['-F', backing_fmt]
>> +
>> +    if len(objects) > 0:
>> +        # Generate a [['--object', $obj], [...], ...] list and flatte=
n it
>> +        args +=3D [arg for objarg in (['--object', obj] for obj in ob=
jects) \
>> +                     for arg in objarg]
>=20
> I may have mentioned at one point that I love comprehensions, but
> dislike nested comprehensions.

I can=E2=80=99t remember but I do remember writing this piece of code, be=
ing sad
that there is no .flatten, and wanting everyone to see the monster that
arises.

> At this point, I think it's far simpler
> to say:
>=20
> for obj in objects:
>     args.extend(['--object', obj])
>=20
> or, even shorter:
>     args +=3D ['--object', obj]

OK, so now you saw it, I=E2=80=99m glad to make the flattening more flatt=
ering
to read.

>> +
>> +    if unsafe:
>> +        args.append('-u')
>> +
>> +    args.append(filename)
>> +    if size is not None:
>> +        args.append(str(size))
>> +
>> +    return qemu_img(*args)
>> +
>> +# Use this to remove images create with create_test_image in the
>=20
> created
>=20
> and you might as well move the # comment to a """docstring""" while
> you're here.
>=20
>> +# default image format (iotests.imgfmt)
>> +def remove_test_image(filename):
>> +    try:
>> +        os.remove(filename)
>> +
>> +        data_file =3D next(opt.replace('data_file=3D', '') \
>> +                            .replace('$TEST_IMG', filename) \
>> +                         for opt in imgopts if opt.startswith('data_f=
ile=3D'))
>> +
>=20
> Learned something today: you can use next() to get the first value from=

> a generator expression.

I was sad for a bit that Python doesn=E2=80=99t have a find(), but then I=

noticed this works as well.  (Already used extensively in =E2=80=9Ciotest=
s: Add
VM.assert_block_path()=E2=80=9D from my =E2=80=9Cblock: Fix check_to_repl=
ace_node()=E2=80=9D
series.)

>> +        os.remove(data_file)
>=20
> Keep in mind that if the generator expression returns no results, that
> next() will throw an exception and we won't make it here. That's ok, bu=
t,

I did.  If there are no results, it=E2=80=99s good we won=E2=80=99t get h=
ere.

This code would be wrong if the next() didn=E2=80=99t throw an exception.=


>> +    except:
>> +        pass
>> +
>=20
> The unqualified except doesn't help me know which errors you expected
> and which you didn't.

What I=E2=80=99m expecting: FileNotFound, StopIteration.

But the thing is that I feel like maybe removing a file should always
pass, regardless of the exact exception.  (I can imagine to be wrong.)

> We have a function like this elsewhere in the python directory:
>=20
> def remove_if_exists(filename):
>     try:
>         os.remove(filename)
>     except FileNotFoundError:
>         pass

We do?  I can=E2=80=99t find it.  I find a _remove_if_exists in machine.p=
y,
which I=E2=80=99m not sure whether it=E2=80=99s supposed to be used outsi=
de, and it
works a bit different, actually (but probably to the same effect).

> Can we use that here and remove the try:/except: from this function? It=

> will require you to change the list search to something like this inste=
ad:
>=20
> remove_if_exists(filename)
> for opt in (x for x in imgopts if etc):
>     data_file =3D opt.replace('etc', 'etc')
>     remove_if_exists(data_file)
>=20
> to avoid the exception when you call next().

I don=E2=80=99t know why I=E2=80=99d avoid the exception, though.

This is probably because I don=E2=80=99t like pythonic code, again, but I=
 prefer
a next() + exception over a for loop that just iterates once or not at al=
l.

>>  def qemu_img_verbose(*args):
>>      '''Run qemu-img without suppressing its output and return the exi=
t code'''
>>      exitcode =3D subprocess.call(qemu_img_args + list(args))
>>
>=20
> My fussiness with the remove() function is just optional picky stuff,
> but the rest matters, I think.

OK.  Indeed it does!

Max


--o6F1XBXkLpY1YUBbGELWVToGTZGbpnHlX--

--lamtfzGpM4woyTT17oERy5PyAc8KGEZx2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2UgzMACgkQ9AfbAGHV
z0A7vgf9GvwGGCxdO+Dq1ukpK9oxH2kL9YqTFhdh+ZQk6/I64zitLAP2IvMSTonD
VqZRKVAydGV7Id+rhV50quIKxWHUKvbGWcjg3pYxEqLGioHQKpwD0mdc58nxLYf7
O4T6DATJC/LqdQZWwbklw/bqkFzTMRNaFTPmbJvsLe6UF+cjk45Bx+UJZW/NoSXw
4+XxW4xp0m8mprYNVXcDxQYWQVi8hnVKTV7uOgIe0rPLX9+PfmgWSUIcDJ3QAWdI
EcChc//XmgSzk4vxbKH/DFtrJzrIMHqE1VH2X9HSFOMm+tdwoH+MG1l5HGZw3e+R
aD/bArc/mHfO/Orxi+DFuA3jN+Gq1w==
=r1Zb
-----END PGP SIGNATURE-----

--lamtfzGpM4woyTT17oERy5PyAc8KGEZx2--

