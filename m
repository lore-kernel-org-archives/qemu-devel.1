Received: from eggs.gnu.org ([2001:4830:134:3::10]:54467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoZ4c-0008GE-Pn
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eoZ4Z-00066D-Bf
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:24:58 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eoZ4Z-00064y-2h
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 13:24:55 -0500
Received: by mail-pg0-x241.google.com with SMTP id m19so970772pgn.1
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 10:24:54 -0800 (PST)
References: <1518917557-12063-1-git-send-email-cota@braap.org>
	<1518917557-12063-3-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54616771-52da-95b3-f4b8-c4b59c4bae3a@linaro.org>
Date: Wed, 21 Feb 2018 10:24:51 -0800
MIME-Version: 1.0
In-Reply-To: <1518917557-12063-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] target/openrisc: convert to
 TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>

On 02/17/2018 05:32 PM, Emilio G. Cota wrote:
> +    dc->next_page_start = (dc->base.pc_first & TARGET_PAGE_MASK) +
> +        TARGET_PAGE_SIZE;
> +    return max_insns;

OpenRISC is standard 4-byte risc insn; should use the same bound mechanism as
ppc and sparc.


r~
