Received: from eggs.gnu.org ([2001:4830:134:3::10]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7wVZ-0003Fh-BX
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 01:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f7wVU-0004TZ-DW
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 01:16:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f7wVU-0004TM-8r
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 01:16:48 -0400
References: <20180415230522.24404-1-f4bug@amsat.org>
	<20180415230522.24404-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5adfa8ce-b400-b017-5495-a0690decd183@redhat.com>
Date: Mon, 16 Apr 2018 07:16:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180415230522.24404-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: Display if libfdt is from
 system or git
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, YunQiang Su <syq@debian.org>, David Gibson <david@gibson.dropbear.id.au>

On 16.04.2018 01:05, Philippe Mathieu-Daud=C3=A9 wrote:
> The configure script outputs "yes" regardless which libfdt is used:
>=20
>   ./configure
>   [...]
>   fdt support       yes
>=20
> Sometimes you can have both system and local git version available,
> change the configure script to display which library got selected:
>=20
>   debian8$ dpkg-query --showformat=3D'${Version}\n' --show libfdt-dev
>   1.4.0+dfsg-1
>=20
>   debian8$ ./configure
>   [...]
>   fdt support       git
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  configure | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/configure b/configure
> index 162e804b49..056b391f22 100755
> --- a/configure
> +++ b/configure
> @@ -3758,15 +3758,14 @@ int main(void) { fdt_first_subnode(0, 0); retur=
n 0; }
>  EOF
>    if compile_prog "" "$fdt_libs" ; then
>      # system DTC is good - use it
> -    fdt=3Dyes
> +    fdt=3Dsystem
>    else
>        # have GIT checkout, so activate dtc submodule
>        if test -e "${source_path}/.git" ; then
>            git_submodules=3D"${git_submodules} dtc"
>        fi
>        if test -d "${source_path}/dtc/libfdt" || test -e "${source_path=
}/.git" ; then
> -          fdt=3Dyes
> -          dtc_internal=3D"yes"
> +          fdt=3Dgit

That's ok for git checkout, but what about release tarballs? I'd strange
to see "git" here. So maybe better use "internal" instead of "git" here?

OTOH, capstone is also using the term "git" here, so this is just
consistent here...

 Thomas
