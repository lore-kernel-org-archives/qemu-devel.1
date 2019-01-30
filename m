Received: from eggs.gnu.org ([209.51.188.92]:36150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gom2D-00047w-JD
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gom2C-000719-SP
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:19:53 -0500
References: <20190125151440.13794-1-sourav.jb1988@gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9a14a8b4-b0c5-c5bd-9563-c8e6f73e9c03@vivier.eu>
Date: Wed, 30 Jan 2019 10:19:45 +0100
MIME-Version: 1.0
In-Reply-To: <20190125151440.13794-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw: input: set category of
 the i8042 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, mst@redhat.com

On 25/01/2019 16:14, kumar sourav wrote:
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

Applied to my trivial-patches branch.

Thanks,
Laurent
