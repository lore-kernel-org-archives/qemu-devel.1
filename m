Received: from eggs.gnu.org ([2001:4830:134:3::10]:51035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYzxP-0005fh-BD
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYzxM-0000mm-6a
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:25:27 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:40354)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYzxL-0000mD-Uk
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 16:25:24 -0400
Received: by mail-qt0-x243.google.com with SMTP id s47-v6so8980615qth.7
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:25:23 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1530270317-28612-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9zwR1b5qkjce0TcAKS245R7VWX9Kn2bQkCh-ab6=SG+A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <583fbddf-3fad-6ac5-c486-550b494e7df5@amsat.org>
Date: Fri, 29 Jun 2018 17:25:19 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zwR1b5qkjce0TcAKS245R7VWX9Kn2bQkCh-ab6=SG+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v3 00/60] Misc patches for soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/29/2018 03:03 PM, Peter Maydell wrote:
> On 29 June 2018 at 12:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The following changes since commit 4a83bf2f339d4b63ecd5ef48b9816c3b7ee24553:
>>
>>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180627' into staging (2018-06-28 15:31:42 +0100)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 28a3cfc10b2e1a34985797357b4aa7558a63d08f:
>>
>>   tests/boot-serial: Do not delete the output file in case of errors (2018-06-29 13:02:50 +0200)
>>
>> ----------------------------------------------------------------
>> * "info mtree" improvements (Alexey)
>> * fake VPD block limits for SCSI passthrough (Daniel Barboza)
>> * chardev and main loop fixes (Daniel Berrangé, Sergio, Stefan)
>> * help fixes (Eduardo)
>> * pc-dimm refactoring (David)
>> * tests improvements and fixes (Emilio, Thomas)
>> * SVM emulation fixes (Jan)
>> * MemoryRegionCache fix (Eric)
>> * WHPX improvements (Justin)
>> * ESP cleanup (Mark)
>> * -overcommit option (Michael)
>> * qemu-pr-helper fixes (me)
>> * "info pic" improvements for x86 (Peter)
>> * x86 TCG emulation fixes (Richard)
>> * KVM slot handling fix (Shannon)
>> * Next round of deprecation (Thomas)
>> * Windows dump format support (Viktor)
>>
> 
> Hi; looks like this broke the Travis --disable-tcg build:
> https://travis-ci.org/qemu/qemu/jobs/398262491
> 
> In file included from /home/travis/build/qemu/qemu/exec.c:62:0:
> /home/travis/build/qemu/qemu/include/exec/ram_addr.h:96:6: error:
> conflicting types for â€˜tb_invalidate_phys_rangeâ€™
>  void tb_invalidate_phys_range(ram_addr_t start, ram_addr_t end);
>       ^
> In file included from /home/travis/build/qemu/qemu/exec.c:24:0:
> /home/travis/build/qemu/qemu/include/exec/exec-all.h:309:6: note:
> previous declaration of â€˜tb_invalidate_phys_rangeâ€™ was here
>  void tb_invalidate_phys_range(target_ulong start, target_ulong end);
>       ^
> /home/travis/build/qemu/qemu/exec.c:1043:6: error: conflicting types
> for â€˜tb_invalidate_phys_addrâ€™
>  void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr, MemTxAttrs attrs)
>       ^
> In file included from /home/travis/build/qemu/qemu/exec.c:24:0:
> /home/travis/build/qemu/qemu/include/exec/exec-all.h:308:6: note:
> previous declaration of â€˜tb_invalidate_phys_addrâ€™ was here
>  void tb_invalidate_phys_addr(target_ulong addr);
>       ^
> 
> (with apologies for the smartquote damage).
> 
> Could you have a look, please?

I just sent a patch for this:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg09072.html
