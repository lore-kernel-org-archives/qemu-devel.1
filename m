Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90EBC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8285820675
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 19:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8285820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51937 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO5pQ-0000Co-2t
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 15:32:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO5nj-0007NU-M4
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hO5ni-0004YZ-IE
	for qemu-devel@nongnu.org; Tue, 07 May 2019 15:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hO5ne-0004Ri-UG; Tue, 07 May 2019 15:30:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F2323082132;
	Tue,  7 May 2019 19:30:50 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 553E9600D4;
	Tue,  7 May 2019 19:30:49 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190507183610.9848-1-mreitz@redhat.com>
	<20190507183610.9848-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
Date: Tue, 7 May 2019 14:30:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507183610.9848-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yNCNUvkxu4ZbUOYKhYTeLqEpfnBS5KmS1"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 07 May 2019 19:30:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 1/5] qemu-nbd: Add --pid-file option
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yNCNUvkxu4ZbUOYKhYTeLqEpfnBS5KmS1
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
Message-ID: <81dd6702-1d51-ca2e-1445-e8cdcfb14711@redhat.com>
Subject: Re: [PATCH 1/5] qemu-nbd: Add --pid-file option
References: <20190507183610.9848-1-mreitz@redhat.com>
 <20190507183610.9848-2-mreitz@redhat.com>
In-Reply-To: <20190507183610.9848-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/7/19 1:36 PM, Max Reitz wrote:
> --fork is a bit boring if there is no way to get the child's PID.  This=

> option helps.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-nbd.c    | 29 +++++++++++++++++++++++++++++
>  qemu-nbd.texi |  2 ++
>  2 files changed, 31 insertions(+)
>=20

> @@ -111,6 +112,7 @@ static void usage(const char *name)
>  "                            specify tracing options\n"
>  "  --fork                    fork off the server process and exit the =
parent\n"
>  "                            once the server is running\n"
> +"  --pid-file=3DPATH           store the server's process ID in the gi=
ven file\n"

Should --pid-file imply --fork, or be an error if --fork was not
supplied? As coded, it writes a pid file regardless of --fork, even
though it is less obvious that it is useful in that case. I don't have a
strong preference (there doesn't seem to be a useful consensus on what
forking daemons should do), but it would at least be worth documenting
the intended action (even if that implies a tweak to the patch to match
the intent).

>  #if HAVE_NBD_DEVICE
>  "\n"
>  "Kernel NBD client support:\n"
> @@ -651,6 +653,7 @@ int main(int argc, char **argv)
>          { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
>          { "trace", required_argument, NULL, 'T' },
>          { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
> +        { "pid-file", required_argument, NULL, QEMU_NBD_OPT_PID_FILE }=
,
>          { NULL, 0, NULL, 0 }
>      };
>      int ch;
> @@ -677,6 +680,8 @@ int main(int argc, char **argv)
>      bool list =3D false;
>      int old_stderr =3D -1;
>      unsigned socket_activation;
> +    const char *pid_path =3D NULL;

Bikeshedding: pid_name is nicer (path makes me think of $PATH and other
colon-separated lists, which this is not).

Otherwise, I agree that this is long overdue. Thanks! If you can justify
the behavior without --fork,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--yNCNUvkxu4ZbUOYKhYTeLqEpfnBS5KmS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzR3OgACgkQp6FrSiUn
Q2rwbgf+J+GZR2N9nQzmO3d+82FByTnQtmhXwpraZPBd5rT+cZBeEvm2nVWs3k3X
H48X5wkocz6Rc+1ySRAhtdg005Ak530F8bGR2IccgMw7PiWmubsab3mIGlsWA8JN
nX3u+exgq4CBlzjTqXO4wq89mh0bpVzjdFTEpiUNmPiGt8kh6nRPzA2zRMF4ZFp3
784OK+3i0pRsZ9oXDSr8THd/GV8AjAX/AWP0MrCpyHkZSLW4Q1cipub0Mbys3N0P
dYvvzNBAED8RkwbdcBjVXoX8e3hW5vGiG5N1qP/RY2UE7vdLz28iEDkqtA/sP7IM
ho69ae95qivw8DGeg6Grf/q8e6uuEA==
=9/Aj
-----END PGP SIGNATURE-----

--yNCNUvkxu4ZbUOYKhYTeLqEpfnBS5KmS1--

