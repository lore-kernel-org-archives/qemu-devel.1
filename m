Received: from eggs.gnu.org ([2001:4830:134:3::10]:55778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnZyN-0004MC-1h
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:38:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnZyL-0006IX-Pk
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 20:38:11 -0400
References: <150422562278.204.10709806603962737796@b5667b65043c>
From: John Snow <jsnow@redhat.com>
Message-ID: <431cc1c3-adaf-0159-93f4-d5ed76aea4b3@redhat.com>
Date: Thu, 31 Aug 2017 20:37:57 -0400
MIME-Version: 1.0
In-Reply-To: <150422562278.204.10709806603962737796@b5667b65043c>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/9] IDE: replace printfs with tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com, f4bug@amsat.org



On 08/31/2017 08:27 PM, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20170901001502.29915-1-jsnow@redhat.com
> Subject: [Qemu-devel] [PATCH v3 0/9] IDE: replace printfs with tracing
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
> From https://github.com/patchew-project/qemu
>  t [tag update]            patchew/1503938283-12404-1-git-send-email-sundeep.lkml@gmail.com -> patchew/1503938283-12404-1-git-send-email-sundeep.lkml@gmail.com
>  t [tag update]            patchew/1504190408-11143-1-git-send-email-thuth@redhat.com -> patchew/1504190408-11143-1-git-send-email-thuth@redhat.com
>  * [new tag]               patchew/20170901001502.29915-1-jsnow@redhat.com -> patchew/20170901001502.29915-1-jsnow@redhat.com
> Switched to a new branch 'test'
> b45bc7135d AHCI: remove DPRINTF macro
> 52a114ea94 AHCI: pretty-print FIS to buffer instead of stderr
> dc1fb9df07 AHCI: Rework IRQ constants
> 01eb2629b7 AHCI: Replace DPRINTF with trace-events
> b64224c313 IDE: replace DEBUG_AIO with trace events
> 0a54222e15 ATAPI: Replace DEBUG_IDE_ATAPI with tracing events
> 1c976d454b IDE: add tracing for data ports
> b46b3c2141 IDE: Add register hints to tracing
> 1da9fe67ec IDE: replace DEBUG_IDE with tracing system
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/9: IDE: replace DEBUG_IDE with tracing system...
> ERROR: spaces required around that '|' (ctx:VxV)
> #143: FILE: hw/ide/core.c:1197:
> +    if (reg_num != 7 && (s->status & (BUSY_STAT|DRQ_STAT))) {

Existing damage, but I suppose I'll fix it since I'm here.

>                                                 ^
> 
> total: 1 errors, 0 warnings, 337 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 2/9: IDE: Add register hints to tracing...
> Checking PATCH 3/9: IDE: add tracing for data ports...
> Checking PATCH 4/9: ATAPI: Replace DEBUG_IDE_ATAPI with tracing events...
> Checking PATCH 5/9: IDE: replace DEBUG_AIO with trace events...
> Checking PATCH 6/9: AHCI: Replace DPRINTF with trace-events...
> ERROR: Hex numbers must be prefixed with '0x'
> #544: FILE: hw/ide/trace-events:91:
> +handle_reg_h2d_fis_pmp(void *s, int port, char b0, char b1, char b2) "ahci(%p)[%d]: Port Multiplier not supported, FIS: 0x%02x-%02x-%02x"
> 

False positive, it's part of a hex sequence so the context is obvious.

> ERROR: Hex numbers must be prefixed with '0x'
> #545: FILE: hw/ide/trace-events:92:
> +handle_reg_h2d_fis_res(void *s, int port, char b0, char b1, char b2) "ahci(%p)[%d]: Reserved flags set in H2D Register FIS, FIS: 0x%02x-%02x-%02x"
> 

Same

> ERROR: Hex numbers must be prefixed with '0x'
> #551: FILE: hw/ide/trace-events:98:
> +handle_cmd_unhandled_fis(void *s, int port, uint8_t b0, uint8_t b1, uint8_t b2) "ahci(%p)[%d]: unhandled FIS type. cmd_fis: 0x%02x-%02x-%02x"
> 

Same

> total: 3 errors, 0 warnings, 496 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 7/9: AHCI: Rework IRQ constants...
> Checking PATCH 8/9: AHCI: pretty-print FIS to buffer instead of stderr...
> WARNING: line over 80 characters
> #52: FILE: hw/ide/ahci.c:1206:
> +            char *pretty_fis = ahci_pretty_buffer_fis(ide_state->io_buffer, 0x10);
> 

Will adjust.

> total: 0 errors, 1 warnings, 60 lines checked
> 
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 9/9: AHCI: remove DPRINTF macro...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
> 
