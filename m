Received: from eggs.gnu.org ([2001:4830:134:3::10]:36043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edWLL-0004P0-6J
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:16:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1edWLH-0004ju-7w
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:16:35 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:56462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1edWLG-0004il-UN
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 02:16:31 -0500
References: <20180118193846.24953-1-laurent@vivier.eu>
	<20180118193846.24953-3-laurent@vivier.eu>
	<b2e8fffd-5afb-edcf-3f30-62064175a435@landley.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <76dd1868-5cf3-4556-e2ab-fe430f53174a@vivier.eu>
Date: Mon, 22 Jan 2018 08:16:23 +0100
MIME-Version: 1.0
In-Reply-To: <b2e8fffd-5afb-edcf-3f30-62064175a435@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/7] target/m68k: add MC68040 MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 21/01/2018 à 20:57, Rob Landley a écrit :
> On 01/18/2018 01:38 PM, Laurent Vivier wrote:
>> Only add MC68040 MMU page table processing and related
>> registers (Special Status Word, Translation Control Register,
>> User Root Pointer and Supervisor Root Pointer).
>>
>> Transparent Translation Registers, DFC/SFC and pflush/ptest
>> will be added later.
> 
> I built qemu from thursday's git and qemu-system-m68k -M ? doesn't have
> an obvious board emulation I can aim a linux kernel at. Is there a qemu
> tree I should test, or...?
> 
> (I want to help out and test this stuff, but don't have context...)

For the moment, I didn't push a machine type that supports a M68040 CPU.

If you wan to test it, you can try my try branch at:

https://github.com/vivier/qemu-m68k.git branch q800-dev

with machine type "-M q800" emulating a Macintosh Quadra 800.

The command line I usually use is:

qemu-system-m68k -M q800 -serial none -serial mon:stdio -m 1000M \
 -drive file=virtm68k-etch.qcow2,format=qcow2 \
 -net nic,model=dp83932,addr=09:00:07:12:34:57 \
 -net bridge,helper=/usr/libexec/qemu-bridge-helper,br=virbr0 \
 -append "root=/dev/sda2 rw console=ttyS0 console=tty"\
 -kernel vmlinux-4.8.0-2-m68k -initrd initrd.img-4.8.0-2-m68k \
 -g 1600x800x24

Thanks,
Laurent
