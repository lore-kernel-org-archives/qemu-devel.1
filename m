Received: from eggs.gnu.org ([2001:4830:134:3::10]:35587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cuqVy-00048V-Iq
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 21:10:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cuqVx-0002Cz-K9
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 21:10:38 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cuqVx-0002B3-Dk
	for qemu-devel@nongnu.org; Sun, 02 Apr 2017 21:10:37 -0400
Received: by mail-pg0-x241.google.com with SMTP id o123so26121085pga.1
	for <qemu-devel@nongnu.org>; Sun, 02 Apr 2017 18:10:35 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1490630670-15818-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <421c5729-f0d2-1c1b-bbd0-ebeb5584e082@twiddle.net>
Date: Tue, 28 Mar 2017 09:35:23 +1000
MIME-Version: 1.0
In-Reply-To: <1490630670-15818-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] tcg/sparc: zero extend ld/st
 helper args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 03/28/2017 02:04 AM, Peter Maydell wrote:
> These patches fix problems with the SPARC TCG backend code
> which calls the load and store helpers. Where the argument
> being passed to the helper is narrower than the size of the
> native register, the SPARC calling convention requires that
> we extend it to the register size, but we weren't doing that.
> This meant we passed the host code registers which might have
> garbage in the high parts, and if the host code was built
> with optimization this resulted in wrong behaviour.
>
> I still see problems trying to run the bits of 'make check'
> that run guest code, but at least with these patches we can
> run the i386 bios code enough to try to do PXE boot and not
> find a server.
>
>
> Peter Maydell (2):
>   tcg/sparc: Zero extend data argument to store helpers
>   tcg/sparc: Zero extend address argument to ld/st helpers
>
>  tcg/sparc/tcg-target.inc.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
