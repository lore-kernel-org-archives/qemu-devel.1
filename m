Received: from eggs.gnu.org ([2001:4830:134:3::10]:34122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4qD-0003HW-I1
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4qA-0006qR-O0
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:58:05 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1db4qA-0006pd-IK
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:58:02 -0400
Received: by mail-wm0-x22b.google.com with SMTP id e199so19334044wmd.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 05:58:02 -0700 (PDT)
Date: Fri, 28 Jul 2017 13:57:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728125759.GO12364@stefanha-x1.localdomain>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FrxVhwK/bNRjN48l"
Content-Disposition: inline
In-Reply-To: <20170725211523.3998-8-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com


--FrxVhwK/bNRjN48l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2017 at 04:15:18PM -0500, Eric Blake wrote:
> +QDict *qtest_qmp_cmd(QTestState *s, const char *cmd, QObject *args)
> +{
> +    QDict *dict = qdict_new();
> +
> +    qdict_put_str(dict, "execute", cmd);
> +    if (args) {
> +        qdict_put_obj(dict, "arguments", args);
> +    }
> +    return qtest_qmp(s, "%p", QOBJECT(dict));
> +}

qtest_qmp(s, "%p", QOBJECT(dict)) takes ownership of dict?

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FrxVhwK/bNRjN48l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZezTXAAoJEJykq7OBq3PIhVsH/jLOGmUaEwvf7xx5HxGeczAZ
HTOvKYkQ6xFzAaYZ69c3BDQa1Y9AGRoB5/z98WK3wvPSRgSBbJWRPNZXU5E0KAK2
FhToQsjA1OM4Vv9skOzgQmH41mmJwsbNBGgZAHVcUAfovJdLXgkAz00knz9Moi+4
ZuWpqxZo7dfgAyPWjb4qeVykuNK3q+uYS+DyPr4Mo43I/YLg2viOjtN590gf7O93
4SqZROpP08/e358/rWN9h8NeDsvBz/wOh8pxDSO/hQEq3B7jiuYOJmLquelHr1F6
MSNhytx00Rq75LbVoOqC2v4AAqe9mm3pXN2RcJft+P0WZBBWP51DuOnSigA/epk=
=IAiC
-----END PGP SIGNATURE-----

--FrxVhwK/bNRjN48l--
