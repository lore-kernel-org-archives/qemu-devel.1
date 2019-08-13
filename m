Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92FFC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80DFB206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DFB206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXMZ-00052h-Qo
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35650)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxXLz-0004PE-N9
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:00:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxXLu-0002gv-EM
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:00:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45042)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxXLq-0002cY-Nx; Tue, 13 Aug 2019 10:00:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3EEB69097;
 Tue, 13 Aug 2019 14:00:31 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BC2082E38;
 Tue, 13 Aug 2019 14:00:26 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-8-mreitz@redhat.com>
 <42b23025-5270-8b53-1fa0-724883d9a746@redhat.com>
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
Message-ID: <74692040-e5c7-4ec3-8a6c-df565e6bae3f@redhat.com>
Date: Tue, 13 Aug 2019 16:00:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <42b23025-5270-8b53-1fa0-724883d9a746@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZST41xgVlybb7wnN88Y8d6zI7FTa7RD9F"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 13 Aug 2019 14:00:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 7/7] iotests: Disable 126 for
 some vmdk subformats
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
--ZST41xgVlybb7wnN88Y8d6zI7FTa7RD9F
Content-Type: multipart/mixed; boundary="mEMyK5HOkFTYZN70vBtD4NHsnCqw2xEIv";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <74692040-e5c7-4ec3-8a6c-df565e6bae3f@redhat.com>
Subject: Re: [Qemu-block] [PATCH 7/7] iotests: Disable 126 for some vmdk
 subformats
References: <20190725155735.11872-1-mreitz@redhat.com>
 <20190725155735.11872-8-mreitz@redhat.com>
 <42b23025-5270-8b53-1fa0-724883d9a746@redhat.com>
In-Reply-To: <42b23025-5270-8b53-1fa0-724883d9a746@redhat.com>

--mEMyK5HOkFTYZN70vBtD4NHsnCqw2xEIv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.19 23:33, John Snow wrote:
>=20
>=20
> On 7/25/19 11:57 AM, Max Reitz wrote:
>> Several vmdk subformats do not work with iotest 126, so disable them.
>>
>> (twoGbMaxExtentSparse actually should work, but fixing that is a bit
>> difficult.  The problem is that the vmdk descriptor file will contain =
a
>> referenc to "image:base.vmdk", which the block layer cannot open becau=
se
>=20
> reference
>=20
>> it does not know the protocol "image".  This is not trivial to solve,
>> because I suppose real protocols like "http://" should be supported.
>> Making vmdk treat all paths with a potential protocol prefix that the
>> block layer does not recognize as plain files seems a bit weird,
>> though.  Ignoring this problem does not seem too bad.)
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/qemu-iotests/126 | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
>> index 9b0dcf9255..8e55d7c843 100755
>> --- a/tests/qemu-iotests/126
>> +++ b/tests/qemu-iotests/126
>> @@ -33,6 +33,12 @@ status=3D1	# failure is the default!
>> =20
>>  # Needs backing file support
>>  _supported_fmt qcow qcow2 qed vmdk
>> +# (1) Flat vmdk images do not support backing files
>> +# (2) Split vmdk images simply fail this test right now.  Fixing that=

>> +#     is left for another day.
>=20
> Which one? :)

Hmmmm?  Fixing refers to #2.  #1 is not a bug or missing feature, it=E2=80=
=99s
just how it is.  (This test needs backing files, so...)

If you mean =E2=80=9Cwhich are which=E2=80=9C, then the ones with *Flat a=
re flat images
(:-)), and the ones with twoGbMaxExtent* are split.

>> +_unsupported_imgopts "subformat=3DmonolithicFlat" \
>> +                     "subformat=3DtwoGbMaxExtentFlat" \
>> +                     "subformat=3DtwoGbMaxExtentSparse"
>>  # This is the default protocol (and we want to test the difference be=
tween
>>  # colons which separate a protocol prefix from the rest and colons wh=
ich are
>>  # just part of the filename, so we cannot test protocols which requir=
e a prefix)
>>
>=20
> What exactly fails?

Interestingly I only now noticed that the test passes with =E2=80=9Cvmdk:=
 Use
bdrv_dirname() for relative extent paths=E2=80=9D (patch 2) reverted...

>                     Does the VMDK driver see `image:` and think it's a
> special filename it needs to handle and fails to do so?
No.  Whenever the block layer sees a parsee filename[1] with a colon
before a slash, it thinks everything before the colon is a protocol
prefix.  For example:

$ qemu-img info foo:bar
qemu-img: Could not open 'foo:bar': Unknown protocol 'foo'

This test is precisely for this.  How can you specify an image filename
that has a colon in it (without using -blockdev)?  One way is to prepend
it with =E2=80=9C./=E2=80=9D, the other is =E2=80=9Cfile:=E2=80=9D.

Now with split VMDKs, we must write something in the header file to
reference the extents.  What vmdk does for an image like
=E2=80=9Cimage:foo.vmdk=E2=80=9D is it writes =E2=80=9Cimage:foo-s001.vmd=
k=E2=80=9D there.

When it tries to open that extent, what happens depends on whether
=E2=80=9Cvmdk: Use bdrv_dirname() for relative extent paths=E2=80=9D (pat=
ch 2) is applied:

--- Before that patch ---

vmdk takes the descriptor filename, which, thanks to some magic in the
block layer, is always =E2=80=9C./image:foo.vmdk=E2=80=9D, even when you =
gave it as
=E2=80=9Cfile:image:foo.vmdk=E2=80=9D (the =E2=80=9Cfile:=E2=80=9D is str=
ipped because it does nothing,
generally, and the =E2=80=9C./=E2=80=9D is then prepended because of the =
false protocol
prefix =E2=80=9Cimage:=E2=80=9D).

It then invokes path_combine() with that path and the path given in the
descriptor file (=E2=80=9Cimage:foo-s001.vmdk=E2=80=9D).  This yields
=E2=80=9C./image:foo-s001.vmdk=E2=80=9D, which actually works.

--- After that patch ---

OK, what I messed up is that I just took the extent path to be an
absolute path if it has a protocol prefix.  (Because that=E2=80=99s how w=
e
usually do it.)  Turns out that vmdk never did that, and path_combine()
actually completely ignores protocol prefixes in the relative filename.

I suppose I could do the same and just drop the path_has_protocol() from
patch 2.  But that=E2=80=99d be a bit broken, as I wrote in the commit
message...  If the descriptor file refers to an extent on
=E2=80=9Chttp://example.com/extent.vmdk=E2=80=9D, I suppose that should n=
ot be
interpreted as a relative path, but actually work...

But anyway, I guess if it=E2=80=99s a bit broken already, I might just ke=
ep it
that way.


tl;dr: Turns out patch 2 broke this test, because it (accidentally)
tried to fix something that I consider broken.  If I just keep it broken
(I didn=E2=80=99t know it was), this test will continue to work and proba=
bly
nobody will care because, well, it already is broken and nobody cares.

Max


[1] By this I mean whether it is piped through .bdrv_parse_filename().
If you specifying something with -hda or -drive file=3D, it will be.
These are filenames like nbd://localhost:10809 or blkdebug:conf:image.
If you pass a filename through QMP, that is, with -blockdev or
blockdev-add, it will not be parsed.  It will be given to the block
driver as is.  Protocol prefixes and other filename magic are ignored
(you need to explicitly specify the driver anyway).


--mEMyK5HOkFTYZN70vBtD4NHsnCqw2xEIv--

--ZST41xgVlybb7wnN88Y8d6zI7FTa7RD9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1SwngACgkQ9AfbAGHV
z0DA7Qf/cO99i/dz4/uR/iffZAdegILKDuFV+jSNocoOetpnKJztziPdXKe3eGcj
hZZJEJwG2wVxm0myRU+lqMYjT5m8j9ECi21PX7g8dItO/wDv1zz8wSmbbwSnlwRS
SBobP+26n53I8mkzuCn+IIq3XmSu+sczZJOjwqQrqChyYZRTWmrC57DQWb7/SANx
NPSroEdm70oadwTEZ5QwgNQsZ74FewrWBbvEefgZSQ0tY5vwMyesg22ApDyxzVN9
25d0mUfVX2c2UHFhazGYMzR+jIROjAKSBmQzBC7XEXRgmrcoObujJEPryzMeXRWw
wYvNACc0KuGfSDi2ceedCQHcpKhirA==
=wL7B
-----END PGP SIGNATURE-----

--ZST41xgVlybb7wnN88Y8d6zI7FTa7RD9F--

