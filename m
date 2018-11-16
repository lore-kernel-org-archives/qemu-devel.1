Received: from eggs.gnu.org ([2001:4830:134:3::10]:60466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZAT-0003wc-O9
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNZAQ-0000R0-NP
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:07:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:34239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNZAQ-0000Nv-Ac
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 03:07:54 -0500
Received: by mail-wr1-x441.google.com with SMTP id j26-v6so23868604wre.1
	for <qemu-devel@nongnu.org>; Fri, 16 Nov 2018 00:07:54 -0800 (PST)
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
	<20181115184827.GA12024@flamenco>
	<06e66024-1abb-e5b7-591c-3633b5cb3e31@linaro.org>
	<20181116011338.GB17566@flamenco> <20181116051040.GA25165@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <00eece57-cd7d-f4da-c3ec-6bcfbf82b2f2@linaro.org>
Date: Fri, 16 Nov 2018 09:07:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181116051040.GA25165@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 11/16/18 6:10 AM, Emilio G. Cota wrote:
> It's possible that newer machines with larger reorder buffers
> will be able to take better advantage of the higher instruction
> locality, hiding the latency of having to execute more instructions.
> I'll test on Skylake tomorrow.

I've noticed that the code we generate for calls has twice as many instructions
as really needed for setting up the arguments.  I have a plan to fix that,
which hopefully will solve this problem.


r~
