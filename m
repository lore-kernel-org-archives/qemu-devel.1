Received: from eggs.gnu.org ([2001:4830:134:3::10]:44140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ej0Mm-0006Ur-4v
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ej0Mi-0007EQ-2w
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:20:44 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:59985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ej0Mh-0007Dv-Q5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:20:40 -0500
References: <151791158212.102.18197332970427652985@bdbb90650ae5>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <1036a7be-d034-b584-7941-c461a1e0da4a@vivier.eu>
Date: Tue, 6 Feb 2018 11:20:28 +0100
MIME-Version: 1.0
In-Reply-To: <151791158212.102.18197332970427652985@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] m68k: implement movep instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Pavel.Dovgaluk@ispras.ru
Cc: famz@redhat.com, dovgaluk@ispras.ru

Le 06/02/2018 à 11:06, no-reply@patchew.org a écrit :
...
>   CC      m68k-softmmu/target/m68k/translate.o
> /var/tmp/patchew-tester-tmp-87qny0g5/src/target/m68k/translate.c: In function ‘disas_movep’:
> /var/tmp/patchew-tester-tmp-87qny0g5/src/target/m68k/translate.c:2110:13: error: too few arguments to function ‘gen_store’
>              gen_store(s, OS_BYTE, abuf, dbuf);
>              ^~~~~~~~~
> /var/tmp/patchew-tester-tmp-87qny0g5/src/target/m68k/translate.c:315:20: note: declared here
>  static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val,
>                     ^~~~~~~~~
> /var/tmp/patchew-tester-tmp-87qny0g5/src/target/m68k/translate.c:2118:20: error: too few arguments to function ‘gen_load’
>              dbuf = gen_load(s, OS_BYTE, abuf, 1);
>                     ^~~~~~~~
> /var/tmp/patchew-tester-tmp-87qny0g5/src/target/m68k/translate.c:287:20: note: declared here
>  static inline TCGv gen_load(DisasContext *s, int opsize, TCGv addr,
>                     ^~~~~~~~

My last series has added the index parameter to gen_load() and gen_store().

See

commit 54e1e0b5b5ce4fc76335b1fbbf09cb8fdd5ab89d
Author: Laurent Vivier <laurent@vivier.eu>
Date:   Thu Jan 18 20:38:43 2018 +0100

    target/m68k: add index parameter to gen_load()/gen_store() and Co.

    The instruction "moves" can select source and destination
    address space (user or kernel). This patch modifies
    all the load/store functions to be able to provide
    the address space the caller wants to use instead
    of using the current one. All the callers are modified
    to provide the default address space to these functions.

You need to add "IS_USER(s)" to your calls.

Thanks,
Laurent
