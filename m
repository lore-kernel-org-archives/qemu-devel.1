Received: from eggs.gnu.org ([209.51.188.92]:35825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxCHr-0001MC-W3
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxC5f-0001qN-Ay
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:46:16 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxC5e-00009x-2W
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:46:15 -0500
Received: by mail-pl1-x642.google.com with SMTP id 101so1196962pld.6
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 06:45:23 -0800 (PST)
References: <20190222024106.9167-1-richard.henderson@linaro.org>
	<87r2bz3omk.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e1c6243f-538a-ee82-0139-d7beec764414@linaro.org>
Date: Fri, 22 Feb 2019 06:45:19 -0800
MIME-Version: 1.0
In-Reply-To: <87r2bz3omk.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org

On 2/22/19 6:05 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Changes since v2:
>>   * Do not cache VECLEN, VECSTRIDE, VFPEN.
>>     These variables come from VFP_FPSCR and VFP_FPEXC, not from
>>     system control registers.
>>   * Move HANDLER and STACKCHECK to rebuild_hflags_a32,
>>     instead of building them in rebuild_hflags_common.
>>
>> Changes since v1:
>>   * Apparently I had started a last-minute API change, and failed to
>>     covert all of the users, and also failed to re-test afterward.
>>   * Retain assertions for --enable-debug-tcg.
> 
> I thought I was being clever by running our armhf test binaries on a
> aarch64 image.

You and me both.  ;-P


r~
