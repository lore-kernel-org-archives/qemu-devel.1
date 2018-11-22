Received: from eggs.gnu.org ([2001:4830:134:3::10]:52061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPe3G-0004lj-Uq
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 20:45:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gPe3C-000058-C9
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 20:45:06 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:32824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gPe3C-0008VA-4A
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 20:45:02 -0500
Received: by mail-pl1-x644.google.com with SMTP id z23so8016382plo.0
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 17:45:02 -0800 (PST)
Date: Wed, 21 Nov 2018 17:44:59 -0800 (PST)
In-Reply-To: <201f1cf4-30af-03c5-393b-0eab6ac7eb87@redhat.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-ce1dc513-eb34-4ace-b3a2-248347025887@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] MAINTAINERS: Any file with
 "riscv" in the name is a RISC-V file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: philmd@redhat.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org

On Wed, 21 Nov 2018 16:29:09 PST (-0800), philmd@redhat.com wrote:
> On 22/11/18 0:46, Palmer Dabbelt wrote:
>> There was a recent thread about unmaintained files in QEMU where it was
>> noted that a few RISC-V related files had slipped through the patterns
>> in our MAINTAINERS file entry.  This patch adds some more aggressive
>> pattern matching in an attempt to rectify this situation.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>   MAINTAINERS | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1032406c5607..e89adc81d5d5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -255,6 +255,8 @@ F: target/riscv/
>>   F: hw/riscv/
>>   F: include/hw/riscv/
>>   F: disas/riscv.c
>> +K: riscv
>> +N: riscv
>
> QEMU doesn't support the 'N' tag.
> I see from the Linux kernel:
>
>    N: Files and directories with regex patterns.
>       N:   [^a-z]tegra     all files whose path contains the word tegra
>       One pattern per line.  Multiple N: lines acceptable.
>       scripts/get_maintainer.pl has different behavior for files that
>       match F: pattern and matches of N: patterns.  By default,
>       get_maintainer will not look at git log history when an F: pattern
>       match occurs.  When an N: match occurs, git log history is used
>       to also notify the people that have git commit signatures.
>
> Should we add this feature to checkscript?

Ah, I didn't check because I just copied this from our Linux entry.  It's 
pretty much the core of what I'm trying to do here so if it's easy then that'd 
be great.

Unfortunately I don't know how to do so.

>
>>
>>   S390
>>   M: Richard Henderson <rth@twiddle.net>
>>
