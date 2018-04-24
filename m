Received: from eggs.gnu.org ([2001:4830:134:3::10]:33818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1fB3rX-0006C7-S7
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1fB3rT-0003s6-Mu
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:44:27 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:39231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1fB3rT-0003ro-Ez
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:44:23 -0400
Received: by mail-pg0-x241.google.com with SMTP id b9so11608826pgf.6
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 12:44:23 -0700 (PDT)
Date: Tue, 24 Apr 2018 12:44:21 -0700 (PDT)
In-Reply-To: <CAFEAcA9EiOnd1Eo89P_H6cC5Yp81eUPes6Cv+-xEZtYZuzJXHw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-a4d78fe3-1db1-43b5-a802-fb6ea9845481@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: set minimum uname for RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: alex.bennee@linaro.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, qemu-devel@nongnu.org, laurent@vivier.eu, Michael Clark <mjc@sifive.com>

On Tue, 24 Apr 2018 12:07:43 PDT (-0700), peter.maydell@linaro.org wrote:
> On 24 April 2018 at 17:40, Palmer Dabbelt <palmer@sifive.com> wrote:
>> On Tue, 24 Apr 2018 09:03:29 PDT (-0700), alex.bennee@linaro.org wrote:
>>>
>>> As support was merged into the mainline kernel at 4.15 it is unlikely
>>> 3.8.0 is the correct value. Indeed when I testing binaries created by
>>> the current Debian SID compiler the tests failed with:
>>>
>>>   FATAL: kernel too old
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> ---
>>>  linux-user/riscv/target_syscall.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/linux-user/riscv/target_syscall.h
>>> b/linux-user/riscv/target_syscall.h
>>> index d4e109a27f..ee81d8bc88 100644
>>> --- a/linux-user/riscv/target_syscall.h
>>> +++ b/linux-user/riscv/target_syscall.h
>>> @@ -45,7 +45,7 @@ struct target_pt_regs {
>>>  #else
>>>  #define UNAME_MACHINE "riscv64"
>>>  #endif
>>> -#define UNAME_MINIMUM_RELEASE "3.8.0"
>>> +#define UNAME_MINIMUM_RELEASE "4.15.0"
>>>
>>>  #define TARGET_MINSIGSTKSZ 2048
>>>  #define TARGET_MLOCKALL_MCL_CURRENT 1
>>
>>
>> If I understand this correctly, this will make host kernels older than
>> 4.15.0 look like 4.15.0 when a program running in user-mode emulation on a
>> RISC-V system?
>
> Yes. Typically you want to set this to whatever glibc has
> baked in as its arch_minimum_kernel, which in this case
> does seem to be 4.15.0:
>
> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/unix/sysv/linux/riscv/configure.ac;h=4fae013ec91451370a6d14b15b7e6d37fcd669af;hb=HEAD

Sounds good, thanks!
