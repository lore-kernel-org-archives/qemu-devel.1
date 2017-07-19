Received: from eggs.gnu.org ([2001:4830:134:3::10]:58760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXq7a-00060i-W7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXq7X-00026Q-SV
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:38:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXq7X-00025z-LV
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:38:35 -0400
References: <150047342085.93.4723386967259777082@5d477a5b5989>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1d7d4856-6da0-f5d5-91e5-102a336653c9@redhat.com>
Date: Wed, 19 Jul 2017 16:38:29 +0200
MIME-Version: 1.0
In-Reply-To: <150047342085.93.4723386967259777082@5d477a5b5989>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] target/s390x: Fix broken build with
 --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org
Cc: famz@redhat.com, cohuck@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

On 19.07.2017 16:10, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 1500468850-15571-1-git-send-email-thuth@redhat.com
> Subject: [Qemu-devel] [PATCH 0/5] target/s390x: Fix broken build with --disable-tcg
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> 
> BASE=base
> n=1
> total=$(git log --oneline $BASE.. | wc -l)
> failed=0
> 
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
> Switched to a new branch 'test'
> 93bc72a target/s390x: Add remaining switches to compile with --disable-tcg
> 7ed9f55 target/s390x: Move exception-related functions to a new excp_helper.c file
> 1285eb9 target/s390x: Move diag helpers to a separate file
> 26943a8 target/s390x: Move s390_cpu_dump_state() to helper.c
> 87577ec target/s390x: Move program_interrupt() & trigger_pgm_exception() to interrupt.c
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/5: target/s390x: Move program_interrupt() & trigger_pgm_exception() to interrupt.c...
> Checking PATCH 2/5: target/s390x: Move s390_cpu_dump_state() to helper.c...
> Checking PATCH 3/5: target/s390x: Move diag helpers to a separate file...
> Checking PATCH 4/5: target/s390x: Move exception-related functions to a new excp_helper.c file...
> ERROR: do not use C99 // comments
> #98: FILE: target/s390x/excp_helper.c:32:
> +//#define DEBUG_S390
> 
> ERROR: do not use C99 // comments
> #99: FILE: target/s390x/excp_helper.c:33:
> +//#define DEBUG_S390_STDOUT
> 
> ERROR: braces {} are necessary for all arms of this statement
> #105: FILE: target/s390x/excp_helper.c:39:
> +         if (qemu_log_separate()) qemu_log(fmt, ##__VA_ARGS__); } while (0)
> [...]

I moved the code without changing it, so these are not new style issues.

 Thomas
