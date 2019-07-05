Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4182C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A77D218BC
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 09:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A77D218BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjKbl-0002Fk-MY
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 05:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41110)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hjKZW-00015Y-DN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hjKZU-0001e0-Nl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 05:32:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hjKZR-0001aL-0y; Fri, 05 Jul 2019 05:31:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B0B7C18B2C3;
 Fri,  5 Jul 2019 09:31:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-154.brq.redhat.com
 [10.40.204.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A8667E660;
 Fri,  5 Jul 2019 09:31:53 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190703224707.12437-1-eblake@redhat.com>
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
Message-ID: <265ccc9f-9df9-3885-ec79-fef36b8d0acc@redhat.com>
Date: Fri, 5 Jul 2019 11:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703224707.12437-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jvkPEaOa0neXOSMHxtRPkKge0TydhWp3Q"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 05 Jul 2019 09:31:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 RFC] qemu-nbd: Permit TLS with Unix
 sockets
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
Cc: Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com, rjones@redhat.com,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jvkPEaOa0neXOSMHxtRPkKge0TydhWp3Q
Content-Type: multipart/mixed; boundary="P0l5W86QwN17nGtihkdRpbhKHxkNy5KPp";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, rjones@redhat.com, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Message-ID: <265ccc9f-9df9-3885-ec79-fef36b8d0acc@redhat.com>
Subject: Re: [PATCH v2 RFC] qemu-nbd: Permit TLS with Unix sockets
References: <20190703224707.12437-1-eblake@redhat.com>
In-Reply-To: <20190703224707.12437-1-eblake@redhat.com>

--P0l5W86QwN17nGtihkdRpbhKHxkNy5KPp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.07.19 00:47, Eric Blake wrote:
> Although you generally won't use encryption with a Unix socket (after
> all, everything is local, so why waste the CPU power), there are
> situations in testsuites where Unix sockets are much nicer than TCP
> sockets.  Since nbdkit allows encryption over both types of sockets,
> it makes sense for qemu-nbd to do likewise.

Hmm.  The code is simple enough, so I don=E2=80=99t see a good reason not=
 to.

> The restriction has been present since its introduction in commits
> 145614a1 and 75822a12 (v2.6), where the former documented the
> limitation but did not provide any additional explanation why it was
> added; but looking closer, it seems the most likely reason is that
> x509 verification requires a hostname. But we can do the same as
> migration did, and add a tls-hostname parameter to supply that
> information.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
>=20
> Since this is now adding a new qemu-nbd command-line option, as well
> as new QMP for blockdev-add, it has missed 4.1 softfreeze and should
> probably be delayed to 4.2.
>=20
> RFC: The test is racy - it sometimes passes, and sometimes fails with:
>=20
>  =3D=3D check TLS with authorization over Unix =3D=3D
>  qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,=
tls-hostname=3Dlocalhost': Failed to read option reply: Cannot read from =
TLS channel: Input/output error
> -qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,=
tls-hostname=3Dlocalhost': Failed to read option reply: Cannot read from =
TLS channel: Input/output error
> +qemu-img: Could not open 'driver=3Dnbd,path=3DSOCKET,tls-creds=3Dtls0,=
tls-hostname=3Dlocalhost': Failed to read option reply: Cannot read from =
TLS channel: Software caused connection abort

Well, the first thing is that over TCP, the reference output shows that
it should indeed fail with ECONNABORTED.  So to me it seems like EIO is
actually the wrong error code.

Um, also, a perhaps stupid question: Why is there no passing test for
client authorization?

> I suspect that there is a bug in the qio TLS channel code when it
> comes to handling a failed TLS handshake, which results in the racy
> output. I'll need help solving that first.  It might also be nice if
> we had a bit more visibility into the gnutls error message when TLS
> handshake fails.

Well, what I can see is that the error code comes from
qcrypto_tls_session_read().  You get ECONNABORTED for
GNUTLS_E_PREMATURE_TERMINATION, and EIO for GNUTLS_E_PULL_ERROR (under
default; but that=E2=80=99s the error that appears if it isn=E2=80=99t
PREMATURE_TERMINATION).

So I suppose you get ECONNABORTED if the first read happens after the
RST is received (or the equivalent on Unix sockets, I have no idea how
they work on the low level); and you get EIO if you try to read before
that (because the TLS connection has just not been established
successfully).

I have experimented a bit, but unfortunately couldn=E2=80=99t find anythi=
ng to
change the test results in any way... :/

> ---
>  qemu-nbd.texi              |  3 ++
>  qapi/block-core.json       |  5 ++
>  block/nbd.c                | 27 +++++++++--
>  qemu-nbd.c                 | 26 ++++++++---
>  tests/qemu-iotests/233     | 94 ++++++++++++++++++++++++++++++++++++--=

>  tests/qemu-iotests/233.out | 61 +++++++++++++++++++++++--
>  tests/qemu-iotests/group   |  2 +-
>  7 files changed, 198 insertions(+), 20 deletions(-)
>=20
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index 7f55657722bd..764518baef84 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -123,6 +123,9 @@ Store the server's process ID in the given file.
>  Specify the ID of a qauthz object previously created with the
>  --object option. This will be used to authorize connecting users
>  against their x509 distinguished name.
> +@item --tls-hostname=3DNAME
> +When using list mode with TLS over a Unix socket, supply the hostname
> +to use during validation of the server's x509 certificate.
>  @item -v, --verbose
>  Display extra debugging information.
>  @item -h, --help

qemu-nbd.c has some parameter documentation, too.  Maybe this option
should be listed there.

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c1a..95da0d44c220 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3856,6 +3856,10 @@
>  #
>  # @tls-creds:   TLS credentials ID
>  #
> +# @tls-hostname: Hostname of the server, required only when using x509=
 based
> +#                TLS credentials when @server lacks a hostname (such a=
s
> +#                using a Unix socket). (Since 4.1)

Well, 4.2 now.

> +#
>  # @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in place=
 of
>  #                  traditional "base:allocation" block status (see
>  #                  NBD_OPT_LIST_META_CONTEXT in the NBD protocol) (sin=
ce 3.0)

[...]

> diff --git a/block/nbd.c b/block/nbd.c
> index 81edabbf35ed..ce3db21190ce 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c

[...]

> @@ -1624,12 +1629,25 @@ static int nbd_open(BlockDriverState *bs, QDict=
 *options, int flags,
>              goto error;
>          }
>=20
> -        /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET=
6 */
> -        if (s->saddr->type !=3D SOCKET_ADDRESS_TYPE_INET) {
> -            error_setg(errp, "TLS only supported over IP sockets");
> +        switch (s->saddr->type) {
> +        case SOCKET_ADDRESS_TYPE_INET:
> +            hostname =3D s->saddr->u.inet.host;
> +            if (qemu_opt_get(opts, "tls-hostname")) {
> +                error_setg(errp, "tls-hostname not required with inet =
socket");

This is more =E2=80=9Cnot allowed=E2=80=9D, right?

(Actually, why not?  We could make the information from @server a
default, but this would override it.  Maybe useful just for testing, but
why not.)

> +                goto error;
> +            }
> +            break;
> +        case SOCKET_ADDRESS_TYPE_UNIX:
> +            hostname =3D qemu_opt_get(opts, "tls-hostname");

Shouldn=E2=80=99t we check that @hostname is non-NULL?  As far as I read =
the
code now, if this option doesn=E2=80=99t exist, =E2=80=9C<null>=E2=80=9D =
will be used as the
hostname somewhere down the stack.  Which probably gives a weird error.

> +            break;
> +        default:
> +            /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_=
INET6 */
> +            error_setg(errp, "TLS only supported over IP or Unix socke=
ts");
>              goto error;
>          }
> -        hostname =3D s->saddr->u.inet.host;
> +    } else if (qemu_opt_get(opts, "tls-hostname")) {
> +        error_setg(errp, "tls-hostname not supported without tls-creds=
");
> +        goto error;
>      }
>=20
>      /* NBD handshake */

[...]

> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index a8cb39e51043..40ea1e299dc7 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c

[...]

> @@ -931,18 +937,22 @@ int main(int argc, char **argv)
>      }
>=20
>      if (tlscredsid) {
> -        if (sockpath) {
> -            error_report("TLS is only supported with IPv4/IPv6");
> -            exit(EXIT_FAILURE);
> -        }
>          if (device) {
>              error_report("TLS is not supported with a host device");
>              exit(EXIT_FAILURE);
>          }
>          if (tlsauthz && list) {
> -            error_report("TLS authorization is incompatible with expor=
t list");
> +            error_report("TLS authorization is incompatible with --lis=
t");
>              exit(EXIT_FAILURE);
>          }
> +        if (tlshost) {
> +            if (!list) {
> +                error_report("TLS hostname is only for use with --list=
");
> +                exit(EXIT_FAILURE);
> +            }
> +        } else {
> +            tlshost =3D bindto;

Again, I wonder whether there should be a nice error message here if
bindto is NULL.

> +        }
>          tlscreds =3D nbd_get_tls_creds(tlscredsid, list, &local_err);
>          if (local_err) {
>              error_report("Failed to get TLS creds %s",

[...]

> diff --git a/tests/qemu-iotests/233.out b/tests/qemu-iotests/233.out
> index 9b46284ab0de..b86bee020649 100644
> --- a/tests/qemu-iotests/233.out
> +++ b/tests/qemu-iotests/233.out

[...]

> +=3D=3D check TLS works over Unix =3D=3D
> +image: nbd+unix://?socket=3DSOCKET
> +file format: nbd
> +virtual size: 64 MiB (67108864 bytes)
> +disk size: unavailable

This has worked surprisingly well considering you did not pass tls-hostna=
me.

On the same note: If I remove the tls-hostname option from the =E2=80=9Cp=
erform
I/O over TLS=E2=80=9D test, it keeps working.

> +image: nbd+unix://?socket=3DSOCKET
> +file format: nbd
> +virtual size: 64 MiB (67108864 bytes)
> +disk size: unavailable
> +qemu-nbd: Certificate does not match the hostname 0.0.0.0

Yeah, that=E2=80=99s a weird error message.  I think it could be better.

Max

> +exports available: 1
> + export: ''
> +  size:  67108864
> +  flags: 0x4ed ( flush fua trim zeroes df cache )
> +  min block: 1
> +  opt block: 4096
> +  max block: 33554432
> +  available meta contexts: 1
> +   base:allocation


--P0l5W86QwN17nGtihkdRpbhKHxkNy5KPp--

--jvkPEaOa0neXOSMHxtRPkKge0TydhWp3Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0fGQcACgkQ9AfbAGHV
z0A2eQgAiUe3GKHUqaLNcfiLZCixhqOdHYjF7+8xYhMZRtrFm8+pWwzuzmjTLejL
K+H8JbcaQlW6zXShQIYmOWra6/mtg/mWPA3ngEcGuhcqeCqbD58RAkJ66Kf5yTD8
+zl8HrRIIK2967olENDGL/Ur1rTfdaHGq/c9wkppjZutLj7LBWtWEO5S/XaKcY10
V3TGR1zLXO9FYB4GDr+eWymoISg7yiHbdXmi0kaM7tFClxEsomiudLF0ChiSyEg3
rmtxOMPZtQpuEMjpzkcVplmQRYXrRACx550c9LiaMm5AbGbt5scMoxnb0y1dzRbx
9AnYh9r+jF3WZm5szVWC3P7q9ApU0Q==
=nk6B
-----END PGP SIGNATURE-----

--jvkPEaOa0neXOSMHxtRPkKge0TydhWp3Q--

