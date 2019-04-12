Received: from eggs.gnu.org ([209.51.188.92]:39730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEr9I-0003az-4q
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hEr9H-0007JW-9F
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:03:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hEr9G-0007JH-W7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 04:02:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id y7so10669973wrn.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 01:02:58 -0700 (PDT)
Date: Fri, 12 Apr 2019 10:02:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190412080249.x2b6utfnqh255msd@steredhat>
References: <1554982098-336210-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554982098-336210-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] roms: assert if max rom size is
 less than the used size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, richard.henderson@linaro.org, stefanha@redhat.com, pbonzini@redhat.com

On Thu, Apr 11, 2019 at 01:28:18PM +0200, Igor Mammedov wrote:
> It would ensure that we would notice attempt to write beyond
> the allocated buffer. In case of MemoryRegion backed ROM it's
> the host buffer and the guest RAM otherwise.
> 
> assert can be triggered with:
>   dd if=/dev/zero of=/tmp/blob bs=63k count=1
>   qemu-system-x86_64 `for  i in {1..33}; do echo -n " -acpitable /tmp/blob"; done`
> 
> Fixes: (a1666142db acpi-build: make ROMs RAM blocks resizeable)
> 
> Reported-by: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/core/loader.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
