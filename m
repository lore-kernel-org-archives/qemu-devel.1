Received: from eggs.gnu.org ([2001:4830:134:3::10]:52611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fB3IL-0007pZ-SS
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fB3IK-00032Z-Q0
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:08:05 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fB3IK-00032A-Ks
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:08:04 -0400
Received: by mail-oi0-x242.google.com with SMTP id n65-v6so18708696oig.6
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 12:08:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <mhng-b0d36032-c147-44ea-82ec-8ff808359cbf@palmer-si-x1c4>
References: <20180424160329.8089-1-alex.bennee@linaro.org>
	<mhng-b0d36032-c147-44ea-82ec-8ff808359cbf@palmer-si-x1c4>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Apr 2018 20:07:43 +0100
Message-ID: <CAFEAcA9EiOnd1Eo89P_H6cC5Yp81eUPes6Cv+-xEZtYZuzJXHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: set minimum uname for RISC-V
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>, Michael Clark <mjc@sifive.com>

On 24 April 2018 at 17:40, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Tue, 24 Apr 2018 09:03:29 PDT (-0700), alex.bennee@linaro.org wrote:
>>
>> As support was merged into the mainline kernel at 4.15 it is unlikely
>> 3.8.0 is the correct value. Indeed when I testing binaries created by
>> the current Debian SID compiler the tests failed with:
>>
>>   FATAL: kernel too old
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  linux-user/riscv/target_syscall.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/riscv/target_syscall.h
>> b/linux-user/riscv/target_syscall.h
>> index d4e109a27f..ee81d8bc88 100644
>> --- a/linux-user/riscv/target_syscall.h
>> +++ b/linux-user/riscv/target_syscall.h
>> @@ -45,7 +45,7 @@ struct target_pt_regs {
>>  #else
>>  #define UNAME_MACHINE "riscv64"
>>  #endif
>> -#define UNAME_MINIMUM_RELEASE "3.8.0"
>> +#define UNAME_MINIMUM_RELEASE "4.15.0"
>>
>>  #define TARGET_MINSIGSTKSZ 2048
>>  #define TARGET_MLOCKALL_MCL_CURRENT 1
>
>
> If I understand this correctly, this will make host kernels older than
> 4.15.0 look like 4.15.0 when a program running in user-mode emulation on =
a
> RISC-V system?

Yes. Typically you want to set this to whatever glibc has
baked in as its arch_minimum_kernel, which in this case
does seem to be 4.15.0:

https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv/li=
nux/riscv/configure.ac;h=3D4fae013ec91451370a6d14b15b7e6d37fcd669af;hb=3DHE=
AD

thanks
-- PMM
