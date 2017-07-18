Received: from eggs.gnu.org ([2001:4830:134:3::10]:44590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXa62-0005dF-NM
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:31:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXa5z-0000n3-In
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:31:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dXa5z-0000mm-Ar
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:31:55 -0400
References: <150041326971.87.12063267116194376637@5d477a5b5989>
From: John Snow <jsnow@redhat.com>
Message-ID: <1a41e3de-f111-da01-bfa5-4b92d60b451f@redhat.com>
Date: Tue, 18 Jul 2017 17:31:51 -0400
MIME-Version: 1.0
In-Reply-To: <150041326971.87.12063267116194376637@5d477a5b5989>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/4] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, peter.maydell@linaro.org



On 07/18/2017 05:27 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PULL 0/4] Ide patches
> Message-id: 20170718161230.21917-1-jsnow@redhat.com
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
> 02dcdb3 tests/ahci-test: Be mean with RAM
> e94eb50 ahci: split public and private interface
> cb2c639 ahci: Isolate public AHCI interface
> d77a741 ahci: add ahci_get_num_ports
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/4: ahci: add ahci_get_num_ports...
> Checking PATCH 2/4: ahci: Isolate public AHCI interface...
> ERROR: spaces required around that '/' (ctx:VxV)
> #221: FILE: include/hw/ide/ahci_public.h:88:
> +    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
>                                            ^
> 
> total: 1 errors, 0 warnings, 189 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 3/4: ahci: split public and private interface...
> ERROR: spaces required around that '/' (ctx:VxV)
> #800: FILE: include/hw/ide/ahci.h:88:
> +    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
>                                            ^
> 
> total: 1 errors, 0 warnings, 760 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 4/4: tests/ahci-test: Be mean with RAM...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
> 

IMO, false positive on code movement, but I could fix this up if desired.

--js
