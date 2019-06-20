Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04974C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:40:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD67B2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:40:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD67B2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he3rT-0005GQ-3o
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 16:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1he3Us-00012s-AY
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1he3Uo-0006ZR-8A
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:17:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1he3UQ-0006Gp-23; Thu, 20 Jun 2019 16:16:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 11DF130833BE;
 Thu, 20 Jun 2019 20:16:57 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D4545D72E;
 Thu, 20 Jun 2019 20:16:52 +0000 (UTC)
To: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20190620200840.17655-1-ptoscano@redhat.com>
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
Message-ID: <ca37a329-6e88-6714-57d6-4b3008d83fa6@redhat.com>
Date: Thu, 20 Jun 2019 22:16:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620200840.17655-1-ptoscano@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="p90Yv8wILoliBtVN378MKKHUanlbiUgWt"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 20 Jun 2019 20:16:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v11] ssh: switch from libssh2 to libssh
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
Cc: kwolf@redhat.com, fam@euphon.net, philmd@redhat.com, rjones@redhat.com,
 sw@weilnetz.de, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p90Yv8wILoliBtVN378MKKHUanlbiUgWt
Content-Type: multipart/mixed; boundary="haVWYhB2sksvrG7y1p58siHFERgHMX1BX";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: rjones@redhat.com, kwolf@redhat.com, philmd@redhat.com,
 alex.bennee@linaro.org, fam@euphon.net, sw@weilnetz.de
Message-ID: <ca37a329-6e88-6714-57d6-4b3008d83fa6@redhat.com>
Subject: Re: [PATCH v11] ssh: switch from libssh2 to libssh
References: <20190620200840.17655-1-ptoscano@redhat.com>
In-Reply-To: <20190620200840.17655-1-ptoscano@redhat.com>

--haVWYhB2sksvrG7y1p58siHFERgHMX1BX
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 22:08, Pino Toscano wrote:
> Rewrite the implementation of the ssh block driver to use libssh instea=
d
> of libssh2.  The libssh library has various advantages over libssh2:
> - easier API for authentication (for example for using ssh-agent)
> - easier API for known_hosts handling
> - supports newer types of keys in known_hosts
>=20
> Use APIs/features available in libssh 0.8 conditionally, to support
> older versions (which are not recommended though).
>=20
> Adjust the iotest 207 according to the different error message, and to
> find the default key type for localhost (to properly compare the
> fingerprint with).
> Contributed-by: Max Reitz <mreitz@redhat.com>
>=20
> Adjust the various Docker/Travis scripts to use libssh when available
> instead of libssh2. The mingw/mxe testing is dropped for now, as there
> are no packages for it.
>=20
> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>=20
> Changes from v10:
> - improve error message for key mismatch
> - integrate Max Reitz' fix to iotest 207 to detect the key type used by=

>   localhost
>=20
> Changes from v9:
> - restored "default" case in the server status switch for libssh < 0.8.=
0
> - print the host key type & fingerprint on mismatch with known_hosts
> - improve/fix message for failed socket_set_nodelay()
> - reset s->sock properly
>=20
> Changes from v8:
> - use a newer key type in iotest 207
> - improve the commit message
>=20
> Changes from v7:
> - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
> - ptrdiff_t -> size_t
>=20
> Changes from v6:
> - fixed few checkpatch style issues
> - detect libssh 0.8 via symbol detection
> - adjust travis/docker test material
> - remove dead "default" case in a switch
> - use variables for storing MIN() results
> - adapt a documentation bit
>=20
> Changes from v5:
> - adapt to newer tracing APIs
> - disable ssh compression (mimic what libssh2 does by default)
> - use build time checks for libssh 0.8, and use newer APIs directly
>=20
> Changes from v4:
> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
> - fix few return code checks
> - remove now-unused parameters in few internal functions
> - allow authentication with "none" method
> - switch to unsigned int for the port number
> - enable TCP_NODELAY on the socket
> - fix one reference error message in iotest 207
>=20
> Changes from v3:
> - fix socket cleanup in connect_to_ssh()
> - add comments about the socket cleanup
> - improve the error reporting (closer to what was with libssh2)
> - improve EOF detection on sftp_read()
>=20
> Changes from v2:
> - used again an own fd
> - fixed co_yield() implementation
>=20
> Changes from v1:
> - fixed jumbo packets writing
> - fixed missing 'err' assignment
> - fixed commit message
>=20
>  .travis.yml                                   |   4 +-
>  block/Makefile.objs                           |   6 +-
>  block/ssh.c                                   | 669 ++++++++++--------=

>  block/trace-events                            |  14 +-
>  configure                                     |  65 +-
>  docs/qemu-block-drivers.texi                  |   2 +-
>  .../dockerfiles/debian-win32-cross.docker     |   1 -
>  .../dockerfiles/debian-win64-cross.docker     |   1 -
>  tests/docker/dockerfiles/fedora.docker        |   4 +-
>  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
>  tests/qemu-iotests/207                        |  54 +-
>  tests/qemu-iotests/207.out                    |   2 +-
>  13 files changed, 468 insertions(+), 358 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--haVWYhB2sksvrG7y1p58siHFERgHMX1BX--

--p90Yv8wILoliBtVN378MKKHUanlbiUgWt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0L6bMACgkQ9AfbAGHV
z0ArRQf/a2/gPQ1worZxuwzkzXKIzaym58SIpjEMjEhilPoETyqeb5rP51n+u6Id
4tp/bnP8puw5UMp6GyABYjrcsHbsVOofdjMqIHjtXvyGrXyfd0pd9r0CGxCkdFEy
kv/tWsqecPVsOlCo0BNxar7GRriMTu35yyzXItMDFiGrK0k7yv7KM+KYcsCKP6qm
o9Zmo2DQL1G1XZ+ci3qnjWqMhwxf3DERcDJjaMDkMU0udiDev+iKbN7ZnOzBapnu
pvsqYvphrFXX7jSsRq1OzNp9OC7Tz6bnXgFtiRzFdYKboeFG/fZhBv5QP6vgOUEg
soW3JUegpzP7ePAOUIWexmfCmSzVnw==
=nkFW
-----END PGP SIGNATURE-----

--p90Yv8wILoliBtVN378MKKHUanlbiUgWt--

