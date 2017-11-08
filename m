Received: from eggs.gnu.org ([2001:4830:134:3::10]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCXnC-0007wv-DW
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eCXn9-0005yo-AC
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:21:50 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eCXn9-0005yN-3H
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 16:21:47 -0500
Received: by mail-wr0-x244.google.com with SMTP id 4so3715007wrt.0
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 13:21:47 -0800 (PST)
References: <1509993206-26637-1-git-send-email-peter.maydell@linaro.org>
	<1509993206-26637-4-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d40edc43-0420-79e9-9810-8ad88edf2742@linaro.org>
Date: Wed, 8 Nov 2017 22:21:43 +0100
MIME-Version: 1.0
In-Reply-To: <1509993206-26637-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] linux-user/sparc: Put address for data
 faults where linux-user expects it
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
> In the user-mode-only version of sparc_cpu_handle_mmu_fault(),
> we must save the fault address for a data fault into the CPU
> state's mmu registers, because the code in linux-user/main.c
> expects to find it there in order to populate the si_addr
> field of the guest siginfo.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/sparc/mmu_helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
