Received: from eggs.gnu.org ([209.51.188.92]:39745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3Ls-0005Hz-F1
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gn3Lr-0004no-Oj
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:25:04 -0500
References: <20190125151440.13794-1-sourav.jb1988@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f9288ca3-1f07-3409-ac16-ce4dc958940e@redhat.com>
Date: Fri, 25 Jan 2019 16:24:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190125151440.13794-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw: input: set category of the i8042 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 2019-01-25 16:14, kumar sourav wrote:
> Sets the category of i8042 device as DEVICE_CATEGORY_INPUT
> Devices should be assigned to one of DEVICE_CATEGORY_XXXX.
> 
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
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
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
