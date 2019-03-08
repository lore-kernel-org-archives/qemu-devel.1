Received: from eggs.gnu.org ([209.51.188.92]:49774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2I5a-00080w-Fm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h2I5Y-00017a-II
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:11:13 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h2I5V-00012G-0m
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 11:11:10 -0500
Received: by mail-pg1-x542.google.com with SMTP id e17so14507559pgd.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 08:11:05 -0800 (PST)
References: <20190307201244.8971-1-richard.henderson@linaro.org>
	<CAFEAcA86PA-VOZ+o=PZ8b4ZM-zrLjp4gK1PiR5AEWzjPddCshw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <930c298a-2b3d-9fab-abf7-369db1ec5c2d@linaro.org>
Date: Fri, 8 Mar 2019 08:11:00 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA86PA-VOZ+o=PZ8b4ZM-zrLjp4gK1PiR5AEWzjPddCshw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: gdbstub system registers
 refinement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3/8/19 7:59 AM, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 20:12, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> This was working toward fixing
>>
>>   https://bugs.linaro.org/show_bug.cgi?id=4274
>>
>> although I don't think I'm entirely successful.  I would argue,
>> however, that gdb's behaviour in this is odd.  Why are registers
>> that are clearly marked "system" being added to "general" simply
>> because they have integer type?
> 
> Yeah, this does seem to me like it might be a bug on
> gdb's end -- are you following up with them?

Yes.


r~
