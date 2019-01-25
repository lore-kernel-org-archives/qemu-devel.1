Received: from eggs.gnu.org ([209.51.188.92]:42672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7ah-0006l1-1n
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gn7R0-0007bO-IY
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 14:46:41 -0500
Date: Fri, 25 Jan 2019 14:46:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190125144613-mutt-send-email-mst@kernel.org>
References: <20190125151440.13794-1-sourav.jb1988@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125151440.13794-1-sourav.jb1988@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] hw: input: set category of the i8042 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, thuth@redhat.com

On Fri, Jan 25, 2019 at 08:44:40PM +0530, kumar sourav wrote:
> Sets the category of i8042 device as DEVICE_CATEGORY_INPUT
> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
> 
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

who's merging this? Paolo?

> ---
>  hw/input/pckbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index 3e66713b47..72e7d5f6cc 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -574,6 +574,7 @@ static void i8042_class_initfn(ObjectClass *klass, void *data)
>  
>      dc->realize = i8042_realizefn;
>      dc->vmsd = &vmstate_kbd_isa;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>  
>  static const TypeInfo i8042_info = {
> -- 
> 2.17.1
