Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8B4C3A5A8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:40:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37E1221883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 12:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E1221883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5UaU-00052H-C2
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 08:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i5UZB-00044l-2m
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i5UZ9-0002Zt-Kp
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 08:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i5UZ6-0002Vi-2h; Wed, 04 Sep 2019 08:39:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 379927BDA5;
 Wed,  4 Sep 2019 12:39:11 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A346B5D9C9;
 Wed,  4 Sep 2019 12:39:04 +0000 (UTC)
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
References: <20190820104836.3093-1-quintela@redhat.com>
 <20190820104836.3093-5-quintela@redhat.com>
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
Message-ID: <22efeb99-70d7-13dc-407e-b6fcbce31797@redhat.com>
Date: Wed, 4 Sep 2019 07:39:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190820104836.3093-5-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WpWgAv0NLnUufyZqvquEll8tWTnOWWblw"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 04 Sep 2019 12:39:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/5] socket: Add num connections to
 qio_net_listener_open_sync()
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WpWgAv0NLnUufyZqvquEll8tWTnOWWblw
Content-Type: multipart/mixed; boundary="hPPYsnKPGTJqjOkmA1l4P96hrrtkz28DQ";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Message-ID: <22efeb99-70d7-13dc-407e-b6fcbce31797@redhat.com>
Subject: Re: [PATCH v3 4/5] socket: Add num connections to
 qio_net_listener_open_sync()
References: <20190820104836.3093-1-quintela@redhat.com>
 <20190820104836.3093-5-quintela@redhat.com>
In-Reply-To: <20190820104836.3093-5-quintela@redhat.com>

--hPPYsnKPGTJqjOkmA1l4P96hrrtkz28DQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 8/20/19 5:48 AM, Juan Quintela wrote:
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  blockdev-nbd.c            | 2 +-
>  chardev/char-socket.c     | 2 +-
>  include/io/net-listener.h | 2 ++
>  io/net-listener.c         | 3 ++-
>  migration/socket.c        | 2 +-
>  qemu-nbd.c                | 2 +-
>  ui/vnc.c                  | 4 ++--
>  7 files changed, 10 insertions(+), 7 deletions(-)

Just now noticing this one, even though the pull request is already sent.=
=2E.

>=20
> diff --git a/blockdev-nbd.c b/blockdev-nbd.c
> index 7a71da447f..c621686131 100644
> --- a/blockdev-nbd.c
> +++ b/blockdev-nbd.c
> @@ -101,7 +101,7 @@ void nbd_server_start(SocketAddress *addr, const ch=
ar *tls_creds,
>      qio_net_listener_set_name(nbd_server->listener,
>                                "nbd-listener");
> =20
> -    if (qio_net_listener_open_sync(nbd_server->listener, addr, errp) <=
 0) {
> +    if (qio_net_listener_open_sync(nbd_server->listener, addr, 1, errp=
) < 0) {
>          goto error;
>      }

Does this interfere with the ability to have more than one client
connect to an NBD server during pull-mode incremental backup?  Or can
you still have multiple simultaneous clients, provided that the server
has finished accepting the connection from the first before the second
one starts?

> +++ b/qemu-nbd.c
> @@ -1054,7 +1054,7 @@ int main(int argc, char **argv)
>      server =3D qio_net_listener_new();
>      if (socket_activation =3D=3D 0) {
>          saddr =3D nbd_build_socket_address(sockpath, bindto, port);
> -        if (qio_net_listener_open_sync(server, saddr, &local_err) < 0)=
 {
> +        if (qio_net_listener_open_sync(server, saddr, 1, &local_err) <=
 0) {

Here, 'qemu-nbd -e $n' allows up to $n simultaneous clients.  Should we
be feeding in that number, instead of a hard-coded 1, to make it easier
for those clients to connect simultaneously?

We can make such changes as a followup patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--hPPYsnKPGTJqjOkmA1l4P96hrrtkz28DQ--

--WpWgAv0NLnUufyZqvquEll8tWTnOWWblw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1vsGcACgkQp6FrSiUn
Q2r7uQgAoshFe247zfB+2w/3Ej+tbcYX9JNxht/gHRNmMZqIh73XXXdTDvk8x4cY
YQ9Px/62TKghE1L5HxTYy7Jcy1kVJQXSoTRxyyXlmqMqjl5GWsG97XXu6lpjCTyN
M2GHUaGJBvsUlFWbvNYel30QT4TSDV/NlKMeF+vY3FUbLkdYQiqbjrzegKOpIX62
XsYGr69LvNAjVzgJeGLffnvXaJmSgqvI7nO0oTptCpQ5fsmh5cc/tyISaZqPq0Zr
ohym96wvB6P2VoU/lkwE4qJ+iYI6w+eDYPjdrtAwXDpFCXUwkyn5jGBbfraeH3XK
Jg8z74hKeY0R9xb6i2MRpsjtex/B3A==
=a1yw
-----END PGP SIGNATURE-----

--WpWgAv0NLnUufyZqvquEll8tWTnOWWblw--

