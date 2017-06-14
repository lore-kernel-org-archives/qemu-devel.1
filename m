Received: from eggs.gnu.org ([2001:4830:134:3::10]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL40Y-0006Zg-Q6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:50:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL40V-0002Hj-Jx
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:50:34 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:37831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dL40V-0002HF-Ch
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:50:31 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id DB2BE106175
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 10:50:29 +0200 (CEST)
Date: Wed, 14 Jun 2017 10:50:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170614105024.5f8658d0@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170614083434.17966-1-quintela@redhat.com>
References: <20170614083434.17966-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/1N63WUdL5Y7bqOg0F=meR43";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] migration: Fix compilation with older
 compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

--Sig_/1N63WUdL5Y7bqOg0F=meR43
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Jun 2017 10:34:34 +0200
Juan Quintela <quintela@redhat.com> wrote:

> That typedefs are needed on both files.  New compilers (F25 where I

Only LoadStateHandler is actually needed by both files but I guess
it is ok to keep these typedefs together.

Reviewed-by: Greg Kurz <groug@kaod.org>

> work) don't complain about repeating a typedef.  But older ones
> complain.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/register.h | 3 ---
>  include/migration/vmstate.h  | 1 -
>  include/qemu/typedefs.h      | 2 ++
>  3 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 717c617..d9498d9 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -14,9 +14,6 @@
>  #ifndef MIGRATION_REGISTER_H
>  #define MIGRATION_REGISTER_H
> =20
> -typedef void SaveStateHandler(QEMUFile *f, void *opaque);
> -typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
> -
>  typedef struct SaveVMHandlers {
>      /* This runs inside the iothread lock.  */
>      SaveStateHandler *save_state;
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index f3f3c2a..e85fbd8 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -29,7 +29,6 @@
> =20
>  #include "migration/qjson.h"
> =20
> -typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
>  typedef struct VMStateInfo VMStateInfo;
>  typedef struct VMStateDescription VMStateDescription;
>  typedef struct VMStateField VMStateField;
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index 51958bf..f745d5f 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -96,5 +96,7 @@ typedef struct uWireSlave uWireSlave;
>  typedef struct VirtIODevice VirtIODevice;
>  typedef struct Visitor Visitor;
>  typedef struct node_info NodeInfo;
> +typedef void SaveStateHandler(QEMUFile *f, void *opaque);
> +typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
> =20
>  #endif /* QEMU_TYPEDEFS_H */


--Sig_/1N63WUdL5Y7bqOg0F=meR43
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllA+NAACgkQAvw66wEB28KgbACfQjL3OoyuHoiG9bHcTQ8Q1QsE
8I8AniD91vEx890vbJOjkV0roIubeDeS
=W6VM
-----END PGP SIGNATURE-----

--Sig_/1N63WUdL5Y7bqOg0F=meR43--
