Received: from eggs.gnu.org ([2001:4830:134:3::10]:60758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cTf9G-0000PG-Cl
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 20:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cTf9F-0004Iv-4m
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 20:34:50 -0500
MIME-Version: 1.0
In-Reply-To: <148470234043.214.7219322137444222645@790289a7ca88>
References: <1484702052-7900-1-git-send-email-skiver.cloud.yzy@gmail.com>
	<148470234043.214.7219322137444222645@790289a7ca88>
From: Yang Ziyue <skiver.cloud.yzy@gmail.com>
Date: Wed, 18 Jan 2017 09:34:47 +0800
Message-ID: <CAHkcwafqx4-vMsCVJOZS04Kb1cRVbu2ea802hjdOhJp2JoPA+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] gdbstub.c: fix GDB connection segfault
 caused by empty machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Ziyue Yang <yzylivezh@hotmail.com>, Anthony Liguori <aliguori@us.ibm.com>

Oops seems I forgot to check the patch before submitting. Sorry for that.
The new patch is tagged as v3 now, but I'm not sure whether it should
be tagged as v2 since the origin v2 failed. Is there any specification
about this? Thanks!

2017-01-18 9:19 GMT+08:00  <no-reply@patchew.org>:
> Hi,
>
> Your series seems to have some coding style problems. See output below for
> more information:
>
> Message-id: 1484702052-7900-1-git-send-email-skiver.cloud.yzy@gmail.com
> Type: series
> Subject: [Qemu-devel] [PATCH v2] gdbstub.c: fix GDB connection segfault caused by empty machines
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
>
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
>
> # Useful git options
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>
> commits="$(git log --format=%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>         failed=1
>         echo
>     fi
>     n=$((n+1))
> done
>
> exit $failed
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]         patchew/1484702052-7900-1-git-send-email-skiver.cloud.yzy@gmail.com -> patchew/1484702052-7900-1-git-send-email-skiver.cloud.yzy@gmail.com
> Switched to a new branch 'test'
> 4daee16 gdbstub.c: fix GDB connection segfault caused by empty machines
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: gdbstub.c: fix GDB connection segfault caused by empty machines...
> ERROR: Error messages should not contain newlines
> #48: FILE: gdbstub.c:640:
> +            error_report("Error: Bad gdb register numbering for '%s'\n"
>
> ERROR: Error messages should not contain newlines
> #49: FILE: gdbstub.c:641:
> +                         "Expected %d got %d\n", xml, g_pos, s->base_reg);
>
> ERROR: Error messages should not contain newlines
> #58: FILE: gdbstub.c:893:
> +        error_report("\nQEMU: Terminated via GDBstub\n");
>
> ERROR: Error messages should not contain newlines
> #68: FILE: gdbstub.c:1361:
> +                error_report("gdbstub: Bad syscall format string '%s'\n",
>
> ERROR: Error messages should not contain newlines
> #79: FILE: gdbstub.c:1737:
> +                     "machine without any CPU.\n");
>
> total: 5 errors, 0 warnings, 47 lines checked
>
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
