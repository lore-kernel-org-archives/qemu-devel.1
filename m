Received: from eggs.gnu.org ([2001:4830:134:3::10]:35194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmoLy-0000ch-D9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmoLv-0000xL-71
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:47:22 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:34390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmoLv-0000ww-1j
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 17:47:19 -0400
Received: by mail-qt0-x22d.google.com with SMTP id u11so20569125qtu.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 14:47:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170828174707.20786-1-famz@redhat.com>
	<20170828174707.20786-7-famz@redhat.com>
	<518b29b0-654d-f438-7b18-0419987ba442@amsat.org>
Message-ID: <9bb228d9-15ac-8721-9345-f2037635d063@amsat.org>
Date: Tue, 29 Aug 2017 18:47:13 -0300
MIME-Version: 1.0
In-Reply-To: <518b29b0-654d-f438-7b18-0419987ba442@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 06/10] tests: Add NetBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

Hi Fam,

On 08/29/2017 09:09 AM, Philippe Mathieu-Daudé wrote:
[...]>> +if __name__ == "__main__":
>> +    sys.exit(basevm.main(NetBSDVM))
> 
> This one is failing:
> 
> DEBUG:root:ssh_cmd: ssh -q -o StrictHostKeyChecking=no -o 
> UserKnownHostsFile=/dev/null -o ConnectTimeout=1 -p 34091 -i 
> /tmp/qemu-vm-59XYOj/id_rsa qemu@127.0.0.1
>          set -e;
>          cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
>          tar -xf /dev/rld1a;
>          ./configure --python=python2.7 ;
>          gmake -j4;
>          gmake check;
> 
> ...
>    CC      bt-host.o
>    CC      bt-vhci.o
>    CC      dma-helpers.o
>    CC      vl.o
>    CC      tpm.o
> In file included from vl.c:72:0:
> /var/tmp/qemu-test.ht0XHU/include/hw/loader.h:4:29: fatal error: 
> hw/nvram/fw_cfg.h: No such file or directory
>   #include "hw/nvram/fw_cfg.h"
>                               ^
> compilation terminated.
> /var/tmp/qemu-test.ht0XHU/rules.mak:66: recipe for target 'vl.o' failed
> gmake: *** [vl.o] Error 1
> gmake: *** Waiting for unfinished jobs....
> tests/vm/Makefile.include:32: recipe for target 'vm-build-netbsd' failed
> make: *** [vm-build-netbsd] Error 3

Probably false alarm, this seems to be an ENOMEM host error.

I later got:

	CHK version_gen.h
Makefile:342: recipe for target 'subdir-dtc' failed
gmake[1]: *** No rule to make target 'dtc/libfdt/fdt.h', needed by 
'libfdt/fdt.o'.  Stop.
gmake: *** [subdir-dtc] Error 2
gmake: *** Waiting for unfinished jobs....

which I solved running "gmake -C dtc" after ./configure but I'm not sure 
it is necessary or can come from my tree, this testing is veeeeeeery 
slow and mostly kill my laptop, I ended wondering on what kind of 
hardware you developed this series without going crazy nut :S
