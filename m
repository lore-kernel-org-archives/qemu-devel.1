Received: from eggs.gnu.org ([2001:4830:134:3::10]:38243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnRC-0006vp-6n
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:11:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnR8-0002Ap-5V
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:11:22 -0500
References: <20181207085635.4291-1-mark.cave-ayland@ilande.co.uk>
	<CAL1e-=jWJ_kzwrC4nkt-UQnHXh5y-i5NF0N0ToXj534ehkuGOQ@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <80a38f38-6384-1f8c-e8c1-c38b346e4f6a@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:11:08 +0000
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jWJ_kzwrC4nkt-UQnHXh5y-i5NF0N0ToXj534ehkuGOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/6] target/ppc: convert VMX
 instructions to use TCG vector operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: richard.henderson@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 10/12/2018 13:04, Aleksandar Markovic wrote:

> On Dec 7, 2018 9:59 AM, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
> wrote:
>>
>> This patchset is an attempt at trying to improve the VMX (Altivec)
> instruction
>> performance by making use of the new TCG vector operations where possible.
>>
> 
> Hello, Mark.
> 
> I just want to say that I support these efforts. Very interesting, it can
> bring significant improvements for multimedia intensive emulations. But,
> even more important, we can see new tcg vector interface in action,
> possibly suggest improvements, extensions.
> 
> I would just like to ask you to add some performance comparisons, if
> possible. Very simple tests would be sufficient.
> 
> Thanks again for this series!

Thanks Aleksander! In my local tests I haven't done much in the way of benchmarking,
other than to check the output of the disassembler to confirm that the x86 vector
opcodes are being used. Given that only a small number of TCG vector operations are
currently suitable for use with the VMX code, then I would expect certain artificial
benchmarks to show improvements e.g. with the logical ops but there was certainly
nothing noticeable in normal usage with my OpenBIOS test images.

I agree with you that having a second implementation other than ARM will help provide
ideas as to how the vector interfaces can be evolved to support more operations in
future.


ATB,

Mark.
