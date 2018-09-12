Received: from eggs.gnu.org ([2001:4830:134:3::10]:55576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g0BdE-00062q-FJ
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g0BdD-0002kw-QX
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:21:00 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g0BdD-0002kX-KH
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 16:20:59 -0400
Received: by mail-pl1-x641.google.com with SMTP id f66-v6so1502787plb.10
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 13:20:59 -0700 (PDT)
References: <20180830193019.20104-1-jancraig@amazon.com>
	<20180830193019.20104-6-jancraig@amazon.com>
	<BN7PR08MB48683D162B911B8944759A86C60F0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a92e4f0d-43b8-63cb-f650-9859c8e9dc11@linaro.org>
Date: Wed, 12 Sep 2018 13:20:55 -0700
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB48683D162B911B8944759A86C60F0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 5/9] target/mips: Add MXU instruction
 S8LDD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Craig Janeczek <jancraig@amazon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, Petar Jovanovic <pjovanovic@wavecomp.com>

On 08/31/2018 06:39 AM, Aleksandar Markovic wrote:
>> +    gen_load_mxu_cr(t0);
>> +    tcg_gen_andi_tl(t0, t0, MXUEN);
>> +    tcg_gen_brcondi_tl(TCG_COND_NE, t0, MXUEN, l0);
>> +
>> +    gen_load_gpr(t0, rb);
>> +    tcg_gen_addi_tl(t0, t0, (int8_t)s8);
> 
> I am not sure if this works as desired, with respect to branching. In order to survive branching, tcg variables must be initialized with tcg_temp_local_new(), rather than with tcg_tem_new(). Please retest, and amend if needed.

There is no value live across the branch here.

T0 is used before the branch, yes, but it is also reset
immediately via the gen_load_gpr after the branch.

This is fine.


r~
