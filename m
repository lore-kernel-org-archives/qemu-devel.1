Received: from eggs.gnu.org ([2001:4830:134:3::10]:39530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW2av-0002n1-A0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW2aq-0002jF-Ej
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:33:29 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35481)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dW2aq-0002j0-BH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:33:24 -0400
Received: by mail-qt0-x244.google.com with SMTP id w12so10344872qta.2
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 08:33:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
	<1499238885-26161-25-git-send-email-pbonzini@redhat.com>
	<d42dd796-70c1-55c9-ff6c-9318b7d2a33a@amsat.org>
	<1724026964.16491421.1500022952979.JavaMail.zimbra@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <401a360f-72ef-ec24-40bf-b15b5ec9a690@amsat.org>
Date: Fri, 14 Jul 2017 12:33:20 -0300
MIME-Version: 1.0
In-Reply-To: <1724026964.16491421.1500022952979.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 24/42] configure: add --disable-tcg
 configure option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Anthony Liguori <aliguori@us.ibm.com>

On 07/14/2017 06:02 AM, Paolo Bonzini wrote:
>> From: "Philippe Mathieu-Daudé" <f4bug@amsat.org>
>> To: "Paolo Bonzini" <pbonzini@redhat.com>, qemu-devel@nongnu.org
>> Cc: "Anthony Liguori" <aliguori@us.ibm.com>
>> Sent: Friday, July 14, 2017 7:24:29 AM
>> Subject: Re: [Qemu-devel] [PULL 24/42] configure: add --disable-tcg configure option
>>
>> Hi Paolo,
>>
>> trying "./configure --disable-docs --disable-tcg" I get:
>>
>>     CC      x86_64-softmmu/exec.o
>> qemu/exec.c: In function ‘breakpoint_invalidate’:
>> qemu/exec.c:797:9: error: implicit declaration of function
>> ‘tb_invalidate_phys_addr’ [-Werror=implicit-function-declaration]
>>            tb_invalidate_phys_addr(cpu->cpu_ases[asidx].as,
>>            ^~~~~~~~~~~~~~~~~~~~~~~
>> qemu/exec.c:797:9: error: nested extern declaration of
>> ‘tb_invalidate_phys_addr’ [-Werror=nested-externs]
>> cc1: all warnings being treated as errors
>> qemu/rules.mak:66: recipe for target 'exec.o' failed
>> make[1]: *** [exec.o] Error 1
>> Makefile:328: recipe for target 'subdir-x86_64-softmmu' failed
>> make: *** [subdir-x86_64-softmmu] Error 2
>>
>> due to include/exec/exec-all.h:
>>
>> #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>> void tb_invalidate_phys_addr(AddressSpace *as, hwaddr addr);
>> #else
> 
> This is introduced by Pranith's patch.  I will respin my pull request.
> 
> Paolo

I pulled master with your PR merged and it now compiles fine, thank you.
