Received: from eggs.gnu.org ([2001:4830:134:3::10]:44178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cR1Px-0006bO-HI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cR1Pw-0002lT-IE
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:45:09 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:36314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cR1Pw-0002l5-Bs
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 13:45:08 -0500
Received: by mail-io0-x244.google.com with SMTP id q20so12349613ioi.3
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 10:45:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <cd817ab9-fd77-f52c-5ee7-7502b68959cb@greensocs.com>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
	<cd817ab9-fd77-f52c-5ee7-7502b68959cb@greensocs.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 10 Jan 2017 10:45:06 -0800
Message-ID: <CAMo8Bf+sZ_5N_ozXkoq3+Kfi18RDnNAvBpZTg0tG5NyWQF_bkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] implementing architectural timers using QEMU timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frederic Konrad <fred.konrad@greensocs.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>, Alex Bligh <alex@alex.org.uk>, Richard Henderson <rth@twiddle.net>

On Tue, Jan 10, 2017 at 1:10 AM, Frederic Konrad
<fred.konrad@greensocs.com> wrote:
> On 01/09/2017 04:18 PM, Max Filippov wrote:
>> I'm trying to reimplement xtensa CCOUNT (cycle counter) and
>> CCOMPARE (CCOUNT-based timer interrupts) using QEMU
>> timers. That is CCOUNT value is derived from the
>> QEMU_CLOCK_VIRTUAL clock and CCOMPARE interrupts are
>> generated from the QEMU_CLOCK_VIRTUAL timer callbacks.
>> The code is here:
>>   https://github.com/OSLL/qemu-xtensa/commits/xtensa-ccount
>>
>> I've got the following issues doing that:
>>
>> - I thought that could be improved in -icount mode, so I tried that.
>>   It is better with -icount, but it's still not 100% accurate. That is
>>   I was able to observe guest reading QEMU clock value that is
>>   past QEMU timer deadline before that timer callback was
>>   invoked.
>>
>>   That sounds like a bug to me, is it?
>
> Did you try "sleep" icount option?
>
> eg:
> -icount 1,sleep=off

That doesn't seem to change anything.

-- 
Thanks.
-- Max
