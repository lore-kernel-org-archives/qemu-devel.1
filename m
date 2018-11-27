Received: from eggs.gnu.org ([2001:4830:134:3::10]:56039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRfaO-00015x-Hh
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRfaL-00057I-AW
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:47:40 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41139)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gRfaK-000557-Vq
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:47:37 -0500
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_W1-b+KheEXeEyFQOgnqfnw1KxqOoFBTMJFdN+iAfw6w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <76c272d6-684f-60c8-6e23-06321165045e@vivier.eu>
Date: Tue, 27 Nov 2018 16:47:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_W1-b+KheEXeEyFQOgnqfnw1KxqOoFBTMJFdN+iAfw6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 00/15] Misc patches for QEMU 3.1-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27/11/2018 16:43, Peter Maydell wrote:
> On Tue, 27 Nov 2018 at 14:38, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 4822f1ee9efa8df56e29db0a68323b484bdb0335:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181127-pull-request' into staging (2018-11-27 11:21:38 +0000)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to cb16c8466b6c62868aba47cd95fadcf316541f40:
>>
>>   hostmem: no need to check for host_memory_backend_mr_inited() in alloc() (2018-11-27 15:35:19 +0100)
>>
>> ----------------------------------------------------------------
>> * lsi HBA reselection fix (George)
>> * Small cleanups (Li Qiang)
>> * bugfixes for vhost-user-bridge and hostmem (Marc-André)
>> * single-thread TCG fix (me)
>> * VMX migration blocker (me)
>> * target/i386 fix for LOCK (Richard)
>> * fix elf2dmp check (Roman)
>> * MAINTAINERS update (Philippe, Thomas)
>>
>> ----------------------------------------------------------------
> 
> Hi; I'm afraid this has compile problems on 32-bit hosts and
> on the various BSDs.
> 
> Format string issues, 32-bit hosts:
> 
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c: In function 'get_kdbg':
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:90:52: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka
> long long unsigned int}' [-Werror=format=]
>          if (!SYM_RESOLVE(KernBase, pdb, KiWaitNever) ||
>                                                     ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
> definition of macro 'SYM_RESOLVE'
>      s ? printf(#s" = 0x%016lx\n", s) : eprintf("Failed to resolve "#s"\n"), s)
>                  ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:91:57: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka
> long long unsigned int}' [-Werror=format=]
>                  !SYM_RESOLVE(KernBase, pdb, KiWaitAlways) ||
>                                                          ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
> definition of macro 'SYM_RESOLVE'
>      s ? printf(#s" = 0x%016lx\n", s) : eprintf("Failed to resolve "#s"\n"), s)
>                  ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:92:64: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka
> long long unsigned int}' [-Werror=format=]
>                  !SYM_RESOLVE(KernBase, pdb, KdpDataBlockEncoded)) {
>                                                                 ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
> definition of macro 'SYM_RESOLVE'
>      s ? printf(#s" = 0x%016lx\n", s) : eprintf("Failed to resolve "#s"\n"), s)
>                  ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:101:16: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka
>  long long unsigned int}' [-Werror=format=]
>          printf("[KiWaitNever] = 0x%016lx\n", kwn);
>                 ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:102:16: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka
>  long long unsigned int}' [-Werror=format=]
>          printf("[KiWaitAlways] = 0x%016lx\n", kwa);
>                 ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c: In function 'fix_dtb':
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:205:20: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka
>  long long unsigned int}' [-Werror=format=]
>              printf("DTB 0x%016lx has been found from CPU #%zu"
>                     ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:225:16: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka
>  long long unsigned int}' [-Werror=format=]
>          printf("DirectoryTableBase = 0x%016lx has been found from CPU #0"
>                 ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c: In function 'main':
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:491:12: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>      printf("CPU #0 CR3 is 0x%016lx\n", state->cr[3]);
>             ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:500:12: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>      printf("CPU #0 IDT is at 0x%016lx\n", state->idt.base);
>             ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:508:12: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>      printf("CPU #0 IDT[0] -> 0x%016lx\n", idt_desc_addr(first_idt_desc));
>             ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:511:12: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>      printf("Searching kernel downwards from 0x%16lx...\n", KernBase);
>             ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:524:12: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>      printf("KernBase = 0x%16lx, signature is \'%.2s\'\n", KernBase,
>             ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:548:57: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>      if (!SYM_RESOLVE(KernBase, &pdb, KdDebuggerDataBlock) ||
>                                                          ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
> definition of macro 'SYM_RESOLVE'
>      s ? printf(#s" = 0x%016lx\n", s) : eprintf("Failed to resolve "#s"\n"), s)
>                  ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:549:56: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 2 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>              !SYM_RESOLVE(KernBase, &pdb, KdVersionBlock)) {
>                                                         ^
> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
> definition of macro 'SYM_RESOLVE'
>      s ? printf(#s" = 0x%016lx\n", s) : eprintf("Failed to resolve "#s"\n"), s)
>                  ^
> /home/peter.maydell/qemu/contrib/elf2dmp/pdb.c: In function
> 'pdb_find_public_v3_symbol':
> /home/peter.maydell/qemu/contrib/elf2dmp/pdb.c:69:20: error: format
> '%lx' expects argument of type 'long unsigned int', but argument 7 has
> type 'uint64_t {aka long long unsigned int}' [-Werror=format=]
>              printf("%s: 0x%016x(%d:\'%.8s\') + 0x%08x = 0x%09lx\n", name,
>                     ^
> 
> 
> Compile failure, FreeBSD:
> 
> backends/hostmem-file.c:61:5: error: use of undeclared identifier 'path'
>     path = object_get_canonical_path(OBJECT(backend));
>     ^
> backends/hostmem-file.c:63:38: error: use of undeclared identifier 'path'
>                                      path,
>                                      ^
> backends/hostmem-file.c:68:12: error: use of undeclared identifier 'path'
>     g_free(path);
>            ^
> 
> (The variable declaration is in #ifdef CONFIG_LINUX, but the use is
> guarded by CONFIG_POSIX.)
> 
> 
> Compile failure, OpenBSD and OSX:
> In file included from contrib/elf2dmp/addrspace.h:11:0,
>                  from contrib/elf2dmp/main.c:10:
> contrib/elf2dmp/qemu_elf.h:12:17: fatal error: elf.h: No such file or directory
>  #include <elf.h>
>                  ^
> 
> and a format-descriptor issue not in the 32-bit host lot above:
> contrib/elf2dmp/pdb.c: In function 'pdb_find_public_v3_symbol':
> contrib/elf2dmp/pdb.c:71:21: warning: format '%lx' expects argument of
> type 'long unsigned int', but argument 7 has type 'uint64_t'
> [-Wformat=]
>                      ((char *)segment - 8), sym->public_v3.offset, rva);

I think PATCH 15/15 should be "$mingw32" = "yes" as the intend of the tool 
is to convert ELF dump to Windows MEMORY.DMP:

commit 3fa2d384c245bcee3a9ecfa11f298b76ea4c9d57
Author: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
Date:   Wed Aug 29 15:41:25 2018 +0300

    contrib: add elf2dmp tool
    
    elf2dmp is a converter from ELF dump (produced by 'dump-guest-memory') to
    Windows MEMORY.DMP format (also know as 'Complete Memory Dump') which can be
    opened in WinDbg.
    
    This tool can help if VMCoreInfo device/driver is absent in Windows VM and
    'dump-guest-memory -w' is not available but dump can be created in ELF format.
    
    The tool works as follows:
    1. Determine the system paging root looking at GS_BASE or KERNEL_GS_BASE
    to locate the PRCB structure and finds the kernel CR3 nearby if QEMU CPU
    state CR3 is not suitable.
    2. Find an address within the kernel image by dereferencing the first
    IDT entry and scans virtual memory upwards until the start of the
    kernel.
    3. Download a PDB matching the kernel from the Microsoft symbol store,
    and figure out the layout of certain relevant structures necessary for
    the dump.
    4. Populate the corresponding structures in the memory image and create
    the appropriate dump header.
