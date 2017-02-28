Received: from eggs.gnu.org ([2001:4830:134:3::10]:38237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVhY-0001Iu-W4
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:31:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ciVhU-0003Qb-3f
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:31:37 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ciVhU-0003QK-0p
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:31:32 -0500
Received: by mail-qk0-x244.google.com with SMTP id r90so21107063qki.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:31:31 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170225110517.2832-1-laurent@vivier.eu>
	<20170225110517.2832-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c0fe5697-2888-a912-b342-8afc5ff2bdb0@twiddle.net>
Date: Tue, 28 Feb 2017 11:31:25 +1100
MIME-Version: 1.0
In-Reply-To: <20170225110517.2832-2-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: correctly manage SR in
 ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

On 02/25/2017 10:05 PM, Laurent Vivier wrote:
> Use cpu_m68k_get_ccr()/cpu_m68k_set_ccr() to setup and restore correctly
> the value of SR in the ucontext structure
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/signal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
