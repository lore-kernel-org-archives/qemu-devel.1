Received: from eggs.gnu.org ([2001:4830:134:3::10]:59988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYqy-0001au-Ij
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYYqx-0005MI-Gi
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:24:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYYqx-0005M4-7Z
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 10:24:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3969776A06
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 14:24:26 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-3-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8dcd89b7-8f87-00fa-8b67-594b1463a988@redhat.com>
Date: Fri, 21 Jul 2017 09:24:24 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-3-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5jMxSbNQaS5Hr5SBoTS0bxovruBRuw8TR"
Subject: Re: [Qemu-devel] [PATCH 2/9] qtest: Document calling conventions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5jMxSbNQaS5Hr5SBoTS0bxovruBRuw8TR
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8dcd89b7-8f87-00fa-8b67-594b1463a988@redhat.com>
Subject: Re: [PATCH 2/9] qtest: Document calling conventions
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-3-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-3-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> From: Eric Blake <eblake@redhat.com>
>=20
> We have two flavors of vararg usage in qtest; make it clear that
> qmp() has different semantics than hmp(), and let the compiler
> enforce that hmp() is used correctly. However, qmp() (and friends)
> only accept a subset of printf flags look-alikes (namely, those
> that our JSON parser understands), and what is worse, qmp("true")
> (the JSON keyword 'true') is different from qmp("%s", "true")
> (the JSON string '"true"'), so marking those as printf-like would
> produce more harm from bogus warnings than it helps (we may have
> made a mistake in previously marking qobject_from_jsonf(), but
> this patch is not addressing that).
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20170720214008.28494-5-eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

As you pointed out on the other thread,

> @@ -134,7 +137,7 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const=
 char *event);
>  /**
>   * qtest_hmp:
>   * @s: #QTestState instance to operate on.
> - * @fmt...: HMP command to send to QEMU
> + * @fmt...: HMP command to send to QEMU, formats arguments like vsprin=
tf().
>   *
>   * Send HMP command to QEMU via QMP's human-monitor-command.
>   * QMP events are discarded.

I accidentally killed the attribute here,

> @@ -592,7 +598,7 @@ static inline QDict *qmp_eventwait_ref(const char *=
event)
> =20
>  /**
>   * hmp:
> - * @fmt...: HMP command to send to QEMU
> + * @fmt...: HMP command to send to QEMU, formats arguments like vsprin=
tf().
>   *
>   * Send HMP command to QEMU via QMP's human-monitor-command.
>   *

and here.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5jMxSbNQaS5Hr5SBoTS0bxovruBRuw8TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyDpgACgkQp6FrSiUn
Q2od9AgAjB/6VFn9wFrrhCW2e2pVkIEVPIkT43626OLt6+3iOjzJJoO9wNS5VGXw
V012VHs8gW+GBeYzyVnkb+7IY91Q5r9T5s8F027jD76jEBA/Xek/Xx83k1OWGn9H
ybntIax0uwJC9Yfn/LvJVJyHxwcVvrAks2CBcc8NsuXWjBc/RzTSk9elaC5RLieN
BVj4x8Zy8vQIMC9U+VNhSgFgu9GoBWVuOW1Cp0OnXbQuWgTLoLYbD59r3l+mTLGb
yPMBAT4ocAo8A0e6IKJrEhSoUe7+nGocQKeMsQXIp5WqL6no7mkgyfvbNNP9QQJG
cyVgPeadIM6QD1hAX6T1zQQ1LZIGSw==
=vGlu
-----END PGP SIGNATURE-----

--5jMxSbNQaS5Hr5SBoTS0bxovruBRuw8TR--
