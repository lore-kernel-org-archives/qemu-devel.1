Received: from eggs.gnu.org ([2001:4830:134:3::10]:41799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9Gq-0005qJ-JN
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eP9Gm-00043Q-N6
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:48:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eP9Gm-00041f-G3
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 10:48:28 -0500
Date: Wed, 13 Dec 2017 15:48:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171213154806.GH7173@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-8-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jHkwA2TBA/ec6v+"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-8-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 07/26] monitor: unify global init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--9jHkwA2TBA/ec6v+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:51:41PM +0800, Peter Xu wrote:
> diff --git a/vl.c b/vl.c
> index 1ad1c04637..1ec995a6ae 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3144,7 +3144,6 @@ int main(int argc, char **argv, char **envp)
>      qemu_init_exec_dir(argv[0]);
> =20
>      module_call_init(MODULE_INIT_QOM);
> -    monitor_init_qmp_commands();
> =20
>      qemu_add_opts(&qemu_drive_opts);
>      qemu_add_drive_opts(&qemu_legacy_drive_opts);
> @@ -4690,6 +4689,8 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
> =20
> +    monitor_init_globals();

Why did you move monitor_init_qmp_commands() down here?

There are many function calls between the old position and the new
position.  Did you check all of them to make sure they don't touch the
monitor which is now totally uninitialized?

--9jHkwA2TBA/ec6v+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMUu2AAoJEJykq7OBq3PI7igH/AulIO66z8ygo0TpavkRq+gY
utR4j1YHWjkMFqcw9BF/ygzBdlApOP1k/M8SxUvn0NeZlRMTre5nLrp3P4QMP/S5
EvgOsDr9IJtsQ7H/h5TKhRbUIvOnn4f3LeXpXKmI0yOtzErVcSZQmVZVZ2FmLlZ5
eUTDPWsobibeKm1M1iCi/IPYvHy2vTQPq8tH7Yc9QmZxbXTF+IsE4po0somqutKi
nOzZ/HM6SWd2UbNKXFuFGFgrIAjUE6umyW6f73FsbmMZWdVmBP/FMeZIR6UA9QOi
NtAujK1WJVED4n2jPKHcxE09R/nPNAUgLQE4i90EfMLRVRmZFMBmdQuoZrd6Xeg=
=AcPq
-----END PGP SIGNATURE-----

--9jHkwA2TBA/ec6v+--
