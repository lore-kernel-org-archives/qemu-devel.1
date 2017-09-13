Received: from eggs.gnu.org ([2001:4830:134:3::10]:55619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4Er-0007VX-Px
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4El-0005Fn-3Y
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:45:45 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:54357)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds4Ek-0005FI-BK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:45:38 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150525566622.321.14749941518071789021@6d89bd104fc3>
Date: Wed, 13 Sep 2017 12:45:22 +0300
In-Reply-To: <150525566622.321.14749941518071789021@6d89bd104fc3>
	(no-reply@patchew.org's message of "Tue, 12 Sep 2017 15:34:26 -0700
	(PDT)")
Message-ID: <874ls7ue31.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 00/22] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, cota@braap.org, famz@redhat.com, stefanha@redhat.com, armbru@redhat.com

no-reply  writes:

> Hi,
> This series seems to have some coding style problems. See output below for
> more information:

> Subject: [Qemu-devel] [PATCH v5 00/22] instrument: Add basic event instrumentation
> Message-id: 150525010239.15988.8172586618197849619.stgit@frigg.lan
> Type: series

> === TEST SCRIPT BEGIN ===
> #!/bin/bash

> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0

> git config --local diff.renamelimit 0
> git config --local diff.renames True

> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done

> exit $failed
> === TEST SCRIPT END ===

> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/150525010239.15988.8172586618197849619.stgit@frigg.lan -> patchew/150525010239.15988.8172586618197849619.stgit@frigg.lan
>  t [tag update]            patchew/20170912144459.11359-1-pbonzini@redhat.com -> patchew/20170912144459.11359-1-pbonzini@redhat.com
> Switched to a new branch 'test'
> 1ab48ae9b7 instrument: Add API to manipulate guest memory
> 7e0bd2cad7 instrument: Add event 'guest_user_syscall_ret'
> 334caef899 instrument: Add event 'guest_user_syscall'
> 09a1773791 instrument: Add event 'guest_mem_before_exec'
> 2bd64563d3 instrument: Add event 'guest_mem_before_trans'
> 5b344ec1c3 trace: Introduce a proper structure to describe memory accesses
> 04e5b883b1 instrument: Add event 'guest_cpu_reset'
> 7971d0f2a4 instrument: Add event 'guest_cpu_exit'
> 53dbc9ad88 exec: Add function to synchronously flush TB on a stopped vCPU
> d8b51515d2 instrument: Support synchronous modification of vCPU state
> 08d492e35f instrument: Add event 'guest_cpu_enter'
> 0be52b1bbd instrument: Track vCPUs
> 7ab01f20f5 instrument: Add support for tracing events
> 78676cff2d instrument: Add basic control interface
> 00172972ae instrument: [hmp] Add library loader
> 34ccf831e6 instrument: [qapi] Add library loader
> d1ab648b00 instrument: [softmmu] Add command line library loader
> 150ad4a651 instrument: [bsd-user] Add command line library loader
> a064b1621a instrument: [linux-user] Add command line library loader
> aa78ee9f5a instrument: Add generic library loader
> f10357e313 instrument: Add configure-time flag
> 4d324ad619 instrument: Add documentation

> === OUTPUT BEGIN ===
> Checking PATCH 1/22: instrument: Add documentation...
> Checking PATCH 2/22: instrument: Add configure-time flag...
> Checking PATCH 3/22: instrument: Add generic library loader...
> Checking PATCH 4/22: instrument: [linux-user] Add command line library loader...
> Checking PATCH 5/22: instrument: [bsd-user] Add command line library loader...
> Checking PATCH 6/22: instrument: [softmmu] Add command line library loader...
> Checking PATCH 7/22: instrument: [qapi] Add library loader...
> ERROR: externs should be avoided in .c files
> #254: FILE: stubs/instrument.c:40:
> +void qmp_instr_unload(const char *id, Error **errp);

> total: 1 errors, 0 warnings, 204 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

> Checking PATCH 8/22: instrument: [hmp] Add library loader...
> Checking PATCH 9/22: instrument: Add basic control interface...
> WARNING: architecture specific defines should be avoided
> #52: FILE: include/qemu/compiler.h:119:
> +#if defined _WIN32 || defined __CYGWIN__

> WARNING: architecture specific defines should be avoided
> #53: FILE: include/qemu/compiler.h:120:
> +  #ifdef __GNUC__

> WARNING: architecture specific defines should be avoided
> #59: FILE: include/qemu/compiler.h:126:
> +  #if __GNUC__ >= 4

> WARNING: architecture specific defines should be avoided
> #343: FILE: instrument/qemu-instr/control.h:13:
> +#ifdef __cplusplus

> WARNING: architecture specific defines should be avoided
> #372: FILE: instrument/qemu-instr/control.h:42:
> +#ifdef __cplusplus

> total: 0 errors, 5 warnings, 309 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 10/22: instrument: Add support for tracing events...
> WARNING: architecture specific defines should be avoided
> #77: FILE: instrument/qemu-instr/types.h:13:
> +#ifdef __cplusplus

> WARNING: architecture specific defines should be avoided
> #111: FILE: instrument/qemu-instr/types.h:47:
> +#ifdef __cplusplus

> total: 0 errors, 2 warnings, 225 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 11/22: instrument: Track vCPUs...
> Checking PATCH 12/22: instrument: Add event 'guest_cpu_enter'...
> Checking PATCH 13/22: instrument: Support synchronous modification of vCPU state...
> WARNING: line over 80 characters
> #73: FILE: instrument/control.c:85:
> +        async_run_on_cpu(cpu, instr_cpu_stop_all__cb, RUN_ON_CPU_HOST_PTR(info));

Fixed in next series. All above are false positives.


> total: 0 errors, 1 warnings, 127 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 14/22: exec: Add function to synchronously flush TB on a stopped vCPU...
> Checking PATCH 15/22: instrument: Add event 'guest_cpu_exit'...
> Checking PATCH 16/22: instrument: Add event 'guest_cpu_reset'...
> Checking PATCH 17/22: trace: Introduce a proper structure to describe memory accesses...
> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #244: FILE: trace/mem.h:29:
> +            uint8_t size_shift : 2;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:VxW)
> #245: FILE: trace/mem.h:30:
> +            bool    sign_extend: 1;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #246: FILE: trace/mem.h:31:
> +            uint8_t endianness : 1;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #247: FILE: trace/mem.h:32:
> +            bool    store      : 1;
>                                 ^

> total: 4 errors, 0 warnings, 227 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

> Checking PATCH 18/22: instrument: Add event 'guest_mem_before_trans'...
> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #302: FILE: instrument/qemu-instr/types.h:64:
> +            uint8_t size_shift : 2;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:VxW)
> #303: FILE: instrument/qemu-instr/types.h:65:
> +            bool    sign_extend: 1;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #304: FILE: instrument/qemu-instr/types.h:66:
> +            uint8_t endianness : 1;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #305: FILE: instrument/qemu-instr/types.h:67:
> +            bool    store      : 1;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #430: FILE: trace/control.h:37:
> +            uint8_t size_shift : 2;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:VxW)
> #431: FILE: trace/control.h:38:
> +            bool    sign_extend: 1;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #432: FILE: trace/control.h:39:
> +            uint8_t endianness : 1;
>                                 ^

> ERROR: spaces prohibited around that ':' (ctx:WxW)
> #433: FILE: trace/control.h:40:
> +            bool    store      : 1;
>                                 ^

Ignoring; these keep field lengths nicely aligned.


> total: 8 errors, 0 warnings, 389 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

> Checking PATCH 19/22: instrument: Add event 'guest_mem_before_exec'...
> ERROR: externs should be avoided in .c files
> #337: FILE: stubs/instrument.c:61:
> +void helper_instr_guest_mem_before_exec(

False positive. Cannot include the proper helper headers on the stub file.


> total: 1 errors, 0 warnings, 258 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

> Checking PATCH 20/22: instrument: Add event 'guest_user_syscall'...
> Checking PATCH 21/22: instrument: Add event 'guest_user_syscall_ret'...
> Checking PATCH 22/22: instrument: Add API to manipulate guest memory...
> WARNING: architecture specific defines should be avoided
> #41: FILE: instrument/qemu-instr/state.h:13:
> +#ifdef __cplusplus

> WARNING: architecture specific defines should be avoided
> #128: FILE: instrument/qemu-instr/state.h:100:
> +#ifdef __cplusplus

> total: 0 errors, 2 warnings, 181 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===

> Test command exited with code: 1

More false positives.


Thanks,
  Lluis
