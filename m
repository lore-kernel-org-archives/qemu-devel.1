Received: from eggs.gnu.org ([2001:4830:134:3::10]:44933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fg6sA-0004WG-TH
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fg6s6-0004VG-V8
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:13:26 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:39494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fg6s6-0004Uz-Nd
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:13:22 -0400
Received: by mail-pf0-x242.google.com with SMTP id j8-v6so3765623pff.6
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 04:13:22 -0700 (PDT)
References: <20180718200648.22529-1-richard.henderson@linaro.org>
	<a1b59157-55d7-5f1a-72eb-8be11d8f7829@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ab1917a5-4fcc-25a6-00da-139fe7b9e753@linaro.org>
Date: Thu, 19 Jul 2018 04:13:18 -0700
MIME-Version: 1.0
In-Reply-To: <a1b59157-55d7-5f1a-72eb-8be11d8f7829@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/ppc: Implement swapcontext
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, alex.bennee@linaro.org, laurent@vivier.eu, david@gibson.dropbear.id.au

On 07/18/2018 03:56 PM, Philippe Mathieu-Daudé wrote:
>> +
>> +/* This syscall implements {get,set,swap}context for userland.  */
> 
> This comment confuses me because do_setcontext() is available at line 625.

But that's not wired up as a syscall.

>> +    /* For ppc32, ctx_size is "reserved for future use".
>> +     * For ppc64, we do not yet support the VSX extension.
>> +     */
>> +    if (ctx_size < sizeof(struct target_ucontext)) {
>> +        return -TARGET_EINVAL;
> 
> Shouldn't this be -TARGET_ENOMEM?
> 
> swapcontext(3):
> ERRORS
>        ENOMEM Insufficient stack space left.

No.  Please compare against the syscall, not the libc interface.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/signal_32.c#n1045


r~
