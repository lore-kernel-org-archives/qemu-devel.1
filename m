Received: from eggs.gnu.org ([209.51.188.92]:50866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk8ev-0006H0-St
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:28:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gk8eu-0006sd-Mf
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:28:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gk8eu-0006ou-FW
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:28:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so1275104wml.2
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 06:28:40 -0800 (PST)
Date: Thu, 17 Jan 2019 15:28:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190117142836.g2izbqvimkzl62wd@steredhat>
References: <20190117133834.7480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117133834.7480-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] exec.c: Use correct attrs in
 cpu_memory_rw_debug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Thu, Jan 17, 2019 at 01:38:34PM +0000, Peter Maydell wrote:
> In the softmmu version of cpu_memory_rw_debug(), we ask the
> CPU for the attributes to use for the virtual memory access,
> and we correctly use those to identify the address space
> index. However, we were not passing them in to the
> address_space_write_rom() and address_space_rw() functions.
> 
> The effect of this was that a memory access from the gdbstub
> to a device which had behaviour that was sensitive to the
> memory attributes (such as some ARMv8M NVIC registers) was
> incorrectly always performed as if non-secure, rather than
> using the right security state for the CPU's current state.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1812091
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  exec.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
