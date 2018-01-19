Received: from eggs.gnu.org ([2001:4830:134:3::10]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecXAU-0004MC-6r
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ecXAP-0004GB-9Z
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:18 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ecXAO-0004F8-Vy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:57:13 -0500
References: <20180116222212.1266-1-laurent@vivier.eu>
	<20180117164950.3c818541@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <41ae7321-c370-84ec-97ec-bd065cef2a61@vivier.eu>
Date: Fri, 19 Jan 2018 14:56:53 +0100
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

As your series is not ready for inclusion, perhaps we can take my series
first?

I'll happily help you to adapt your series on top of this one if you need.

Thanks,
Laurent
