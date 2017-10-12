Received: from eggs.gnu.org ([2001:4830:134:3::10]:46569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2kfF-0007SJ-2M
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e2kfB-00044e-3y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:05:09 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:54065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e2kfA-00044T-Tu
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 17:05:05 -0400
Received: by mail-pf0-x230.google.com with SMTP id t188so4130328pfd.10
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 14:05:04 -0700 (PDT)
References: <20171010214540.30970-1-richard.henderson@linaro.org>
	<87k200sw7c.fsf@frigg.lan>
	<888cfe83-7c47-5673-7b1b-8280cc50d8ba@linaro.org>
	<87vajkgl94.fsf@frigg.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4c72bbf8-f8d9-95ca-b3b2-48da2a6ef86a@linaro.org>
Date: Thu, 12 Oct 2017 14:05:01 -0700
MIME-Version: 1.0
In-Reply-To: <87vajkgl94.fsf@frigg.lan>
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

On 10/12/2017 01:32 PM, Lluís Vilanova wrote:
> Richard Henderson writes:
> 
>> On 10/11/2017 11:43 PM, Lluís Vilanova wrote:
>>>> /* Track which vCPU triggers events */
>>>> CPUState *cpu;                      /* *_trans */
>>>> -    TCGv_env tcg_env;                   /* *_exec  */
>>>
>>> I would rather keep it here instead of making a new global variable, since that
>>> should make it easier in the future to have multiple translation contexts.
> 
>> Why do you believe this prevents it?  The variable is literally identical for
>> *all* targets.
> 
> If someone decides to make tcg_ctx thread-local or have one per target
> architecture (supporting multiple target archs concurrently), having all that
> info on the tcg_ctx object is easier to track and modify, compared to having
> multiple global variables.

We have patches on-list that do exactly this, from Emilio Cota.  I'm in the
process of reviewing them now.

We've made sure that patch set works with the cpu_* global variables created
once within target/*/translate.c.  This one is no different.


r~
