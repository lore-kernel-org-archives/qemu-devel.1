Received: from eggs.gnu.org ([2001:4830:134:3::10]:46074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqorR-0003zV-1e
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 18:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqorQ-0007OS-1E
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 18:36:09 -0400
MIME-Version: 1.0
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-3-f4bug@amsat.org>
In-Reply-To: <20170322204844.446-3-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Mar 2017 22:35:52 +0000
Message-ID: <CAJ+F1CJmyqHRsgP6uSRYSc6M=4Ud5fP7-UPjs_nUzApDGa3VuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RESEND 2/3] device_tree: fix compiler
 warnings (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Thu, Mar 23, 2017 at 12:49 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> static code analyzer complain:
>
> device_tree.c:155:18: warning: Null pointer passed as an argument to a
> 'nonnull' parameter
>     while ((de =3D readdir(d)) !=3D NULL) {
>                  ^~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  device_tree.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/device_tree.c b/device_tree.c
> index 6e06320830..a24ddff02b 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -148,6 +148,7 @@ static void read_fstree(void *fdt, const char *dirnam=
e)
>      d =3D opendir(dirname);
>      if (!d) {
>          error_setg(&error_fatal, "%s cannot open %s", __func__, dirname)=
;
> +        return;
>      }
>
>      while ((de =3D readdir(d)) !=3D NULL) {
> --
> 2.11.0
>
>
> --
Marc-Andr=C3=A9 Lureau
