Received: from eggs.gnu.org ([2001:4830:134:3::10]:44350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eEJCM-000421-4I
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eEJCG-0004FK-9r
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 13:11:06 -0500
MIME-Version: 1.0
In-Reply-To: <1510564905-6185-1-git-send-email-thuth@redhat.com>
References: <1510564905-6185-1-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Nov 2017 10:10:27 -0800
Message-ID: <CAKmqyKMvFAZ3p+2csO=viTyF7ruCpWL4iReZVzNRcO9DnaAkkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts/make-release: No need to delete
 pixman/.git anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Nov 13, 2017 at 1:21 AM, Thomas Huth <thuth@redhat.com> wrote:
> The pixman submodule has been removed in commit c12b6d70e384c769ca372e1,
> so there is no need anymore to delete pixman/.git while building a
> release tarball.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  scripts/make-release | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/make-release b/scripts/make-release
> index fa6323f..70367ab 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -19,7 +19,7 @@ pushd ${destination}
>  git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
> -rm -rf .git roms/*/.git dtc/.git pixman/.git
> +rm -rf .git roms/*/.git dtc/.git
>  popd
>  tar cfj ${destination}.tar.bz2 ${destination}
>  rm -rf ${destination}
> --
> 1.8.3.1
>
>
