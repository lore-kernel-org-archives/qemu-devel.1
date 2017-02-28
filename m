Received: from eggs.gnu.org ([2001:4830:134:3::10]:38490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVi9-0001d3-Jj
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVi5-0003cp-DX
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:32:13 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ciVi5-0003ck-9M
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:32:09 -0500
Received: by mail-qk0-x241.google.com with SMTP id n186so7486714qkb.0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:32:09 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170225110517.2832-1-laurent@vivier.eu>
	<20170225110517.2832-3-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5689b397-42d3-fec9-0a2c-f9440e93dc98@twiddle.net>
Date: Tue, 28 Feb 2017 11:32:03 +1100
MIME-Version: 1.0
In-Reply-To: <20170225110517.2832-3-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] linux-user: fix do_rt_sigreturn on
 m68k linux userspace emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: Michael Karcher <karcher@physik.fu-berlin.de>, qemu-devel@nongnu.org

On 02/25/2017 10:05 PM, Laurent Vivier wrote:
> From: Michael Karcher <karcher@physik.fu-berlin.de>
>
> do_rt_sigreturn uses an uninitialised local variable instead of fetching
> the old signal mask directly from the signal frame when restoring the mask,
> so the signal mask is undefined after do_rt_sigreturn. As the signal
> frame data is in target-endian order, target_to_host_sigset instead of
> target_to_host_sigset_internal is required.
>
> do_sigreturn is correct in using target_to_host_sigset_internal, because
> get_user already did the endianness conversion.
>
> Signed-off-by: Michael Karcher <karcher@physik.fu-berlin.de>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/signal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
