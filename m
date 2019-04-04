Received: from eggs.gnu.org ([209.51.188.92]:39188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hByXZ-0005jf-IY
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:20:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hByXX-0001P7-5l
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 05:20:09 -0400
Date: Thu, 4 Apr 2019 10:19:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190404091957.GL10471@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190404091725.20595-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190404091725.20595-1-dgilbert@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: fix pam test warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

CC trivial

On Thu, Apr 04, 2019 at 10:17:25AM +0100, Dr. David Alan Gilbert (git) wr=
ote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The pam test generates a warning on Fedora 29 with -O3 compilation
> because the headers declare that the pam_conversation pointer to
> pam_start must be non-NULL.  Change it to use the same 0 initialised
> structure as we actually use in qauthz.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

>=20
> diff --git a/configure b/configure
> index 1c563a7027..73f7ad2be0 100755
> --- a/configure
> +++ b/configure
> @@ -2946,9 +2946,9 @@ if test "$auth_pam" !=3D "no"; then
>  int main(void) {
>     const char *service_name =3D "qemu";
>     const char *user =3D "frank";
> -   const struct pam_conv *pam_conv =3D NULL;
> +   const struct pam_conv pam_conv =3D { 0 };
>     pam_handle_t *pamh =3D NULL;
> -   pam_start(service_name, user, pam_conv, &pamh);
> +   pam_start(service_name, user, &pam_conv, &pamh);
>     return 0;
>  }
>  EOF

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
