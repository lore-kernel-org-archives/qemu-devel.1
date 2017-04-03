Received: from eggs.gnu.org ([2001:4830:134:3::10]:49676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv1CD-0004o2-1H
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv1CC-0004Xy-1H
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:34:56 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34442)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv1CB-0004Xp-Qn
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 08:34:55 -0400
Received: by mail-wr0-x236.google.com with SMTP id l43so169409323wre.1
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 05:34:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <421c5729-f0d2-1c1b-bbd0-ebeb5584e082@twiddle.net>
References: <1490630670-15818-1-git-send-email-peter.maydell@linaro.org>
	<421c5729-f0d2-1c1b-bbd0-ebeb5584e082@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 13:34:34 +0100
Message-ID: <CAFEAcA-ZyNpFm35qajdFwZzfoQj5_R6owbPU+ZR0mz7GT==BVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] tcg/sparc: zero extend ld/st
 helper args
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 28 March 2017 at 00:35, Richard Henderson <rth@twiddle.net> wrote:
> On 03/28/2017 02:04 AM, Peter Maydell wrote:
>>
>> These patches fix problems with the SPARC TCG backend code
>> which calls the load and store helpers. Where the argument
>> being passed to the helper is narrower than the size of the
>> native register, the SPARC calling convention requires that
>> we extend it to the register size, but we weren't doing that.
>> This meant we passed the host code registers which might have
>> garbage in the high parts, and if the host code was built
>> with optimization this resulted in wrong behaviour.
>>
>> I still see problems trying to run the bits of 'make check'
>> that run guest code, but at least with these patches we can
>> run the i386 bios code enough to try to do PXE boot and not
>> find a server.
>>
>>
>> Peter Maydell (2):
>>   tcg/sparc: Zero extend data argument to store helpers
>>   tcg/sparc: Zero extend address argument to ld/st helpers
>>
>>  tcg/sparc/tcg-target.inc.c | 31 +++++++++++++++++++++++++++++--
>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>
>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Applied to master, thanks.

(PS: your mail system seems to have sat on your reviewed-by
email for the best part of a week.)

thanks
-- PMM
