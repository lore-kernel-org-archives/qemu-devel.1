Received: from eggs.gnu.org ([2001:4830:134:3::10]:46779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Vgb-0002yD-Du
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8VgX-0007U8-EQ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:50:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35274 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8VgX-0007Tq-8E
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 14:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BFFD74182D58
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 18:50:32 +0000 (UTC)
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-5-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a33a9fcb-f6a5-d211-c5f8-0607a65729ab@redhat.com>
Date: Tue, 17 Apr 2018 13:50:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180417133602.23832-5-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ov0rHSE9ntFhHed8yF3jzF1koXyDWsJlf"
Subject: Re: [Qemu-devel] [PATCH v5 4/5] qobject: modify qobject_ref() to
 return obj
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ov0rHSE9ntFhHed8yF3jzF1koXyDWsJlf
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <a33a9fcb-f6a5-d211-c5f8-0607a65729ab@redhat.com>
Subject: Re: [PATCH v5 4/5] qobject: modify qobject_ref() to return obj
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
 <20180417133602.23832-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180417133602.23832-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/17/2018 08:36 AM, Marc-Andr=C3=A9 Lureau wrote:
> For convenience and clarity, make it possible to call qobject_ref() at
> the time when the reference is associated with a variable, or
> argument, by making qobject_ref() return the same pointer as given.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---

> +++ b/monitor.c

> @@ -4049,8 +4046,7 @@ static void monitor_qmp_respond(Monitor *mon, QOb=
ject *rsp,
>      if (rsp) {
>          if (id) {
>              /* This is for the qdict below. */
> -            qobject_ref(id);
> -            qdict_put_obj(qobject_to(QDict, rsp), "id", id);
> +            qdict_put_obj(qobject_to(QDict, rsp), "id", qobject_ref(id=
));

Is the comment still needed?  It made more sense when there were two
statements, and now I think you can just delete it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ov0rHSE9ntFhHed8yF3jzF1koXyDWsJlf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWQfQACgkQp6FrSiUn
Q2pQaggArTpT6kz59+Mc2DrBGzScWnPBoKidIHoKehCnjD8KNIHjZuhzIt8XD4Wl
ukNGfmLFGLfc15KNPzQOO/VIE9TNFhcWsDBhdDtOLxY4X36XR1k4uIpkcq1Vo0C+
IERfv12TGlyq8pXqj31FHD+wzdfIKPs+lR9dV8tdDVD8jXk/yyJc7rLKZxn+gAek
mrGPKb/uEGI57wHHkPoZXwn6elAPCR4foFZAX1+xtdY7dolTuYk92bwYs8+JlDPO
KpncE2jmuhsjMnmDo752x+zopdnrOIe4BTxtFgJyylnArtD9hX9yzbFJgo6Vna9k
GjncGxcAPNtSw3t1J9QlbMuhTaV41Q==
=WvPV
-----END PGP SIGNATURE-----

--Ov0rHSE9ntFhHed8yF3jzF1koXyDWsJlf--
