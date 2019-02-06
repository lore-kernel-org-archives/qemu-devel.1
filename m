Received: from eggs.gnu.org ([209.51.188.92]:54354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1grJqF-0005vv-D3
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:50:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1grJaV-000636-C7
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:33:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1grJaQ-0005oW-VF
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:33:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id q15so6660745wro.12
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 01:33:40 -0800 (PST)
Date: Wed, 6 Feb 2019 10:33:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190206093336.gelus7zg7qtkuavn@steredhat>
References: <20190205174207.9278-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205174207.9278-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] linux-user: Check sscanf return value in
 open_net_route()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On Tue, Feb 05, 2019 at 05:42:07PM +0000, Peter Maydell wrote:
> Coverity warns (CID 1390634) that open_net_route() is not
> checking the return value from sscanf(), which means that
> it might then use values that aren't initialized.
> 
> Errors here should in general not happen since we're passing
> an assumed-good /proc/net/route from the host kernel, but
> if we do fail to parse a line then just skip it in the output
> we pass to the guest.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/syscall.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano
