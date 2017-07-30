Received: from eggs.gnu.org ([2001:4830:134:3::10]:41005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbnZH-0003uq-TJ
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbnZE-00064C-R6
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:43:35 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:54302)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dbnZE-00063t-ET
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 08:43:32 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150141620909.27.18190663248638654358@93e45bedd699>
Date: Sun, 30 Jul 2017 15:43:21 +0300
In-Reply-To: <150141620909.27.18190663248638654358@93e45bedd699>
	(no-reply@patchew.org's message of "Sun, 30 Jul 2017 05:03:30 -0700
	(PDT)")
Message-ID: <87y3r6gknq.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 0/5] hypertrace: Lightweight
 guest-to-QEMU trace channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com, lcapitulino@redhat.com

no-reply  writes:

> Hi,
> This series seems to have some coding style problems. See output below for
> more information:

> Subject: [Qemu-devel] [PATCH v7 0/5] hypertrace: Lightweight guest-to-QEMU trace channel
> Message-id: 150141363372.9857.9055094189388759132.stgit@frigg.lan
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
>  * [new tag]               patchew/1501444898-27668-1-git-send-email-peng.hao2@zte.com.cn -> patchew/1501444898-27668-1-git-send-email-peng.hao2@zte.com.cn
> Switched to a new branch 'test'
> 5dad7c93de hypertrace: Add guest-side user-level library
> dcf9d9c7c7 hypertrace: [softmmu] Add QEMU-side proxy to "guest_hypertrace" event
> 4c041f724d hypertrace: [*-user] Add QEMU-side proxy to "guest_hypertrace" event
> 73796a3885 hypertrace: Add tracing event "guest_hypertrace"
> 43fe7e2e2e hypertrace: Add documentation

> === OUTPUT BEGIN ===
> Checking PATCH 1/5: hypertrace: Add documentation...
> Checking PATCH 2/5: hypertrace: Add tracing event "guest_hypertrace"...
> Checking PATCH 3/5: hypertrace: [*-user] Add QEMU-side proxy to "guest_hypertrace" event...
> Checking PATCH 4/5: hypertrace: [softmmu] Add QEMU-side proxy to "guest_hypertrace" event...
> Checking PATCH 5/5: hypertrace: Add guest-side user-level library...
> WARNING: architecture specific defines should be avoided
> #171: FILE: hypertrace/guest/common.c:84:
> +#if !defined(CONFIG_USER_ONLY) && defined(__linux__)

> ERROR: consider using qemu_strtoull in preference to strtoull
> #191: FILE: hypertrace/guest/common.c:104:
> +    uint64_t vv = strtoull(v, &res, 16);

> total: 1 errors, 1 warnings, 432 lines checked

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.

> === OUTPUT END ===

> Test command exited with code: 1

I think both are false positives for this specific case.

Cheers,
  Lluis
