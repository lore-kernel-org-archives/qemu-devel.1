Received: from eggs.gnu.org ([2001:4830:134:3::10]:38642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gJIfH-0005FI-I6
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 08:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gJIfG-0004Xx-IS
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 08:42:07 -0500
References: <154131440495.28728.6130104691310518850@015909e0f939>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <9c68f3df-4a21-4434-6217-519d5fa2230f@ilande.co.uk>
Date: Sun, 4 Nov 2018 13:41:18 +0000
MIME-Version: 1.0
In-Reply-To: <154131440495.28728.6130104691310518850@015909e0f939>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/10] hw/m68k: add Apple Machintosh
 Quadra 800 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, aurelien@aurel32.net, laurent@vivier.eu

On 04/11/2018 06:53, no-reply@patchew.org wrote:

> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20181102152257.20637-1-mark.cave-ayland@ilande.co.uk
> Subject: [Qemu-devel] [PATCH v6 00/10] hw/m68k: add Apple Machintosh Quadra 800 machine
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
> git config --local diff.algorithm histogram
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
> 9245542a6d hw/m68k: define Macintosh Quadra 800
> 4b2499b92a dp8393x: manage big endian bus
> 9a13b06b9f hw/m68k: add a dummy SWIM floppy controller
> bdf5c3725c hw/m68k: add Nubus support for macfb video card
> 6feff81d33 hw/m68k: add Nubus support
> b24a39f653 esp: add pseudo-DMA as used by Macintosh
> 970394cb59 hw/m68k: add macfb video card
> 30013c1b4b escc: introduce a selector for the register bit
> 3274bd6559 hw/m68k: implement ADB bus support for via
> b78fd7f12a hw/m68k: add via support
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/10: hw/m68k: add via support...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #26: 
> new file mode 100644
> 
> ERROR: space prohibited after that '&&' (ctx:WxW)
> #348: FILE: hw/misc/mac_via.c:318:
> +        if (!(v1s->last_b & VIA1B_vRTCClk) && (s->b & VIA1B_vRTCClk)) {
>                                             ^

False positive from checkpatch?

> total: 1 errors, 1 warnings, 778 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 2/10: hw/m68k: implement ADB bus support for via...
> Checking PATCH 3/10: escc: introduce a selector for the register bit...
> Checking PATCH 4/10: hw/m68k: add macfb video card...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #43: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 496 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 5/10: esp: add pseudo-DMA as used by Macintosh...
> Checking PATCH 6/10: hw/m68k: add Nubus support...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #24: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 509 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 7/10: hw/m68k: add Nubus support for macfb video card...
> Checking PATCH 8/10: hw/m68k: add a dummy SWIM floppy controller...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #28: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 498 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 9/10: dp8393x: manage big endian bus...
> Checking PATCH 10/10: hw/m68k: define Macintosh Quadra 800...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #90: 
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 605 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===
> 
> Test command exited with code: 1


ATB,

Mark.
