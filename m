Received: from eggs.gnu.org ([2001:4830:134:3::10]:53975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzKa-0007cw-Nv
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:39:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzKX-0000kn-JL
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:39:52 -0500
MIME-Version: 1.0
References: <20181109161352.29873-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181109161352.29873-1-mdroth@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:39:36 +0100
Message-ID: <CAAdtpL7XuKf7=658d1C7ZD7HzuxKcGrNjWgDPG=1=UAUPLKfjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH resend for-3.1] make-release: add skiboot
 .version file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On Fri, Nov 9, 2018 at 5:16 PM Michael Roth <mdroth@linux.vnet.ibm.com> wro=
te:
>
> This is needed to build skiboot from tarball-distributed sources
> since the git data the make_release.sh script relies on to generate
> it is not available.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  scripts/make-release | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/make-release b/scripts/make-release
> index 04fa9defdc..c14f75b12c 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -19,6 +19,7 @@ pushd ${destination}
>  git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
> +(cd roms/skiboot && ./make_version.sh > .version)
>  # FIXME: The following line is a workaround for avoiding filename collis=
ions
>  # when unpacking u-boot sources on case-insensitive filesystems. Once we
>  # update to something with u-boot commit 610eec7f0 we can drop this line=
.
> --
> 2.17.1
>
>
