Received: from eggs.gnu.org ([2001:4830:134:3::10]:42655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cTndL-0006r4-5T
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cTndJ-0002Sh-1v
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:38:27 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1cTndI-0002OU-O1
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 05:38:24 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so3061747wmi.1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 02:38:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <147981933802.87.15156302489855615487@0ce5b62ddca6>
References: <147981681351.30309.4854065801791462661.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<147981933802.87.15156302489855615487@0ce5b62ddca6>
From: Pradeep Kiruvale <pradeepkiruvale@gmail.com>
Date: Wed, 18 Jan 2017 11:38:21 +0100
Message-ID: <CAJ2SuLnF+MMjwMOHfDGgEgZbjFqw3y0fPOvxM+MKBgQga6ipMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH] throttle: move throttling cmdline
 options to a separate header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 22 November 2016 at 13:55, <no-reply@patchew.org> wrote:

> Hi,
>
> Your series seems to have some coding style problems. See output below for
> more information:
>
> Subject: [Qemu-devel] [RFC PATCH] throttle: move throttling cmdline
> options to a separate header file
> Type: series
> Message-id: 147981681351.30309.4854065801791462661.stgit@
> bahia.lab.toulouse-stg.fr.ibm.com
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
>     if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback
> -; then
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
>  * [new tag]         patchew/147981681351.30309.4854065801791462661.stgit@
> bahia.lab.toulouse-stg.fr.ibm.com -> patchew/147981681351.30309.
> 4854065801791462661.stgit@bahia.lab.toulouse-stg.fr.ibm.com
> Switched to a new branch 'test'
> f5fd85c throttle: move throttling cmdline options to a separate header file
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: throttle: move throttling cmdline options to a
> separate header file...
> ERROR: Macros with multiple statements should be enclosed in a do - while
> loop
> #133: FILE: include/qemu/throttle-options.h:14:
>


I did not understand how to fix this issue? I tried putting the do - while
loop still did not work
any idea, how to fix this?

Regards,
Pradeep

+#define THROTTLE_OPTS \
> +        { \
> +            .name = "throttling.iops-total", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "limit total I/O operations per second", \
> +        },{ \
> +            .name = "throttling.iops-read", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "limit read operations per second", \
> +        },{ \
> +            .name = "throttling.iops-write", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "limit write operations per second", \
> +        },{ \
> +            .name = "throttling.bps-total", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "limit total bytes per second", \
> +        },{ \
> +            .name = "throttling.bps-read", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "limit read bytes per second", \
> +        },{ \
> +            .name = "throttling.bps-write", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "limit write bytes per second", \
> +        },{ \
> +            .name = "throttling.iops-total-max", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "I/O operations burst", \
> +        },{ \
> +            .name = "throttling.iops-read-max", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "I/O operations read burst", \
> +        },{ \
> +            .name = "throttling.iops-write-max", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "I/O operations write burst", \
> +        },{ \
> +            .name = "throttling.bps-total-max", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "total bytes burst", \
> +        },{ \
> +            .name = "throttling.bps-read-max", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "total bytes read burst", \
> +        },{ \
> +            .name = "throttling.bps-write-max", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "total bytes write burst", \
> +        },{ \
> +            .name = "throttling.iops-total-max-length", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "length of the iops-total-max burst period, in
> seconds", \
> +        },{ \
> +            .name = "throttling.iops-read-max-length", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "length of the iops-read-max burst period, in
> seconds", \
> +        },{ \
> +            .name = "throttling.iops-write-max-length", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "length of the iops-write-max burst period, in
> seconds", \
> +        },{ \
> +            .name = "throttling.bps-total-max-length", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "length of the bps-total-max burst period, in
> seconds", \
> +        },{ \
> +            .name = "throttling.bps-read-max-length", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "length of the bps-read-max burst period, in
> seconds", \
> +        },{ \
> +            .name = "throttling.bps-write-max-length", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "length of the bps-write-max burst period, in
> seconds", \
> +        },{ \
> +            .name = "throttling.iops-size", \
> +            .type = QEMU_OPT_NUMBER, \
> +            .help = "when limiting by iops max size of an I/O in bytes", \
> +        }
>
> total: 1 errors, 0 warnings, 188 lines checked
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
