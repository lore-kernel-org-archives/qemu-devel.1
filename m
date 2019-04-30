Received: from eggs.gnu.org ([209.51.188.92]:44371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLUdV-0004Oh-Lh
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLUdU-0007mM-Ow
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:25:37 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLUdU-0007kq-IF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:25:36 -0400
Received: by mail-pg1-x541.google.com with SMTP id n2so6976684pgg.13
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 08:25:35 -0700 (PDT)
References: <20190330005900.17282-1-richard.henderson@linaro.org>
	<20190330005900.17282-3-richard.henderson@linaro.org>
	<CAFEAcA98_q1yx==QkHO1HiJA8cJqGv8k5OrCU5W=dC3ZWNPY=w@mail.gmail.com>
	<920a0801-ed1d-23e8-9975-43d4d185707e@linaro.org>
	<CAFEAcA-=JyNF94OTq+rJRVxbfhJ_B6=fLm93s+y0ScX9Uyfngw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <257d3eea-409c-6d2e-2384-d56f93f8d393@linaro.org>
Date: Tue, 30 Apr 2019 08:25:28 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=JyNF94OTq+rJRVxbfhJ_B6=fLm93s+y0ScX9Uyfngw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/4] linux-user: Set PAGE_TARGET_1 for
 TARGET_PROT_BTI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On 4/30/19 3:40 AM, Peter Maydell wrote:
> On Mon, 29 Apr 2019 at 21:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 4/29/19 9:21 AM, Peter Maydell wrote:
>>> This looks ok code-wise, but we'd need to hide it behind
>>> a defaults-to-off x-something property if we wanted to
>>> commit it before the kernel ABI is fixed.
>>
>> I'm not intending to change the user-level abi, only the
>> internal abi within qemu, for handling of the elf notes.
> 
> You're changing target_mmap(), which is used by the
> guest mmap syscall, though, right?

Yes, but it's also used by elfload.c to map the executable.

> I think that we shouldn't allow guest binaries written
> to the ad-hoc TARGET_PROT_BTI ABI to work without an
> explicit x-something command line argument to QEMU...

The guest binary is not written to an ad-hoc abi.

It is written to the finalized ELF note abi, which
I am trying to implement with a *private* QEMU abi.


r~
