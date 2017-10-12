Received: from eggs.gnu.org ([2001:4830:134:3::10]:47073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2ek0-0004nf-71
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2ejv-0008AJ-CC
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:45:40 -0400
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:45190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2ejv-000878-6V
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 10:45:35 -0400
Received: by mail-pf0-x232.google.com with SMTP id d28so5141537pfe.2
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 07:45:33 -0700 (PDT)
References: <20171010214540.30970-1-richard.henderson@linaro.org>
	<87k200sw7c.fsf@frigg.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <888cfe83-7c47-5673-7b1b-8280cc50d8ba@linaro.org>
Date: Thu, 12 Oct 2017 07:45:30 -0700
MIME-Version: 1.0
In-Reply-To: <87k200sw7c.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: Initialize cpu_env generically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 10/11/2017 11:43 PM, Lluís Vilanova wrote:
>>      /* Track which vCPU triggers events */
>>      CPUState *cpu;                      /* *_trans */
>> -    TCGv_env tcg_env;                   /* *_exec  */
> 
> I would rather keep it here instead of making a new global variable, since that
> should make it easier in the future to have multiple translation contexts.

Why do you believe this prevents it?  The variable is literally identical for
*all* targets.


r~

PS: Everyone, please trim context that you don't care about.  If you just add
two lines in the middle of 1000, I'll not always find it.
