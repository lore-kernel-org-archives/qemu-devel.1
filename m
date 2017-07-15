Received: from eggs.gnu.org ([2001:4830:134:3::10]:58598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dWVMc-0004On-OI
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dWVMX-00006M-Mt
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:16:38 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:46395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dWVMX-0008Sz-Ez
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 18:16:33 -0400
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-7-rth@twiddle.net>
	<20170715221412.3yprwf5i3te4gdxa@aurel32.net>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <c45e78e8-007e-4f0d-508d-74c6987a93af@physik.fu-berlin.de>
Date: Sun, 16 Jul 2017 00:16:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170715221412.3yprwf5i3te4gdxa@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 06/27] target/sh4: Handle user-space
 atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/16/2017 12:14 AM, Aurelien Jarno wrote:
> Do you have actually have a good documentation about gUSA? I have found
> a few documents (some of them in Japanese), the most complete one being
> the LinuxTag paper. The ABI is also described in the kernel and the
> glibc. That said I am missing the following informations:
> - What kind of instructions are allowed in the atomic sequence? Your
>   patch takes into account branches, but are there allowed? used in
>   practice? What about FP instructions?
> - Does the atomic sequence is actually allowed to cross pages?
> - Is there any alignement required? The paper mention adding a nop to
>   gUSA_exchange_and_add to align the end point to 4 bytes.

The best person to answer this is Yutaka Niibe as he is actually the
person who came up with the design. I'll drop him a message and see
if he can join the discussion.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
