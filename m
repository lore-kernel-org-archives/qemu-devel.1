Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BFE20706
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDHSTryI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BFE20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jluN6-0005OE-Uz
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jluMX-0004yY-4g
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:13:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jluMU-0003tK-Dc
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592486025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JioRVU2LZ1L7pHDf35NIkQkvSlkOKi3sYhUYWAxi/No=;
 b=dDHSTryIyH5h3Ix1JPHrtgVghMAlOH2qiJRHRSywmyGJsk0BSvT0KJWp9fJr+3AndUJNBG
 kmv4pjt1DhBCrf7dzLOMfucA089TdceAlcpbsxOH/21r0Ga9avl0S5vS6bIAlUq8vIabsJ
 kD442BwSgkK9NlrQlUJivxUpMqNyP58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-C3bv3yUiPtWgOcFid_pWxw-1; Thu, 18 Jun 2020 09:13:40 -0400
X-MC-Unique: C3bv3yUiPtWgOcFid_pWxw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9068D8035C6;
 Thu, 18 Jun 2020 13:13:39 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-185.ams2.redhat.com
 [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 244DF5BAC0;
 Thu, 18 Jun 2020 13:13:37 +0000 (UTC)
Subject: Re: [PULL 14/15] qcow2_format.py: dump bitmaps header extension
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200609205245.3548257-1-eblake@redhat.com>
 <20200609205245.3548257-15-eblake@redhat.com>
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
Message-ID: <81ba0181-3dfc-1c1e-7c19-278569e65c60@redhat.com>
Date: Thu, 18 Jun 2020 15:13:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609205245.3548257-15-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zyNhhQNT9YmW5x2kbpHKK19iNtCSFXAOy"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 01:21:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zyNhhQNT9YmW5x2kbpHKK19iNtCSFXAOy
Content-Type: multipart/mixed; boundary="CMqivegjsNyqOjJuQrooZNMj4BOjiKTJ4"

--CMqivegjsNyqOjJuQrooZNMj4BOjiKTJ4
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.06.20 22:52, Eric Blake wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Add class for bitmap extension and dump its fields. Further work is to
> dump bitmap directory.
>=20
> Test new functionality inside 291 iotest.

Unfortunately, it also breaks 291 with an external data file, which
worked before.  (The problems being that an external data file gives you
an additional header extension, and that the bitmap directory offset
changes.)

I think if we want to test testing tools, we have to do that in a
controlled environment where we exactly know what the image is.  It
looks to me now as if 291 is not such an environment.  Or phrased
differently, we probably shouldn=E2=80=99t test some testing tool in normal
tests that test qemu itself.

If we only test qcow2.py in normal tests, then I don=E2=80=99t think we hav=
e to
explicitly test it at all.  (Because if you test qcow2.py in a normal
test, and the test breaks, it=E2=80=99s unclear what=E2=80=99s broken.  So =
I think you
might as well forego the qcow2.py test altogether, because if it breaks,
that=E2=80=99ll probably show up in some other test case that uses it.)

In this case here, I can see three things we could do:

First, could just filter out the data file header extension and the
bitmap_directory_offset.  But I=E2=80=99m not sure whether that=E2=80=99s t=
he best thing
to do, because it might break with some other obscure IMGOPTS that I
personally never use for the iotests.

I think that if we want a real qcow2.py test somewhere, it should be its
own test.  No custom IMGOPTS allowed.  So the second idea would be to
move it there, and drop the qcow2.py usage from here.

Or, third, maybe we actually don=E2=80=99t care that much about a real qcow=
2.py
test, and really want to just *use* (as opposed to =E2=80=9Ctest=E2=80=9D) =
qcow2.py
here.  Then we should filter what we really need from its output instead
of dropping what we don=E2=80=99t need.


(We could also disable 291 for external data files, but I don=E2=80=99t rea=
lly
see why, if the only justification for this addition to it is to test
qcow2.py =E2=80=93 which 291 isn=E2=80=99t for.)

Max

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> Message-Id: <20200606081806.23897-14-vsementsov@virtuozzo.com>
> [eblake: fix iotest output]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/291             |  4 +++
>  tests/qemu-iotests/291.out         | 33 +++++++++++++++++++++++
>  tests/qemu-iotests/qcow2_format.py | 42 +++++++++++++++++++++++-------
>  3 files changed, 70 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
> index 3ca83b9cd1f7..e0cffc7cb119 100755
> --- a/tests/qemu-iotests/291
> +++ b/tests/qemu-iotests/291
> @@ -62,6 +62,8 @@ $QEMU_IO -c 'w 1M 1M' -f $IMGFMT "$TEST_IMG" | _filter_=
qemu_io
>  $QEMU_IMG bitmap --disable -f $IMGFMT "$TEST_IMG" b1
>  $QEMU_IMG bitmap --enable -f $IMGFMT "$TEST_IMG" b2
>  $QEMU_IO -c 'w 2M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
> +echo "Check resulting qcow2 header extensions:"
> +$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
>=20
>  echo
>  echo "=3D=3D=3D Bitmap preservation not possible to non-qcow2 =3D=3D=3D"
> @@ -88,6 +90,8 @@ $QEMU_IMG bitmap --merge tmp -f $IMGFMT "$TEST_IMG" b0
>  $QEMU_IMG bitmap --remove --image-opts \
>      driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D"$TEST_IMG" tmp
>  $QEMU_IMG info "$TEST_IMG" | _filter_img_info --format-specific
> +echo "Check resulting qcow2 header extensions:"
> +$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
>=20
>  echo
>  echo "=3D=3D=3D Check bitmap contents =3D=3D=3D"
> diff --git a/tests/qemu-iotests/291.out b/tests/qemu-iotests/291.out
> index 8c62017567e9..ccfcdc5e35ce 100644
> --- a/tests/qemu-iotests/291.out
> +++ b/tests/qemu-iotests/291.out
> @@ -14,6 +14,25 @@ wrote 1048576/1048576 bytes at offset 1048576
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote 1048576/1048576 bytes at offset 2097152
>  1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +Check resulting qcow2 header extensions:
> +Header extension:
> +magic                     0xe2792aca (Backing format)
> +length                    5
> +data                      'qcow2'
> +
> +Header extension:
> +magic                     0x6803f857 (Feature table)
> +length                    336
> +data                      <binary>
> +
> +Header extension:
> +magic                     0x23852875 (Bitmaps)
> +length                    24
> +nb_bitmaps                2
> +reserved32                0
> +bitmap_directory_size     0x40
> +bitmap_directory_offset   0x510000
> +
>=20
>  =3D=3D=3D Bitmap preservation not possible to non-qcow2 =3D=3D=3D
>=20
> @@ -65,6 +84,20 @@ Format specific information:
>              granularity: 65536
>      refcount bits: 16
>      corrupt: false
> +Check resulting qcow2 header extensions:
> +Header extension:
> +magic                     0x6803f857 (Feature table)
> +length                    336
> +data                      <binary>
> +
> +Header extension:
> +magic                     0x23852875 (Bitmaps)
> +length                    24
> +nb_bitmaps                3
> +reserved32                0
> +bitmap_directory_size     0x60
> +bitmap_directory_offset   0x520000
> +
>=20
>  =3D=3D=3D Check bitmap contents =3D=3D=3D
>=20


--CMqivegjsNyqOjJuQrooZNMj4BOjiKTJ4--

--zyNhhQNT9YmW5x2kbpHKK19iNtCSFXAOy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl7raIAACgkQ9AfbAGHV
z0CBcwgApWs7EaE4WYIVNgNC12NQb8rT13hAacSi4zBC0Ox3+/iGW8OyKEAHv6pX
rJTfag+qpDKC/D2dhK6B1OyF/f7zQUDSwvCLrIcoNKQHIbcknQMQ0w4pJE7UIx0C
2GhjDSLpi4eYh1F5ZCizwstiz090Lms2l7RhlDbeun7yHNsjK2mOi9lgtw0Zq2MC
mllDDwxRelPrBdelcNGYWzUMuvaJmV6mH8g18Flvwsk0KAhJ2EiElmB65NZS4vQU
CYGO747jS50OW7dxoPEyvFfySa/8lJaaW4aKc1rN9OQo+SHGnaFbx/nzHNX+GfB2
5rh0tBW6xr75S94JsmUGRCwYWCvKZw==
=wrqf
-----END PGP SIGNATURE-----

--zyNhhQNT9YmW5x2kbpHKK19iNtCSFXAOy--


