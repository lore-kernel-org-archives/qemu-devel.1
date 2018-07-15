Received: from eggs.gnu.org ([2001:4830:134:3::10]:37608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1feV2J-0003a4-Jr
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 20:37:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1feV2G-0002nw-1V
	for qemu-devel@nongnu.org; Sat, 14 Jul 2018 20:37:15 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180713150945.12348-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5c3ec438-2265-94b4-4f35-71a79d838518@twiddle.net>
Date: Sat, 14 Jul 2018 19:37:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180713150945.12348-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Check whether TLB entry is RAM
 consistently with how we set it up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 07/13/2018 10:09 AM, Peter Maydell wrote:
> @@ -939,29 +935,21 @@ tb_page_addr_t get_page_addr_code(CPUArchState *env, target_ulong addr)
>          }
>          assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));
>      }
> +    assert(tlb_hit(env->tlb_table[mmu_idx][index].addr_code, addr));

Don't duplicate the assert; just move it.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
