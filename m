Received: from eggs.gnu.org ([2001:4830:134:3::10]:59782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRfll-0008Mx-OJ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gRflg-0000kG-Gr
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:59:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gRflg-0000ij-9A
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:59:20 -0500
References: <1543329397-48407-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_W1-b+KheEXeEyFQOgnqfnw1KxqOoFBTMJFdN+iAfw6w@mail.gmail.com>
	<76c272d6-684f-60c8-6e23-06321165045e@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0d29af6-0f92-01b9-b7c3-d7e7357d6514@redhat.com>
Date: Tue, 27 Nov 2018 16:59:12 +0100
MIME-Version: 1.0
In-Reply-To: <76c272d6-684f-60c8-6e23-06321165045e@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/15] Misc patches for QEMU 3.1-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27/11/18 16:47, Laurent Vivier wrote:
> On 27/11/2018 16:43, Peter Maydell wrote:
>> On Tue, 27 Nov 2018 at 14:38, Paolo Bonzini <pbonzini@redhat.com> wrot=
e:
>>>
>>> The following changes since commit 4822f1ee9efa8df56e29db0a68323b484b=
db0335:
>>>
>>>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-31-20181127=
-pull-request' into staging (2018-11-27 11:21:38 +0000)
>>>
>>> are available in the git repository at:
>>>
>>>
>>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>>
>>> for you to fetch changes up to cb16c8466b6c62868aba47cd95fadcf316541f=
40:
>>>
>>>   hostmem: no need to check for host_memory_backend_mr_inited() in al=
loc() (2018-11-27 15:35:19 +0100)
>>>
>>> ----------------------------------------------------------------
>>> * lsi HBA reselection fix (George)
>>> * Small cleanups (Li Qiang)
>>> * bugfixes for vhost-user-bridge and hostmem (Marc-Andr=C3=A9)
>>> * single-thread TCG fix (me)
>>> * VMX migration blocker (me)
>>> * target/i386 fix for LOCK (Richard)
>>> * fix elf2dmp check (Roman)
>>> * MAINTAINERS update (Philippe, Thomas)
>>>
>>> ----------------------------------------------------------------
>>
>> Hi; I'm afraid this has compile problems on 32-bit hosts and
>> on the various BSDs.
>>
>> Format string issues, 32-bit hosts:
>>
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c: In function 'get_kdbg=
':
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:90:52: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka
>> long long unsigned int}' [-Werror=3Dformat=3D]
>>          if (!SYM_RESOLVE(KernBase, pdb, KiWaitNever) ||
>>                                                     ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
>> definition of macro 'SYM_RESOLVE'
>>      s ? printf(#s" =3D 0x%016lx\n", s) : eprintf("Failed to resolve "=
#s"\n"), s)
>>                  ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:91:57: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka
>> long long unsigned int}' [-Werror=3Dformat=3D]
>>                  !SYM_RESOLVE(KernBase, pdb, KiWaitAlways) ||
>>                                                          ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
>> definition of macro 'SYM_RESOLVE'
>>      s ? printf(#s" =3D 0x%016lx\n", s) : eprintf("Failed to resolve "=
#s"\n"), s)
>>                  ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:92:64: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka
>> long long unsigned int}' [-Werror=3Dformat=3D]
>>                  !SYM_RESOLVE(KernBase, pdb, KdpDataBlockEncoded)) {
>>                                                                 ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
>> definition of macro 'SYM_RESOLVE'
>>      s ? printf(#s" =3D 0x%016lx\n", s) : eprintf("Failed to resolve "=
#s"\n"), s)
>>                  ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:101:16: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka
>>  long long unsigned int}' [-Werror=3Dformat=3D]
>>          printf("[KiWaitNever] =3D 0x%016lx\n", kwn);
>>                 ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:102:16: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka
>>  long long unsigned int}' [-Werror=3Dformat=3D]
>>          printf("[KiWaitAlways] =3D 0x%016lx\n", kwa);
>>                 ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c: In function 'fix_dtb'=
:
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:205:20: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka
>>  long long unsigned int}' [-Werror=3Dformat=3D]
>>              printf("DTB 0x%016lx has been found from CPU #%zu"
>>                     ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:225:16: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka
>>  long long unsigned int}' [-Werror=3Dformat=3D]
>>          printf("DirectoryTableBase =3D 0x%016lx has been found from C=
PU #0"
>>                 ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c: In function 'main':
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:491:12: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>>      printf("CPU #0 CR3 is 0x%016lx\n", state->cr[3]);
>>             ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:500:12: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>>      printf("CPU #0 IDT is at 0x%016lx\n", state->idt.base);
>>             ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:508:12: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>>      printf("CPU #0 IDT[0] -> 0x%016lx\n", idt_desc_addr(first_idt_des=
c));
>>             ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:511:12: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>>      printf("Searching kernel downwards from 0x%16lx...\n", KernBase);
>>             ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:524:12: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>>      printf("KernBase =3D 0x%16lx, signature is \'%.2s\'\n", KernBase,
>>             ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:548:57: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>>      if (!SYM_RESOLVE(KernBase, &pdb, KdDebuggerDataBlock) ||
>>                                                          ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
>> definition of macro 'SYM_RESOLVE'
>>      s ? printf(#s" =3D 0x%016lx\n", s) : eprintf("Failed to resolve "=
#s"\n"), s)
>>                  ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:549:56: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 2 has
>> type 'uint64_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>>              !SYM_RESOLVE(KernBase, &pdb, KdVersionBlock)) {
>>                                                         ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/main.c:44:17: note: in
>> definition of macro 'SYM_RESOLVE'
>>      s ? printf(#s" =3D 0x%016lx\n", s) : eprintf("Failed to resolve "=
#s"\n"), s)
>>                  ^
>> /home/peter.maydell/qemu/contrib/elf2dmp/pdb.c: In function
>> 'pdb_find_public_v3_symbol':
>> /home/peter.maydell/qemu/contrib/elf2dmp/pdb.c:69:20: error: format
>> '%lx' expects argument of type 'long unsigned int', but argument 7 has
>> type 'uint64_t {aka long long unsigned int}' [-Werror=3Dformat=3D]
>>              printf("%s: 0x%016x(%d:\'%.8s\') + 0x%08x =3D 0x%09lx\n",=
 name,
>>                     ^
>>
>>
>> Compile failure, FreeBSD:
>>
>> backends/hostmem-file.c:61:5: error: use of undeclared identifier 'pat=
h'
>>     path =3D object_get_canonical_path(OBJECT(backend));
>>     ^
>> backends/hostmem-file.c:63:38: error: use of undeclared identifier 'pa=
th'
>>                                      path,
>>                                      ^
>> backends/hostmem-file.c:68:12: error: use of undeclared identifier 'pa=
th'
>>     g_free(path);
>>            ^
>>
>> (The variable declaration is in #ifdef CONFIG_LINUX, but the use is
>> guarded by CONFIG_POSIX.)
>>
>>
>> Compile failure, OpenBSD and OSX:
>> In file included from contrib/elf2dmp/addrspace.h:11:0,
>>                  from contrib/elf2dmp/main.c:10:
>> contrib/elf2dmp/qemu_elf.h:12:17: fatal error: elf.h: No such file or =
directory
>>  #include <elf.h>
>>                  ^
>>
>> and a format-descriptor issue not in the 32-bit host lot above:
>> contrib/elf2dmp/pdb.c: In function 'pdb_find_public_v3_symbol':
>> contrib/elf2dmp/pdb.c:71:21: warning: format '%lx' expects argument of
>> type 'long unsigned int', but argument 7 has type 'uint64_t'
>> [-Wformat=3D]
>>                      ((char *)segment - 8), sym->public_v3.offset, rva=
);
>=20
> I think PATCH 15/15 should be "$mingw32" =3D "yes" as the intend of the=
 tool=20
> is to convert ELF dump to Windows MEMORY.DMP:

No, the tool can be run on POSIX systems, the ones where you get the ELF
dump, and produces a MEMORY.DMP that you can load in windbg, so
mingw32=3Dno is correct; it simply hasn't been ported to Windows yet.

Anyway the fix can wait for 3.2, I'll just drop the patch.

Paolo

> commit 3fa2d384c245bcee3a9ecfa11f298b76ea4c9d57
> Author: Viktor Prutyanov <viktor.prutyanov@virtuozzo.com>
> Date:   Wed Aug 29 15:41:25 2018 +0300
>=20
>     contrib: add elf2dmp tool
>    =20
>     elf2dmp is a converter from ELF dump (produced by 'dump-guest-memor=
y') to
>     Windows MEMORY.DMP format (also know as 'Complete Memory Dump') whi=
ch can be
>     opened in WinDbg.
>    =20
>     This tool can help if VMCoreInfo device/driver is absent in Windows=
 VM and
>     'dump-guest-memory -w' is not available but dump can be created in =
ELF format.
>    =20
>     The tool works as follows:
>     1. Determine the system paging root looking at GS_BASE or KERNEL_GS=
_BASE
>     to locate the PRCB structure and finds the kernel CR3 nearby if QEM=
U CPU
>     state CR3 is not suitable.
>     2. Find an address within the kernel image by dereferencing the fir=
st
>     IDT entry and scans virtual memory upwards until the start of the
>     kernel.
>     3. Download a PDB matching the kernel from the Microsoft symbol sto=
re,
>     and figure out the layout of certain relevant structures necessary =
for
>     the dump.
>     4. Populate the corresponding structures in the memory image and cr=
eate
>     the appropriate dump header.
>=20
>=20
