Received: from eggs.gnu.org ([2001:4830:134:3::10]:38811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfS9Q-0003OY-Bn
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfS9P-0005I0-59
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:40:00 -0400
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
	<1502117160-24655-2-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <546a1140-e5e1-b6b9-2671-0dba6a274227@redhat.com>
Date: Wed, 9 Aug 2017 09:39:42 -0500
MIME-Version: 1.0
In-Reply-To: <1502117160-24655-2-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ASeq5S2qChXrbt0gOXh2TcAaiMUOxfiPw"
Subject: Re: [Qemu-devel] [RFC PATCH 01/56] qobject: Touch up comments to
 say @param instead of 'param'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ASeq5S2qChXrbt0gOXh2TcAaiMUOxfiPw
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com,
 jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org
Message-ID: <546a1140-e5e1-b6b9-2671-0dba6a274227@redhat.com>
Subject: Re: [RFC PATCH 01/56] qobject: Touch up comments to say @param
 instead of 'param'
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
 <1502117160-24655-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 09:45 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qobject/qdict.c | 68 ++++++++++++++++++++++++++++---------------------=
--------
>  qobject/qlist.c |  2 +-
>  2 files changed, 35 insertions(+), 35 deletions(-)
>=20
> diff --git a/qobject/qdict.c b/qobject/qdict.c
> index 576018e..d795079 100644
> --- a/qobject/qdict.c
> +++ b/qobject/qdict.c
> @@ -116,13 +116,13 @@ static QDictEntry *qdict_find(const QDict *qdict,=

>  /**
>   * qdict_put_obj(): Put a new QObject into the dictionary
>   *
> - * Insert the pair 'key:value' into 'qdict', if 'key' already exists
> - * its 'value' will be replaced.
> + * Insert the pair @key:@value into @qdict, if @key already exists
> + * its value will be replaced.

Maybe s/,/;/ while at it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ASeq5S2qChXrbt0gOXh2TcAaiMUOxfiPw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLHq4ACgkQp6FrSiUn
Q2ro2wf/XSUFXtZmBDtson28FZY4bb9Gyi3rkzFWBUeN1hVQ1vVzTH1338u3Xgmk
0z2i1KAkVOVSCwdI+M8NwrhvpenWheL2zhu/iHJBtA3p2k1cgDiSD/o9j441wHIX
SZTf+hqlr6BO1lYELSMNTAq/tSzd9XKp6Q7hXku3aYn7290iCGtVdvZb2jFUMkwO
fiYL7FELql5kqBbd8nhghdhEpKT8rI1JD/K8lsW/uSmFLO0ii3tKRzHAR8VPicGt
GC+vVn+dk2xjn+f7V3KMPpc09mNOM99GRd4uexTonFXGKTOjB9wReTdTeLCeQagM
XaoHq3KcRbHTDWYymWDt2EpKfQgjWA==
=a4TC
-----END PGP SIGNATURE-----

--ASeq5S2qChXrbt0gOXh2TcAaiMUOxfiPw--
