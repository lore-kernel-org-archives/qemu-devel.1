Received: from eggs.gnu.org ([2001:4830:134:3::10]:47618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOXA8-0004Ih-Qy
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOXA7-0005XR-DK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 19:39:20 -0400
References: <152780684818.339.1959711568134867768@d39dc562802a>
From: John Snow <jsnow@redhat.com>
Message-ID: <81d35555-3948-a891-9dfa-effd940665a3@redhat.com>
Date: Thu, 31 May 2018 19:39:12 -0400
MIME-Version: 1.0
In-Reply-To: <152780684818.339.1959711568134867768@d39dc562802a>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/16] AHCI: tracing improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, f4bug@amsat.org



On 05/31/2018 06:47 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20180531222835.16558-1-jsnow@redhat.com
> Subject: [Qemu-devel] [PATCH v2 00/16] AHCI: tracing improvements
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
> From https://github.com/patchew-project/qemu
>  t [tag update]            patchew/20180531212435.165261-1-eblake@redhat.com -> patchew/20180531212435.165261-1-eblake@redhat.com
>  * [new tag]               patchew/20180531222835.16558-1-jsnow@redhat.com -> patchew/20180531222835.16558-1-jsnow@redhat.com
> Switched to a new branch 'test'
> 9932482af2 ahci: make ahci_mem_write traces more descriptive
> c89f4076bd ahci: delete old host register address definitions
> 70f11b4d95 ahci: adjust ahci_mem_write to work on registers
> c13dce7973 ahci: fix spacing damage on ahci_mem_write
> fab5307968 ahci: make mem_read_32 traces more descriptive
> ace1b4ffac ahci: modify ahci_mem_read_32 to work on register numbers
> 3021a82d31 ahci: fix host register max address
> 3c4808a257 ahci: add host register enumeration
> f57758869b ahci: delete old port register address definitions
> 52d04d9b2c ahci: make port write traces more descriptive
> 08f435fad3 ahci: modify ahci_port_write to use register numbers
> 634c79d46b ahci: combine identical clauses in port write
> 50b162ae60 ahci: fix spacing damage on ahci_port_write
> 5895ec8f28 ahci: make port read traces more descriptive
> 68fd051a9a ahci: modify ahci_port_read to use register numbers
> 0478088585 ahci: add port register enumeration
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/16: ahci: add port register enumeration...
> WARNING: line over 80 characters
> #71: FILE: hw/ide/ahci_internal.h:94:
> +    AHCI_PORT_REG_SCR_NOTIF   = 15, /* PxSNTF: SATA phy register: SNotification */
> 
> total: 0 errors, 1 warnings, 72 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 2/16: ahci: modify ahci_port_read to use register numbers...
> Checking PATCH 3/16: ahci: make port read traces more descriptive...
> Checking PATCH 4/16: ahci: fix spacing damage on ahci_port_write...
> ERROR: spaces required around that '|' (ctx:VxV)
> #83: FILE: hw/ide/ahci.c:316:
> +            (val & ~(PORT_CMD_RO_MASK|PORT_CMD_ICC_MASK));

I'll fix that in this patch.

>                                       ^
> 
> total: 1 errors, 0 warnings, 156 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 5/16: ahci: combine identical clauses in port write...
> Checking PATCH 6/16: ahci: modify ahci_port_write to use register numbers...
> Checking PATCH 7/16: ahci: make port write traces more descriptive...
> Checking PATCH 8/16: ahci: delete old port register address definitions...
> Checking PATCH 9/16: ahci: add host register enumeration...
> Checking PATCH 10/16: ahci: fix host register max address...
> Checking PATCH 11/16: ahci: modify ahci_mem_read_32 to work on register numbers...
> Checking PATCH 12/16: ahci: make mem_read_32 traces more descriptive...
> Checking PATCH 13/16: ahci: fix spacing damage on ahci_mem_write...
> Checking PATCH 14/16: ahci: adjust ahci_mem_write to work on registers...
> Checking PATCH 15/16: ahci: delete old host register address definitions...
> Checking PATCH 16/16: ahci: make ahci_mem_write traces more descriptive...
> WARNING: line over 80 characters
> #18: FILE: hw/ide/ahci.c:497:
> +            qemu_log_mask(LOG_UNIMP, "Attempted write to unimplemented register:"
> 

TIL that my emacs configuration considers column 80 in-bounds.
Fixed.

> total: 0 errors, 1 warnings, 35 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

You're a harsh master, patchew.

--js
