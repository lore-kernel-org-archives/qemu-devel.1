Received: from eggs.gnu.org ([2001:4830:134:3::10]:38141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCXkU-0006Qp-S7
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:19:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCXkR-0004BJ-OF
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:19:02 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:44131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eCXkR-0004Al-Gd
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:18:59 -0500
Received: by mail-wr0-x243.google.com with SMTP id u97so3714988wrc.1
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 13:18:59 -0800 (PST)
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d78560d-750c-929d-d3eb-e762a0b31b78@linaro.org>
Date: Wed, 8 Nov 2017 22:18:55 +0100
MIME-Version: 1.0
In-Reply-To: <1509993206-26637-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] linux-user/s390x: Mask si_addr for
 SIGSEGV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 11/06/2017 07:33 PM, Peter Maydell wrote:
> For s390x, the address passed to a signal handler in the
> siginfo_t si_addr field is masked (in the kernel this is done in
> do_sigbus() and do_sigsegv() in arch/s390/mm/fault.c). Implement
> this architecture-specific oddity in linux-user.
> 
> This is one of the issues described in
> https://bugs.launchpad.net/qemu/+bug/1705118
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Accurate, but really seems like a s390x kernel bug.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
