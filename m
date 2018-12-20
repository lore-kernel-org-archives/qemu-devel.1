Received: from eggs.gnu.org ([2001:4830:134:3::10]:44930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga5ev-0003H7-Hd
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 16:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ga5er-0001dB-7p
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 16:15:09 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:33952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ga5eq-0001ag-Ha
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 16:15:05 -0500
Received: by mail-pf1-x42f.google.com with SMTP id h3so1511350pfg.1
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 13:15:03 -0800 (PST)
References: <20181220201502.12285-1-richard.henderson@linaro.org>
	<CAFEAcA8G8Yi=j1G70vspSFm57AsLbNsm07yxPmwaJgWPJFtu4w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1702ffa1-33cb-d07b-1992-009cdcb381d8@linaro.org>
Date: Thu, 20 Dec 2018 13:14:59 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8G8Yi=j1G70vspSFm57AsLbNsm07yxPmwaJgWPJFtu4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add safe_syscall for riscv64
 host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Laurent Vivier <laurent@vivier.eu>

On 12/20/18 12:40 PM, Peter Maydell wrote:
> On Thu, 20 Dec 2018 at 20:16, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> At some point we should make this routine be non-optional for
>> porting to a new host.
> 
> Yes, I agree -- how many hosts do we still have which are
> missing support for it?

Ignoring tci, mips (3 abis), ppc32, sparc (2 abis).


r~
