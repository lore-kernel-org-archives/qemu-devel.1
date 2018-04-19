Received: from eggs.gnu.org ([2001:4830:134:3::10]:33123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f98I3-0007E2-2i
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1f98Hy-0007sH-GG
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:03:51 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:43538
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1f98Hy-0007qQ-Af
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:03:46 -0400
References: <1524135103-30477-1-git-send-email-frederic.konrad@adacore.com>
	<403f225f-664b-7ff8-f042-3da56b7812a0@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <91f41cf5-3b41-4a2b-670f-6b4f3f988c4d@adacore.com>
Date: Thu, 19 Apr 2018 14:03:42 +0200
MIME-Version: 1.0
In-Reply-To: <403f225f-664b-7ff8-f042-3da56b7812a0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] riscv: requires libfdt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de, palmer@sifive.com, mjc@sifive.com



On 04/19/2018 02:00 PM, Paolo Bonzini wrote:
> On 19/04/2018 12:51, KONRAD Frederic wrote:
>> When compiling on a machine without libfdt installed the configure script
>> should try to get libfdt from the git or should die because otherwise
>> CONFIG_LIBFDT is not set and the build process end in an error in the link
>> phase.. eg:
>>
>> hw/riscv/virt.o: In function `riscv_virt_board_init':
>> qemu/src/hw/riscv/virt.c:317: undefined reference to `qemu_fdt_setprop_cell'
>> qemu/src/hw/riscv/virt.c:319: undefined reference to `qemu_fdt_setprop_cell'
>> qemu/src/hw/riscv/virt.c:345: undefined reference to `qemu_fdt_dumpdtb'
>> collect2: error: ld returned 1 exit status
>> make[1]: *** [qemu-system-riscv64] Error 1
>> make: *** [subdir-riscv64-softmmu] Error 2
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   configure | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index 0a19b03..1587f08 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3732,7 +3732,7 @@ fi
>>   fdt_required=no
>>   for target in $target_list; do
>>     case $target in
>> -    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
>> +    aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu|riscv64-softmmu)
>>         fdt_required=yes
>>       ;;
>>     esac
>>
> 
> Maybe good for 2.12, even though it would make the final rc and final
> release different?
> 
> Thanks,
> 
> Paolo
> 

On my side it doesn't matter much if it is 2.12 or 2.13, up to
you guys.

Thanks,
Fred
