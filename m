Received: from eggs.gnu.org ([2001:4830:134:3::10]:54755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWPvQ-0006kn-Dn
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fWPvN-0000Kw-BE
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:32:44 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fWPvN-0000Kl-4A
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:32:41 -0400
Received: by mail-pf0-x242.google.com with SMTP id a63-v6so3541709pfl.1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 10:32:40 -0700 (PDT)
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-13-richard.henderson@linaro.org>
	<CAFEAcA_TvTydOEJOmfFA8x2vgRnd+Su8osz3hRuGabWtu5ybHA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <52957842-ffa0-93ed-e9e7-667fc6248f21@linaro.org>
Date: Fri, 22 Jun 2018 10:32:36 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TvTydOEJOmfFA8x2vgRnd+Su8osz3hRuGabWtu5ybHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/19] linux-user: Setup split syscall
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 06/22/2018 03:30 AM, Peter Maydell wrote:
>> +struct SyscallDef {
>> +    const char *name;
>> +    SyscallArgsFn *args;
>> +    SyscallImplFn *impl;
>> +    SyscallPrintFn *print;
>> +    SyscallPrintRetFn *print_ret;
> 
> Are all these hook functions mandatory, or can a syscall
> implementation leave some of them NULL for a default behaviour?

Only impl is mandatory.  You're right that there should be more doco here at
the structure definition.  Here, the docs got split down to the macros that
define the most common forms of the structures.  Will fix.


>>  static void
>>  print_flags(const struct flags *f, abi_long flags, int last)
>>  {
>> -    const char *sep = "";
>> -    int n;
>> +    char buf[256];
>> +    add_flags(buf, sizeof(buf), f, flags, false);
>> +    gemu_log("%s%s", buf, get_comma(last));
>> +}
> 
> All this refactoring of the strace functions feels like it
> should have been in a separate patch...

Fair.


r~
