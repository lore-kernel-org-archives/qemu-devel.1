Received: from eggs.gnu.org ([2001:4830:134:3::10]:38675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Cqx-0002iv-1M
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:56:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Cqt-0005vL-TP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:56:11 -0400
Received: from mail-qt0-x233.google.com ([2607:f8b0:400d:c0d::233]:38715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9Cqt-0005uz-Ot
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:56:07 -0400
Received: by mail-qt0-x233.google.com with SMTP id z23-v6so6527755qti.5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:56:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1524135103-30477-1-git-send-email-frederic.konrad@adacore.com>
	<a615d677-5c2f-831b-8b09-1b1abafa5159@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e2b58801-c13e-7a73-26ba-54ac7a5c7876@amsat.org>
Date: Thu, 19 Apr 2018 13:56:03 -0300
MIME-Version: 1.0
In-Reply-To: <a615d677-5c2f-831b-8b09-1b1abafa5159@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] riscv: requires libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mjc@sifive.com, palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de

> On 04/19/2018 12:51 PM, KONRAD Frederic wrote:
>> When compiling on a machine without libfdt installed the configure script
>> should try to get libfdt from the git or should die because otherwise
>> CONFIG_LIBFDT is not set and the build process end in an error in the
>> link
>> phase.. eg:
>>
>> hw/riscv/virt.o: In function `riscv_virt_board_init':
>> qemu/src/hw/riscv/virt.c:317: undefined reference to
>> `qemu_fdt_setprop_cell'
>> qemu/src/hw/riscv/virt.c:319: undefined reference to
>> `qemu_fdt_setprop_cell'
>> qemu/src/hw/riscv/virt.c:345: undefined reference to `qemu_fdt_dumpdtb'
>> collect2: error: ld returned 1 exit status
>> make[1]: *** [qemu-system-riscv64] Error 1
>> make: *** [subdir-riscv64-softmmu] Error 2
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   configure | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 0a19b03..1587f08 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3732,7 +3732,7 @@ fi
>>   fdt_required=no
>>   for target in $target_list; do
>>     case $target in
>> -   
>> aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
>>
>> +   
>> aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv64-softmmu)
>>
> 
> I just realized that riscv32 use it too so I'll correct with
> riscv*-softmmu.

Using "riscv*-softmmu":

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>         fdt_required=yes
>>       ;;
>>     esac
>>
> 
