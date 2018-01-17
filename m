Received: from eggs.gnu.org ([2001:4830:134:3::10]:39787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebqOJ-0007xN-Jp
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ebqOG-0004Ls-Bv
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:16:43 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:60621)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ebqOG-0004Kl-2m
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:16:40 -0500
References: <20180116222212.1266-1-laurent@vivier.eu>
	<20180117164950.3c818541@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7b35a1bc-e7ce-4a8a-e71e-1ffaa6aff010@vivier.eu>
Date: Wed, 17 Jan 2018 17:15:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180117164950.3c818541@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] linux-user: select CPU type
 according ELF header values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, YunQiang Su <syq@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aaron Sierra <asierra@xes-inc.com>

Le 17/01/2018 à 16:49, Igor Mammedov a écrit :
> On Tue, 16 Jan 2018 23:22:08 +0100
> Laurent Vivier <laurent@vivier.eu> wrote:
> 
>> This idea has been suggested to me before by Philippe
>> Mathieu-Daudé, and recently YunQiang Su has proposed a
>> patch to manage the MIPS r6 case.
>>
>> Based on this, this series tries to clean-up the original
>> patch, and introduces the use for m68k architecture and
>> port the patch from YunQiang Su.
>>
>> v3: fix code indent problem reported by patchew
>>     remove useless "!= 0"
>>     check for EF_M68K_M68000
>>     add EF_M68K_* flags in elf.h
>>     set 680x0 default CPU to m68040
>>     change "#if ... #endif" structure for ppc
>> v2: move cpu_model selection to linux-user/*/target_elf.h
>>     provide eflags to cpu_get_model() instead of fd
>>     (and modify other patches accordingly)
> Sorry for not noticing it earlier, but could you please
> fix series to use cpu type names instead of cpu_model?
> 
> I've just posted series that completes cpu_model refactoring
>   [PATCH 00/24] generalize parsing of cpu_model (part 4)
> which removes remnants of the code using cpu_model to
> instantiate CPUs, including reworking how default
> cpu type for *-user is picked up.
> 
> After that cpu_model shouldn't be used anywhere in the code
> except of routines that process "-cpu" CLI and cpu types
> should be used directly.
> 
> So you might not need 1/4 after that or it would have
> to be reworked and probably other patches where where
> cpu_model is used.

If I understand correctly, in linux-user/main.c we have to use
cpu_create() instead of cpu_init(), and provide the cpu_type instead of
the cpu_model?

In linux-user/main.c, How can I detect we want to use the default one
(we were relying on "cpu_model == NULL" until now) to be able to compute
the default one from the ELF header?

Thanks,
Laurent
