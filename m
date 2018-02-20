Received: from eggs.gnu.org ([2001:4830:134:3::10]:43490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eo3zd-0002Nx-Kz
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eo3zZ-0002zI-J8
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:13:45 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:57045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eo3zZ-0002yB-8g
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:13:41 -0500
References: <20180219171037.24539-1-laurent@vivier.eu>
	<CAFEAcA-W+xQMov2=WHPYwh_EVFiaW+8D+0VWB2T6kJ6Bo_xLFw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3d677b9c-d3aa-d34f-d6fc-48625bd1f77a@vivier.eu>
Date: Tue, 20 Feb 2018 10:13:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-W+xQMov2=WHPYwh_EVFiaW+8D+0VWB2T6kJ6Bo_xLFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/8] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

Le 19/02/2018 à 20:50, Peter Maydell a écrit :
> On 19 February 2018 at 17:10, Laurent Vivier <laurent@vivier.eu> wrote:
>> The following changes since commit f0fa81767555fe2c4b5f8c9e0725a80eac1d7f56:
>>
>>   cuda.h: Fix multiple typedef (2018-02-16 18:38:21 +0000)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request
>>
>> for you to fetch changes up to f352a021329f73d0219018cdfb39369687e8cadd:
>>
>>   linux-user: MIPS set cpu to r6 CPU if binary is R6 (2018-02-18 18:52:32 +0100)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
> 
> Hi. This breaks one of my linux-user smoke tests:
> 
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc32plus-linux-user/qemu-sparc32plus
> -L ./gnemul/qemu-sparc sparc/ls -l dummyfile
> unable to find CPU model 'Fujitsu MB86904'
> 
> This is because the include path for linux-user picks the
> guest-architecture subdirectory for the TARGET_ABI_DIR,
> which for sparc32plus is "sparc", but the set of CPUs compiled
> in depends on the TARGET_ARCH, which is "sparc64", and
> sparc64 doesn't include that 32-bit Fujitsu CPU.
> The linux-user/sparc/target_elf.h needs to have code to handle
> both the pure-32-bit and 32-bit-ABI-on-64-bit-CPU cases,
> the same way that linux-user/ppc/target_elf.h does.

Thank you Peter,

I'm going to remove the 4 last patches from the pull request and resend it.

Thanks,
Laurent
