Received: from eggs.gnu.org ([2001:4830:134:3::10]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUnhg-0002oL-PQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 01:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dUnhd-0004pf-NI
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 01:27:20 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170609133337.31183-1-marcandre.lureau@redhat.com>
Date: Tue, 11 Jul 2017 07:27:12 +0200
In-Reply-To: <20170609133337.31183-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 9 Jun 2017 17:33:37 +0400")
Message-ID: <87pod7o85r.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: check-qom-proplist: fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-trivial@nongnu.org

Copying qemu-trivial.

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> user_creatable_add_opts() returns a reference (the other reference is
> for the root parent/child link).
>
> Leak introduced in commit a1af255f065cc.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/check-qom-proplist.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
> index 8e432e9ab6..a3cd7ab29f 100644
> --- a/tests/check-qom-proplist.c
> +++ b/tests/check-qom-proplist.c
> @@ -428,6 +428,8 @@ static void test_dummy_createcmdl(void)
>      g_assert(err =3D=3D NULL);
>      error_free(err);
>=20=20
> +    object_unref(OBJECT(dobj));
> +
>      /*
>       * cmdline-parsing via qemu_opts_parse() results in a QemuOpts entry
>       * corresponding to the Object's ID to be added to the QemuOptsList

Reviewed-by: Markus Armbruster <armbru@redhat.com>
