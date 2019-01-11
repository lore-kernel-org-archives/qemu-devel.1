Received: from eggs.gnu.org ([209.51.188.92]:60874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ght2O-0005A4-I3
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ght2N-0005us-OD
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:23:36 -0500
Date: Fri, 11 Jan 2019 09:23:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190111092313.GD18491@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1547194672-24169-1-git-send-email-thuth@redhat.com>
	<1547194672-24169-4-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547194672-24169-4-git-send-email-thuth@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 3/3] configure: Force the C standard to
 gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-ppc@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Jan 11, 2019 at 09:17:52AM +0100, Thomas Huth wrote:
> Different versions of GCC and Clang use different versions of the C sta=
ndard.
> This repeatedly caused problems already, e.g. with duplicated typedefs:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
>=20
> or with for-loop variable initializers:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
>=20
> To avoid these problems, we should enforce the C language version to th=
e
> same level for all compilers. Since our minimum compiler versions is
> GCC v4.8, our best option is "gnu99" for C code right now ("gnu17" is n=
ot
> available there yet, and "gnu11" is marked as "experimental"), and "gnu=
++98"
> for the few C++ code that we have in the repository.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)


Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
