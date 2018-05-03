Received: from eggs.gnu.org ([2001:4830:134:3::10]:33696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEICT-0001dd-46
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:39:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fEICQ-0004xl-2I
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:39:25 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:43055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fEICP-0004xP-SF
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:39:21 -0400
Received: by mail-pf0-x22f.google.com with SMTP id j20so972708pff.10
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 10:39:21 -0700 (PDT)
References: <20180427002651.28356-1-richard.henderson@linaro.org>
	<20180427002651.28356-5-richard.henderson@linaro.org>
	<CAFEAcA-wq3kasUe8pkdUJXNJYNnLABrPgeQE4fokSLL995SFkg@mail.gmail.com>
	<1ad8ffc6-5549-99bf-940f-6734c579e354@linaro.org>
	<CAFEAcA_gPP80BdfhExzHksJyf5KhbQtMH=bGypW4C9uy=fm9jg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <41757507-1fff-e28e-9847-5e1a28d3b7ca@linaro.org>
Date: Thu, 3 May 2018 10:39:17 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_gPP80BdfhExzHksJyf5KhbQtMH=bGypW4C9uy=fm9jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/9] tcg: Introduce atomic
 helpers for integer min/max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 05/03/2018 10:26 AM, Peter Maydell wrote:
>> It won't be compiled for the 32-bit host.  Translation will not attempt to use
>> this helper and will instead call exit_atomic.
> 
> OK. Can you point me at the code that handles min/max atomics in that case?

exit_atomic raises EXP_ATOMIC, which leads to cpu_exec_step_atomic, which grabs
the exclusive lock and then executes the operation in a serial context.  This
is expanded inline via do_nonatomic_op_i64.


r~
