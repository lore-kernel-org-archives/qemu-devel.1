Received: from eggs.gnu.org ([2001:4830:134:3::10]:50813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZvVv-0006rW-7A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZvVr-0003IQ-0U
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:20:39 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37860)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZvVq-0003Hj-QG
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 04:20:34 -0500
Received: by mail-wm0-f65.google.com with SMTP id f140so10359224wmd.2
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 01:20:34 -0800 (PST)
References: <1515521823-4292-1-git-send-email-jcmvbkbc@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27e44c5d-b04c-df08-bd7f-fc4089d91dcd@redhat.com>
Date: Fri, 12 Jan 2018 10:20:31 +0100
MIME-Version: 1.0
In-Reply-To: <1515521823-4292-1-git-send-email-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3] target/xtensa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 09/01/2018 19:17, Max Filippov wrote:
> Hi Peter,
> 
> please pull the following batch of updates for the target/xtensa.
> Changes v2->v3:
> - Don't use g_malloc_n, use g_new instead.
> Changes v1->v2:
> - Drop no longer used function option_bits_enabled.
> 
> The following changes since commit 0a0dc59d27527b78a195c2d838d28b7b49e5a639:
> 
>   Update version for v2.11.0 release (2017-12-13 14:31:09 +0000)
> 
> are available in the git repository at:
> 
>   git://github.com/OSLL/qemu-xtensa.git tags/20180109-xtensa
> 
> for you to fetch changes up to 5a6539e627faf9251e1db78238b9f9b870610518:
> 
>   target/xtensa: implement disassembler (2018-01-09 09:55:39 -0800)

This fails compilation on CentOS 6:

/tmp/qemu-test/src/target/xtensa/translate.c:81: error: redefinition of typedef 'DisasContext'
/tmp/qemu-test/src/target/xtensa/cpu.h:339: note: previous declaration of 'DisasContext' was here
make[1]: *** [target/xtensa/translate.o] Error 1
make[1]: *** Waiting for unfinished jobs....

Paolo

> ----------------------------------------------------------------
> target/xtensa updates:
> 
> - add libisa to the xtensa target;
> - change xtensa instruction translator to use it;
> - switch existing xtensa cores to use it;
> - add support for a number of instructions: salt/saltu, const16,
>   GPIO32 group, debug mode and MMU-related;
> - add disassembler for Xtensa.
> 
> ----------------------------------------------------------------
> Max Filippov (16):
>       target/xtensa: pass actual frame size to the entry helper
>       target/xtensa: import libisa source
>       target/xtensa: extract core opcode translators
>       target/xtensa: extract FPU2000 opcode translators
>       target/xtensa: update import_core.sh script for libisa
>       target/xtensa: switch dc232b to libisa
>       target/xtensa: switch dc233c to libisa
>       target/xtensa: switch fsf to libisa
>       target/xtensa: use libisa for instruction decoding
>       target/xtensa: tests: fix memctl SR test
>       target/xtensa: drop DisasContext::litbase
>       target/xtensa: add internal/noop SRs and opcodes
>       target/xtensa: implement salt/saltu
>       target/xtensa: implement GPIO32
>       target/xtensa: implement const16
>       target/xtensa: implement disassembler
> 
>  MAINTAINERS                                |     1 +
>  disas/Makefile.objs                        |     1 +
>  disas/xtensa.c                             |   133 +
>  include/disas/bfd.h                        |     1 +
>  include/hw/xtensa/xtensa-isa.h             |   838 ++
>  target/xtensa/Makefile.objs                |     1 +
>  target/xtensa/core-dc232b.c                |     4 +
>  target/xtensa/core-dc232b/xtensa-modules.c | 14105 +++++++++++++++++++++++++
>  target/xtensa/core-dc233c.c                |     4 +
>  target/xtensa/core-dc233c/xtensa-modules.c | 15232 +++++++++++++++++++++++++++
>  target/xtensa/core-fsf.c                   |     5 +
>  target/xtensa/core-fsf/xtensa-modules.c    |  9841 +++++++++++++++++
>  target/xtensa/cpu.c                        |     9 +
>  target/xtensa/cpu.h                        |    31 +
>  target/xtensa/helper.c                     |    37 +
>  target/xtensa/import_core.sh               |    15 +
>  target/xtensa/op_helper.c                  |     2 +-
>  target/xtensa/translate.c                  |  5900 +++++++----
>  target/xtensa/xtensa-isa-internal.h        |   231 +
>  target/xtensa/xtensa-isa.c                 |  1745 +++
>  target/xtensa/xtensa-isa.h                 |     1 +
>  tests/tcg/xtensa/test_sr.S                 |     2 +-
>  22 files changed, 45955 insertions(+), 2184 deletions(-)
>  create mode 100644 disas/xtensa.c
>  create mode 100644 include/hw/xtensa/xtensa-isa.h
>  create mode 100644 target/xtensa/core-dc232b/xtensa-modules.c
>  create mode 100644 target/xtensa/core-dc233c/xtensa-modules.c
>  create mode 100644 target/xtensa/core-fsf/xtensa-modules.c
>  create mode 100644 target/xtensa/xtensa-isa-internal.h
>  create mode 100644 target/xtensa/xtensa-isa.c
>  create mode 100644 target/xtensa/xtensa-isa.h
> 
