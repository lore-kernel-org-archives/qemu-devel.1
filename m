Received: from eggs.gnu.org ([2001:4830:134:3::10]:53547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3KFx-0002lt-BS
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d3KFs-0006TY-TS
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:33:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d3KFs-0006Sl-Ke
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:33:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B09661963
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:33:03 +0000 (UTC)
Date: Wed, 26 Apr 2017 18:32:52 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170426103252.GE16228@pxdev.xzpeter.org>
References: <1493192675-16104-1-git-send-email-peterx@redhat.com>
	<149320210015.84.11529218509976657206@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <149320210015.84.11529218509976657206@c05f1edc8ed1>
Subject: Re: [Qemu-devel] [PATCH 0/2] ramblock: add hmp command "info
 ramblock"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

On Wed, Apr 26, 2017 at 03:21:40AM -0700, no-reply@patchew.org wrote:

[...]

>   SIGN    optionrom/linuxboot.bin
>   LINK    qemu-io.exe
>   LINK    qemu-ga.exe
>   LINK    qemu-img.exe
>   GEN     x86_64-softmmu/hmp-commands.h
>   GEN     x86_64-softmmu/config-target.h
>   GEN     x86_64-softmmu/hmp-commands-info.h
>   GEN     aarch64-softmmu/config-target.h
>   GEN     aarch64-softmmu/hmp-commands.h
>   GEN     aarch64-softmmu/hmp-commands-info.h
>   CC      x86_64-softmmu/exec.o
>   CC      x86_64-softmmu/translate-all.o
>   CC      x86_64-softmmu/cpu-exec-common.o
>   CC      x86_64-softmmu/cpu-exec.o
>   CC      x86_64-softmmu/tcg/tcg-op.o
>   CC      x86_64-softmmu/translate-common.o
>   CC      x86_64-softmmu/tcg/tcg.o
>   CC      aarch64-softmmu/exec.o
>   CC      aarch64-softmmu/translate-all.o
>   CC      aarch64-softmmu/cpu-exec.o
>   CC      aarch64-softmmu/translate-common.o
>   CC      aarch64-softmmu/cpu-exec-common.o
>   CC      aarch64-softmmu/tcg/tcg.o
>   CC      x86_64-softmmu/tcg/optimize.o
> /tmp/qemu-test/src/exec.c: In function 'ram_block_dump':
> /tmp/qemu-test/src/exec.c:1362:47: error: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'ram_addr_t {aka long long unsigned int}' [-Werror=format=]
>          monitor_printf(mon, "%24s %8s  0x%016lx 0x%016lx 0x%016lx\n",
>                                                ^
> /tmp/qemu-test/src/exec.c:1362:56: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'ram_addr_t {aka long long unsigned int}' [-Werror=format=]
>          monitor_printf(mon, "%24s %8s  0x%016lx 0x%016lx 0x%016lx\n",
>                                                         ^
> /tmp/qemu-test/src/exec.c:1362:65: error: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'ram_addr_t {aka long long unsigned int}' [-Werror=format=]
>          monitor_printf(mon, "%24s %8s  0x%016lx 0x%016lx 0x%016lx\n",
>                                                                  ^
> cc1: all warnings being treated as errors
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'exec.o' failed
> make[1]: *** [exec.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>   CC      aarch64-softmmu/tcg/tcg-op.o
> /tmp/qemu-test/src/exec.c: In function 'ram_block_dump':
> /tmp/qemu-test/src/exec.c:1362:47: error: format '%lx' expects argument of type 'long unsigned int', but argument 5 has type 'ram_addr_t {aka long long unsigned int}' [-Werror=format=]
>          monitor_printf(mon, "%24s %8s  0x%016lx 0x%016lx 0x%016lx\n",
>                                                ^
> /tmp/qemu-test/src/exec.c:1362:56: error: format '%lx' expects argument of type 'long unsigned int', but argument 6 has type 'ram_addr_t {aka long long unsigned int}' [-Werror=format=]
>          monitor_printf(mon, "%24s %8s  0x%016lx 0x%016lx 0x%016lx\n",
>                                                         ^
> /tmp/qemu-test/src/exec.c:1362:65: error: format '%lx' expects argument of type 'long unsigned int', but argument 7 has type 'ram_addr_t {aka long long unsigned int}' [-Werror=format=]
>          monitor_printf(mon, "%24s %8s  0x%016lx 0x%016lx 0x%016lx\n",
>                                                                  ^
> cc1: all warnings being treated as errors
> /tmp/qemu-test/src/rules.mak:69: recipe for target 'exec.o' failed
> make[1]: *** [exec.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> Makefile:327: recipe for target 'subdir-x86_64-softmmu' failed
> make: *** [subdir-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
> Makefile:327: recipe for target 'subdir-aarch64-softmmu' failed
> make: *** [subdir-aarch64-softmmu] Error 2
> tests/docker/Makefile.include:118: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 2
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-fx9z3mer/src'
> tests/docker/Makefile.include:149: recipe for target 'docker-run-test-mingw@fedora' failed
> make: *** [docker-run-test-mingw@fedora] Error 2

Hmm. Let me repost with PRIx64. Sorry for the noise.

-- 
Peter Xu
