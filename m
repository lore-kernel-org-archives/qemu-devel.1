Received: from eggs.gnu.org ([2001:4830:134:3::10]:48592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eJhJ2-00040s-W5
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eJhIt-00035g-Ll
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:56:12 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eJhIt-00034f-FR
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 09:56:07 -0500
Received: by mail-wr0-x241.google.com with SMTP id w62so280956wrc.6
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 06:56:07 -0800 (PST)
References: <1511879725-9576-1-git-send-email-peter.maydell@linaro.org>
	<1511879725-9576-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <adb092cb-38c2-ccff-d8af-55dc89509287@linaro.org>
Date: Tue, 28 Nov 2017 14:55:58 +0000
MIME-Version: 1.0
In-Reply-To: <1511879725-9576-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] linux-user: Propagate siginfo_t
 through to handle_cpu_signal()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 11/28/2017 02:35 PM, Peter Maydell wrote:
> Currently all the architecture/OS specific cpu_signal_handler()
> functions call handle_cpu_signal() without passing it the
> siginfo_t. We're going to want that so we can look at the si_code
> to determine whether this is a SEGV_ACCERR access violation or
> some other kind of fault, so change the functions to pass through
> the pointer to the siginfo_t rather than just the si_addr value.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  accel/tcg/user-exec.c | 39 ++++++++++++++-------------------------
>  1 file changed, 14 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
