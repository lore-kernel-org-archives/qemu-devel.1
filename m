Received: from eggs.gnu.org ([2001:4830:134:3::10]:49335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOXIh-0006Hk-2g
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOXIf-00069G-Vz
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:48:11 -0400
References: <152780698395.339.5335316086530524292@d39dc562802a>
From: John Snow <jsnow@redhat.com>
Message-ID: <a551041c-2c59-503d-1b6d-747e0e2cd107@redhat.com>
Date: Thu, 31 May 2018 19:48:04 -0400
MIME-Version: 1.0
In-Reply-To: <152780698395.339.5335316086530524292@d39dc562802a>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/16] AHCI: tracing improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, f4bug@amsat.org



On 05/31/2018 06:49 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 

[ blah blah blah ]

> In file included from /tmp/qemu-test/src/hw/ide/ahci.c:30:0:
> /tmp/qemu-test/src/hw/ide/ahci.c: In function 'ahci_mem_write':
> /tmp/qemu-test/src/hw/ide/ahci.c:497:38: error: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'hwaddr {aka long long unsigned int}' [-Werror=format=]
>              qemu_log_mask(LOG_UNIMP, "Attempted write to unimplemented register:"
>                                       ^
> /tmp/qemu-test/src/include/qemu/log.h:85:22: note: in definition of macro 'qemu_log_mask'
>              qemu_log(FMT, ## __VA_ARGS__);              \
>                       ^~~
> /tmp/qemu-test/src/hw/ide/ahci.c:498:63: note: format string is defined here
>                            " AHCI host register %s, offset 0x%lx: 0x%"PRIu64,
>                                                              ~~^
>                                                              %llx
> In file included from /tmp/qemu-test/src/hw/ide/ahci.c:30:0:
> /tmp/qemu-test/src/hw/ide/ahci.c:511:34: error: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'hwaddr {aka long long unsigned int}' [-Werror=format=]
>          qemu_log_mask(LOG_UNIMP, "Attempted write to unimplemented register: "
>                                   ^
> /tmp/qemu-test/src/include/qemu/log.h:85:22: note: in definition of macro 'qemu_log_mask'
>              qemu_log(FMT, ## __VA_ARGS__);              \
>                       ^~~
> /tmp/qemu-test/src/hw/ide/ahci.c:512:59: note: format string is defined here
>                        "AHCI global register at offset 0x%lx: 0x%"PRIu64,
>                                                          ~~^
>                                                          %llx

Rookie stuff; I forgot hwaddr was just uint64_t, which is implemented as
long on x86_64. Replaced address and value specifications both with
"0x%"PRIx64 in both cases.

--js
