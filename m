Received: from eggs.gnu.org ([209.51.188.92]:55829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guH1F-0000m5-25
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guH1D-0005Go-Qq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:25:36 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:50435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1guH1D-000591-FR
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:25:35 -0500
References: <mvmmun7y7m0.fsf@suse.de>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <25f32c5b-3b8e-0a1f-b86c-0c0e4ce37d69@vivier.eu>
Date: Thu, 14 Feb 2019 14:25:17 +0100
MIME-Version: 1.0
In-Reply-To: <mvmmun7y7m0.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix emulation of
 accept4/getpeername/getsockname/recvfrom syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@suse.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 07/02/2019 15:51, Andreas Schwab wrote:
> System calls that return a socket address do so by writing the (possibly
> truncated) address into the provided buffer space, but setting the addrlen
> parameter to the actual size of the address.  To determine how much to
> copy back to the target memory the emulation needs to remember the old
> value of the addrlen parameter, so that it doesn't write past the buffer
> limits.
> 
> Signed-off-by: Andreas Schwab <schwab@suse.de>
> ---
>  linux-user/syscall.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
