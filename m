Received: from eggs.gnu.org ([2001:4830:134:3::10]:38182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzmd-0003mX-6W
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fFzmY-0004nR-6n
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:23:47 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:40367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fFzmX-0004nJ-V7
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:23:42 -0400
Received: by mail-wr0-x241.google.com with SMTP id v60-v6so31709317wrc.7
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 03:23:41 -0700 (PDT)
Date: Tue, 8 May 2018 11:23:38 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180508102338.GE19710@stefanha-x1.localdomain>
References: <20180502100422.8688-1-peterx@redhat.com>
	<20180502100422.8688-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Content-Disposition: inline
In-Reply-To: <20180502100422.8688-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/4] monitor: more comments on lock-free
 fleids/funcs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 02, 2018 at 06:04:21PM +0800, Peter Xu wrote:
> Add some explicit comment for both Readline and cpu_set/cpu_get helpers
> that they do not need the mon_lock protection.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index 9f361ec21e..6100ad44f8 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -207,6 +207,7 @@ struct Monitor {
>      int suspend_cnt;            /* Needs to be accessed atomically */
>      bool skip_flush;
>      bool use_io_thr;
> +    /* Only used in parser, so no lock needed. */
>      ReadLineState *rs;
>      MonitorQMP qmp;
>      gchar *mon_cpu_path;

Which fields does this comment cover?

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa8XqqAAoJEJykq7OBq3PIWsoH+wdMp01FLt8P91RBfXyxeC9Q
r20OH1pbLotuJ+ZQpotUUG5wjRvDP7VxxoToGnVScDPP5EKDp6GibsZ2Wu2+SZ3y
sK1+ncy8Mk48sqTk7T3reuWJ1rdV6Q0tKxmB0iSoJ4YAfkOahK1qlh3hnHCSuPg6
oMv6bbOhx5Th12m4kvPMuQGMndnlpfX6zygNJj3ObRKp72t7eIBdsuNg8kt3tO/W
6KY3xoxiIDBDHdazX9fcoNeSy0a+Oe+x65R2Rb4JFNCWMKRyvvVhbrRzAge9ql3o
fUuxq9DihMspKzEGNLQJUvMQQvF7iK6ftlzIb4EcOnDARzKv+bxtKq1ibCNtnSU=
=FS+8
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
