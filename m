Received: from eggs.gnu.org ([2001:4830:134:3::10]:48722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eY9OU-0004ha-IQ
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:45:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <patricktsen@gmail.com>) id 1eY9OT-000524-BX
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:45:38 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:42819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <patricktsen@gmail.com>)
	id 1eY9OT-00051Z-4d
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 06:45:37 -0500
Received: by mail-ot0-x234.google.com with SMTP id d2so7200344oth.9
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 03:45:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151532466559.354.2162830022963745471@5adcb62bf0d6>
References: <20180107111341.8879-1-patricktsen@gmail.com>
	<151532466559.354.2162830022963745471@5adcb62bf0d6>
From: Patrick Tseng <patricktsen@gmail.com>
Date: Sun, 7 Jan 2018 03:45:15 -0800
Message-ID: <CAG_FrSJM7wf1wGDSmCOW4LXS9WqVZnZkQn_RA5Lu10YazL6gbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/1] input-linux: provide hotkeys for evdev
 toggle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Please disregard this patch, I'll have another one ready and actually
isolated to input-linux.

On Sun, Jan 7, 2018 at 3:31 AM, <no-reply@patchew.org> wrote:

> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Type: series
> Message-id: 20180107111341.8879-1-patricktsen@gmail.com
> Subject: [Qemu-devel] [PATCH 0/1] input-linux: provide hotkeys for evdev
> toggle
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
> Switched to a new branch 'test'
> 8d2dfcbd73 input-linux: provide hotkeys for evdev toggle
>
> === OUTPUT BEGIN ===
> Checking PATCH 1/1: input-linux: provide hotkeys for evdev toggle...
> ERROR: consider using qemu_strtol in preference to strtol
> #77: FILE: vl.c:3384:
> +                qemu_evdev_rhotkey = strtol(optarg, NULL, 0);
>
> ERROR: consider using qemu_strtol in preference to strtol
> #80: FILE: vl.c:3387:
> +                qemu_evdev_lhotkey = strtol(optarg, NULL, 0);
>
> ERROR: Missing Signed-off-by: line(s)
>
> total: 3 errors, 0 warnings, 56 lines checked
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
