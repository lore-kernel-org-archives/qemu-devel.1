Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EABEC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:35:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE2020855
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE2020855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZ72-0003Gr-1c
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:35:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDZ5S-0002UD-RX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDZ5R-0002az-Gq
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:33:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hDZ5M-0002PM-Iu; Mon, 08 Apr 2019 14:33:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59C2D821F3;
	Mon,  8 Apr 2019 18:33:26 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-100.brq.redhat.com
	[10.40.204.100])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B23119C5B;
	Mon,  8 Apr 2019 18:33:24 +0000 (UTC)
To: "Richard W.M. Jones" <rjones@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
	<20190408172202.GH3926@redhat.com>
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
Message-ID: <d40c9fd6-6ae2-95f3-2f63-151ee1f13d0f@redhat.com>
Date: Mon, 8 Apr 2019 20:33:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408172202.GH3926@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="adjrWjB2gRXjuQItw1jypAmoqGzeJzUYB"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 08 Apr 2019 18:33:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] Whither qemu's ssh driver? (was: Re: [PATCH 02/15]
 block/ssh: Do not report read/write/flush errors to the user)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	ptoscano@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408183322._pmw_5Mns2Izwv3ESxCS6pL4d3POz9LLzzQbmlHNDMc@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--adjrWjB2gRXjuQItw1jypAmoqGzeJzUYB
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, ptoscano@redhat.com, berrange@redhat.com
Message-ID: <d40c9fd6-6ae2-95f3-2f63-151ee1f13d0f@redhat.com>
Subject: Re: Whither qemu's ssh driver? (was: Re: [PATCH 02/15] block/ssh: Do
 not report read/write/flush errors to the user)
References: <20190408083627.7479-1-armbru@redhat.com>
 <20190408083627.7479-3-armbru@redhat.com> <20190408172202.GH3926@redhat.com>
In-Reply-To: <20190408172202.GH3926@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.04.19 19:22, Richard W.M. Jones wrote:
> I don't know much about this patch which looks like internal qemu
> rearrangements so I guess fine.  However I do have a few things to say
> about the ssh driver ...
>=20
> As you know I wrote this a few years ago, and it uses libssh2.
> libssh2 has not evolved as quickly as we'd like and it may be better
> to use libssh instead -- despite the names, these are two separate and
> unrelated libraries.  libssh supports a wider range of SSH encryption
> and has more features.  It's generally more likely to work against a
> random SSH server.  It has also been through the FIPS process.  Indeed
> Red Hat made the decision to switch exclusively to libssh in RHEL 8,
> if that carries any weight.
>=20
> Pino posted a libssh2 -> libssh conversion patch a while back, but it
> has been somewhat stuck in review.  If I recall the latest concern was
> whether it performs as well as the libssh2 version.
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07267.html
>=20
> In the meantime I added libssh support to nbdkit.  nbdkit can be used
> as a complete replacement for qemu's ssh driver.
>=20
>   nbdkit ssh host=3Dfoo.example.com disk.img -U tmpdirXXXXXX/sock
>   qemu -hda nbd:unix:tmpdirXXXXXX/sock
>=20
> In fact it's somewhat superior (IMHO) because all of the tricky code
> handling libssh runs outside qemu in a separate process, improving
> isolation and potentially allowing separate, restrictive security
> policies to be applied.  For example it would no longer be necessary
> to give qemu permission to connect to remote SSH servers.
>=20
> Could we make this really smooth somehow?  nbdkit has a concept
> [https://www.mankier.com/1/nbdkit-captive] where we make it easy to
> manage external commands owned by nbdkit.  Is there an equivalent
> feature of qemu where:
>=20
>   qemu -object exec,id=3Dnbd1,cmd=3D'nbdkit -f -U $sock ssh ...' \
>        -drive file.driver=3Dnbd,file.socket=3Dnbd1
>=20
> would run the command but also allocate a socket and kill the
> subcommand on exit (of qemu)?
>=20
> Basically I'm trying to think about how to make this a reality:
>=20
>   https://rwmj.files.wordpress.com/2018/10/drawing2-svg.png
>=20
> Rich.

I don=E2=80=99t disagree with anything you say.  I would prefer to move t=
he less
well maintained drivers (for which there is no strict performance
requirement) into a separate process.  nbdkit is perfectly suited for
that, and the drivers are there, as you say (ssh, curl, vvfat).

Having a nicer interface in qemu would make the transition simple,
because we could tell users exactly how to change their command line so
their use case continues to work.  I=E2=80=99m not sure whether it really=
 works,
though, because I don=E2=80=99t think there is such a simple replacement =
for
being able to simply pass "ssh://host/path" to qemu and have it work.

But I think it=E2=80=99s still worth it.

Max


--adjrWjB2gRXjuQItw1jypAmoqGzeJzUYB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyrk/IACgkQ9AfbAGHV
z0AFRAf7BoU58cNYAaKkUiTPDMvaMPUpWqWn3TYyJA7cyaOoiARh/nvhrx4iXJSg
yoesVHmnWnAsjcK6lseLyoGQxeuqrZX8hWIrcmy2tTLJNX4OS7ffmQqrkJ347DK8
GQAJpEwWdBxtCfv956JS2jM6f3yiKh5vQpX9auteJA2WZ4eVRROtcHEIZ+283r+O
gZWbMkUvMOIXk7+BfSganz3SeEZRdER+tf/usR6i4mtgD7ZbqOvVdeUXZO5qDqqo
yicDkq2DtYt/k1wxbl4X3W/ISGNXr7voDmohta5M2wfD37PpWtrqDzIeLLBE/zuL
L8hyQH7sRhAezikt8yFG68eXD9yXGA==
=SNfH
-----END PGP SIGNATURE-----

--adjrWjB2gRXjuQItw1jypAmoqGzeJzUYB--

