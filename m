Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C26AC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02FF121902
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 13:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02FF121902
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54486 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVyol-0006O5-QG
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 09:40:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVyns-00060N-38
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hVynq-0001QD-S4
	for qemu-devel@nongnu.org; Wed, 29 May 2019 09:39:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hVyno-0001Gg-J1; Wed, 29 May 2019 09:39:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C7D2C300740E;
	Wed, 29 May 2019 13:39:30 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.150])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E35678571;
	Wed, 29 May 2019 13:39:28 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190516144319.12570-1-mreitz@redhat.com>
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
Message-ID: <b6992c89-a1bd-ad90-e6a9-c6669b7e91cf@redhat.com>
Date: Wed, 29 May 2019 15:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516144319.12570-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0oU6lqqSTcKz4Omx8i4GxIQkmxzwpnHMb"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 29 May 2019 13:39:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3] iotests: Filter 175's allocation
 information
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
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
	Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0oU6lqqSTcKz4Omx8i4GxIQkmxzwpnHMb
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <b6992c89-a1bd-ad90-e6a9-c6669b7e91cf@redhat.com>
Subject: Re: [PATCH v3] iotests: Filter 175's allocation information
References: <20190516144319.12570-1-mreitz@redhat.com>
In-Reply-To: <20190516144319.12570-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.05.19 16:43, Max Reitz wrote:
> It is possible for an empty file to take up blocks on a filesystem, for=

> example:
>=20
> $ qemu-img create -f raw test.img 1G
> Formatting 'test.img', fmt=3Draw size=3D1073741824
> $ mkfs.ext4 -I 128 -q test.img
> $ mkdir test-mount
> $ sudo mount -o loop test.img test-mount
> $ sudo touch test-mount/test-file
> $ stat -c 'blocks=3D%b' test-mount/test-file
> blocks=3D8
>=20
> These extra blocks (one cluster) are apparently used for metadata,
> because they are always there, on top of blocks used for data:
>=20
> $ sudo dd if=3D/dev/zero of=3Dtest-mount/test-file bs=3D1M count=3D1
> 1+0 records in
> 1+0 records out
> 1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.00135339 s, 775 MB/s
> $ stat -c 'blocks=3D%b' test-mount/test-file
> blocks=3D2056
>=20
> Make iotest 175 take this into account.
>=20
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Nir Soffer <nsoffer@redhat.com>
> ---
> v3:
> - Actually tested this on an FS with the behavior in question and
>   noticed the patterns were lacking a $.  Since I'm now sending a v3
>   anyway, I might as well fix it with the heavy hammer and make it a
>   ($|[^0-9]).
> - Added example configuration to the commit message [Nir]
> - Kept the R-bs because I didn't feel too bad about doing so.
> ---
>  tests/qemu-iotests/175     | 26 ++++++++++++++++++++++----
>  tests/qemu-iotests/175.out |  8 ++++----
>  2 files changed, 26 insertions(+), 8 deletions(-)

Applied to my block branch.

Max


--0oU6lqqSTcKz4Omx8i4GxIQkmxzwpnHMb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzui48ACgkQ9AfbAGHV
z0CvbQf+MpPqbEhW8S1upxdKIm0Ao1pgd2xrEBHlFcL+sCUQFPjAXUO6qmxXKejk
kKOXAWN7khOrbmrU3IF7Ec3NRewTs4+L/k9Ah20n85IuuK4zknbnKLcvCYxwKRuv
FIb0+dmnN+8rUvvUqXo1HdjGKlsMrTuRAPSDDUtfPTGyd/W4ZEtKUvgRXUHxuvQl
tuFHJapR0iHQ1ytk773TdbmvhML2cJjNH0QsvtR7Iup7F8NNQKnN69o3JZdu15pD
Vfvk/t7jZ6nSB4dCb+i+k32USensB+PuUTvDXEC1uTmV/w88eNJjw2iPD1fNb0Yd
QFV5NLv/i2ZjHWe3u2q5hGxkjoRoeg==
=axWW
-----END PGP SIGNATURE-----

--0oU6lqqSTcKz4Omx8i4GxIQkmxzwpnHMb--

