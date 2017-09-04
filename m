Received: from eggs.gnu.org ([2001:4830:134:3::10]:46545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dozB1-0002ik-SM
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dozAx-0001jx-6i
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:45:03 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:63060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dozAw-0001jW-SW
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 17:44:59 -0400
References: <20170904173226.25252-1-n54@gmx.com>
	<20170904212306.3020-1-n54@gmx.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7cf547d4-e850-c5ec-2afa-2d699e1c0aa9@vivier.eu>
Date: Mon, 4 Sep 2017 23:44:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170904212306.3020-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4] target/m68k: Switch fpu_rom from
 make_floatx80() to make_floatx80_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org, peter.maydell@linaro.org

Le 04/09/2017 à 23:23, Kamil Rytarowski a écrit :
> GCC 4.7.2 on SunOS reports that the values assigned to array members are not
> real constants:
> 
> target/m68k/fpu_helper.c:32:5: error: initializer element is not constant
> target/m68k/fpu_helper.c:32:5: error: (near initialization for 'fpu_rom[0]')
> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
> 
> Convert the array to make_floatx80_init() to fix it.
> Replace floatx80_pi-like constants with make_floatx80_init() as they are
> defined as make_floatx80().
> 
> This fixes build on SmartOS (Joyent).
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/m68k/fpu_helper.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 

Applied to my branch m68k-for-2.11

Thanks,
Laurent
