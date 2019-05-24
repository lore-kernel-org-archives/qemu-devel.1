Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A779C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55A7D20862
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A7D20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBqx-0007jO-H8
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:11:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hUBoz-0006RH-Oh
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hUBoh-0000ge-Kx
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:09:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hUBnN-00089f-VG; Fri, 24 May 2019 11:07:49 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DC063088A63;
	Fri, 24 May 2019 15:07:31 +0000 (UTC)
Received: from [10.3.116.169] (ovpn-116-169.phx2.redhat.com [10.3.116.169])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 738C11001E77;
	Fri, 24 May 2019 15:07:28 +0000 (UTC)
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20190508211820.17851-1-mreitz@redhat.com>
	<20190508211820.17851-2-mreitz@redhat.com>
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
Message-ID: <1ed0b731-cbbd-0cdd-32f6-913d2b57edfa@redhat.com>
Date: Fri, 24 May 2019 10:07:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508211820.17851-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ilx6g9IlvnOjb9pFZDXHUYmqhiYVHep6w"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 24 May 2019 15:07:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 1/5] qemu-nbd: Add --pid-file option
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
Cc: Kevin Wolf <kwolf@redhat.com>,
	=?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ilx6g9IlvnOjb9pFZDXHUYmqhiYVHep6w
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1ed0b731-cbbd-0cdd-32f6-913d2b57edfa@redhat.com>
Subject: Re: [PATCH v3 1/5] qemu-nbd: Add --pid-file option
References: <20190508211820.17851-1-mreitz@redhat.com>
 <20190508211820.17851-2-mreitz@redhat.com>
In-Reply-To: <20190508211820.17851-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/8/19 4:18 PM, Max Reitz wrote:
> --fork is a bit boring if there is no way to get the child's PID.  This=

> option helps.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-nbd.c    | 11 +++++++++++
>  qemu-nbd.texi |  2 ++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index dca9e72cee..edb5195208 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -59,6 +59,7 @@
>  #define QEMU_NBD_OPT_IMAGE_OPTS    262
>  #define QEMU_NBD_OPT_FORK          263
>  #define QEMU_NBD_OPT_TLSAUTHZ      264
> +#define QEMU_NBD_OPT_PID_FILE      265
> =20
>  #define MBR_SIZE 512
> =20
> @@ -111,6 +112,7 @@ static void usage(const char *name)
>  "                            specify tracing options\n"
>  "  --fork                    fork off the server process and exit the =
parent\n"
>  "                            once the server is running\n"
> +"  --pid-file=3DPATH           store the server's process ID in the gi=
ven file\n"

Are we guaranteed that the pid file does not appear until after the
socket has been created?

/me rereads full file...

> @@ -876,6 +880,9 @@ int main(int argc, char **argv)
>          case 'L':
>              list =3D true;
>              break;
> +        case QEMU_NBD_OPT_PID_FILE:
> +            pid_file_name =3D optarg;
> +            break;
>          }
>      }
> =20
=2E..
    socket_activation =3D check_socket_activation();
    if (socket_activation =3D=3D 0) {
        setup_address_and_port(&bindto, &port);
    } else {
        /* Using socket activation - check user didn't use -p etc. */
=2E..

> @@ -1196,6 +1203,10 @@ int main(int argc, char **argv)
> =20
>      nbd_update_server_watch();
> =20
> +    if (pid_file_name) {
> +        qemu_write_pidfile(pid_file_name, &error_fatal);
> +    }

Yes, we are.  So,

> +
>      /* now when the initialization is (almost) complete, chdir("/")
>       * to free any busy filesystems */
>      if (chdir("/") < 0) {
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index de342c76b8..7f55657722 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -117,6 +117,8 @@ option; or provide the credentials needed for conne=
cting as a client
>  in list mode.
>  @item --fork
>  Fork off the server process and exit the parent once the server is run=
ning.
> +@item --pid-file=3DPATH
> +Store the server's process ID in the given file.

since that is a useful trick to know (the pid file intentionally does
NOT appear until after the socket is ready to go), we should mention it
in the documentation.

I can make that tweak while queueing, if you'd like.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--Ilx6g9IlvnOjb9pFZDXHUYmqhiYVHep6w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzoCK8ACgkQp6FrSiUn
Q2rhQwgArK0cG3M1LWcIxJ4n9F00xZY3rZpRetoCxa26Cbn7lgmXqhn64mV/bm0j
CkjAUbytyt8H02xboh6ogOlWpGsEhqgdnItRZ9CFOEoowxBPf1dUS0uN3lxh1GCu
67HyXMk2S46S1xbfsiqZehbnSwvLDRjfywoWvk7cpV539fX/G0ET350JLEqgkf0/
UZGuQFJikqLEr7X5LmPe06P+vg0GC/tRTRAS+1FcYZvyFmop1BKLghtKXOvmSbwr
ZlhbLT1M4WLtuwggLmicxoMPwCxAtIEZFSm3Vi/jDePwUIw4A/GD43O93uaZzIuv
RKkbTqHeEJNbS85IiofMcolxovOVTw==
=2BxJ
-----END PGP SIGNATURE-----

--Ilx6g9IlvnOjb9pFZDXHUYmqhiYVHep6w--

