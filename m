Received: from eggs.gnu.org ([2001:4830:134:3::10]:33469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cJgq5-0001GT-OW
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Vlad.Lungu@windriver.com>) id 1cJgq2-00072V-Gi
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:21:49 -0500
Received: from mail5.windriver.com ([192.103.53.11]:38066 helo=mail5.wrs.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Vlad.Lungu@windriver.com>)
	id 1cJgq2-00072L-7R
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 08:21:46 -0500
References: <148227490601.73.14307493005138844836@790289a7ca88>
From: Vlad Lungu <vlad.lungu@windriver.com>
Message-ID: <9f1246ba-746f-7ef5-91f4-297e4f8282f7@windriver.com>
Date: Wed, 21 Dec 2016 15:21:36 +0200
MIME-Version: 1.0
In-Reply-To: <148227490601.73.14307493005138844836@790289a7ca88>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv4] multiboot: copy the cmdline verbatim,
 unescape module strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com

Resubmitted with errors fixed.

Regards,

Vlad



On 12/21/2016 01:01 AM, no-reply@patchew.org wrote:
> Hi,
>
> Your series seems to have some coding style problems. See output below for
> more information:
>
> Subject: [Qemu-devel] [PATCHv4] multiboot: copy the cmdline verbatim, unescape module strings
> Message-id: 1482140507-23607-1-git-send-email-vlad.lungu@windriver.com
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
> Switched to a new branch 'test'
> 951c8be multiboot: copy the cmdline verbatim, unescape module strings
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: multiboot: copy the cmdline verbatim, unescape module strings...
> WARNING: line over 80 characters
> #42: FILE: hw/i386/multiboot.c:299:
> +            next_initrd = (char *)get_opt_value(tmpbuf, sizeof(tmpbuf), initrd_filename);
>
> ERROR: do not use assignment in if condition
> #50: FILE: hw/i386/multiboot.c:304:
> +            if ((next_space = strchr(tmpbuf, ' ')))
>
> ERROR: braces {} are necessary for all arms of this statement
> #50: FILE: hw/i386/multiboot.c:304:
> +            if ((next_space = strchr(tmpbuf, ' ')))
> [...]
>
> total: 2 errors, 1 warnings, 48 lines checked
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
