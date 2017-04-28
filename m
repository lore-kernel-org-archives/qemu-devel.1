Received: from eggs.gnu.org ([2001:4830:134:3::10]:46006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d43CC-0000ph-2s
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d43C7-0004Zz-6t
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:32:16 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33525)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d43C6-0004ZO-Uo
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 06:32:11 -0400
Received: by mail-wr0-x22e.google.com with SMTP id w50so31373952wrc.0
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 03:32:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170427120006.20564-1-rth@twiddle.net>
	<20170427120006.20564-6-rth@twiddle.net> <87wpa47rlx.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e700d913-2c0f-7e3b-dc81-25442b50f942@twiddle.net>
Date: Fri, 28 Apr 2017 12:32:06 +0200
MIME-Version: 1.0
In-Reply-To: <87wpa47rlx.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/19] tcg-runtime: add lookup_tb_ptr
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, cota@braap.org

On 04/28/2017 12:29 PM, Alex Bennée wrote:
>> +    return tcg_ctx.code_gen_epilogue;
> 
> Minor comments: I did notice is given we rely on the backends to set this up
> in later patches if it is worth adding an assert (or tcg_debug_assert?)
> to catch this early if a new backend doesn't set this up?

Sure, I can check for this in tcg_prologue_init and a faulty backend will die 
very early.


r~
