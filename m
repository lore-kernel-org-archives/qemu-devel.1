Received: from eggs.gnu.org ([2001:4830:134:3::10]:47315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1doYKe-0002F6-7D
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 13:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1doYKZ-0005tn-NM
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 13:05:12 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1doYKZ-0005rW-AZ
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 13:05:07 -0400
References: <20170903163130.14288-1-n54@gmx.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
Date: Sun, 3 Sep 2017 19:05:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170903163130.14288-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org

Le 03/09/2017 à 18:31, Kamil Rytarowski a écrit :
> GCC 4.7.2 on SunOS reports that the values assigned to array members are not
> real constants:
> 
> target/m68k/fpu_helper.c:32:5: error: initializer element is not constant
> target/m68k/fpu_helper.c:32:5: error: (near initialization for 'fpu_rom[0]')
> rules.mak:66: recipe for target 'target/m68k/fpu_helper.o' failed
> 
> Convert the array to switch() to workaround the issue.

I don't like the idea. It's really an array and should be managed as an
array.

Could you try to use make_floatx80_init() instead of make_floatx80() ?

Thanks,
Laurent
