Received: from eggs.gnu.org ([2001:4830:134:3::10]:46847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIFq2-0004ch-Cc
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fIFq1-0006Xg-MT
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:56:38 -0400
MIME-Version: 1.0
In-Reply-To: <CACKT+Ap2MHCrSCT-0_=KG9UrGAtO7F3EGue6-63-XJxry9=C=w@mail.gmail.com>
References: <CACKT+Ap2MHCrSCT-0_=KG9UrGAtO7F3EGue6-63-XJxry9=C=w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 14 May 2018 16:56:35 +0100
Message-ID: <CAJSP0QW1BN8ouvQU4LRSeYmn02A63-pB3Cq6xT9h8hm70Gti3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] handle all fdt_get_phandle_errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jonathan Marler <johnnymarler@gmail.com>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, qemu-devel <qemu-devel@nongnu.org>, qemu-trivial <qemu-trivial@nongnu.org>

On Fri, May 4, 2018 at 7:37 PM, Jonathan Marler <johnnymarler@gmail.com> wrote:
> Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
> ---
>  device_tree.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/device_tree.c b/device_tree.c
> index 52c3358..2b75905 100644
> --- a/device_tree.c
> +++ b/device_tree.c
> @@ -379,8 +379,12 @@ uint32_t qemu_fdt_get_phandle(void *fdt, const char
> *path)
>
>      r = fdt_get_phandle(fdt, findnode_nofail(fdt, path));
>      if (r == 0) {
> -        error_report("%s: Couldn't get phandle for %s: %s", __func__,
> -                     path, fdt_strerror(r));
> +        error_report("%s: Node %s does not have a 'phandle'", __func__,
> +                     path);
> +        exit(1);
> +    }
> +    if (r == -1) {
> +        error_report("%s: Couldn't get phandle for %s", __func__, path);

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
