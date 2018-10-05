Received: from eggs.gnu.org ([2001:4830:134:3::10]:42259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8SwY-0000oe-O0
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8SwY-0001Nm-2G
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 12:27:10 -0400
MIME-Version: 1.0
References: <1538732546-2284-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1538732546-2284-1-git-send-email-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 5 Oct 2018 09:26:41 -0700
Message-ID: <CAKmqyKMThBh1+pEPFn5sVgGPRDF-zFoDXpO9iO_=hYKNEJhEZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Set a category for
 the generic-loader device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Alistair Francis <alistair@alistair23.me>

On Fri, Oct 5, 2018 at 2:52 AM Thomas Huth <thuth@redhat.com> wrote:
>
> Each device that is instantiatable by the users should be marked with
> a category. Since the generic-loader does not fit anywhere else, put
> it into the MISC category.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/core/generic-loader.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
> index fde32cb..be29ae1 100644
> --- a/hw/core/generic-loader.c
> +++ b/hw/core/generic-loader.c
> @@ -204,6 +204,7 @@ static void generic_loader_class_init(ObjectClass *klass, void *data)
>      dc->unrealize = generic_loader_unrealize;
>      dc->props = generic_loader_props;
>      dc->desc = "Generic Loader";
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>  }
>
>  static TypeInfo generic_loader_info = {
> --
> 1.8.3.1
>
>
