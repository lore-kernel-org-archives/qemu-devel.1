Received: from eggs.gnu.org ([2001:4830:134:3::10]:57340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJpY-0001Tk-Vb
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:09:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1etJpX-0007WT-NR
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 16:09:04 -0500
References: <152036996711.1413.5381428549955473097@bdbb90650ae5>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5906b289-d149-10fd-b32d-911d67d7ba29@ilande.co.uk>
Date: Tue, 6 Mar 2018 21:08:44 +0000
MIME-Version: 1.0
In-Reply-To: <152036996711.1413.5381428549955473097@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/19] uninorth fixes/mac_newworld board
 wiring improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 06/03/18 20:59, no-reply@patchew.org wrote:

> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Type: series
> Message-id: 20180306203103.25563-1-mark.cave-ayland@ilande.co.uk
> Subject: [Qemu-devel] [PATCH 00/19] uninorth fixes/mac_newworld board wiring improvements
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
>      echo "Checking PATCH $n/$total: $(git log -n 1 --format=%s $c)..."
>      if ! git show $c --format=email | ./scripts/checkpatch.pl --mailback -; then
>          failed=1
>          echo
>      fi
>      n=$((n+1))
> done
> 
> exit $failed
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>  From https://github.com/patchew-project/qemu
>   * [new tag]               patchew/20180306203103.25563-1-mark.cave-ayland@ilande.co.uk -> patchew/20180306203103.25563-1-mark.cave-ayland@ilande.co.uk
> Switched to a new branch 'test'
> e7f510fb1c mac_newworld: move wiring of macio IRQs to macio_newworld_realize()
> e1cb6af9a4 mac_newworld: remove pics IRQ array and wire up macio to OpenPIC directly
> cf16eb0223 uninorth: create new uninorth device
> 9a29524fc9 uninorth: rename UNINState to UNINHostState
> bd3653709a uninorth: move PCI IO (ISA) memory region into the uninorth device
> f1020004d7 uninorth: use object link to pass OpenPIC object to uninorth
> 000b78ebf1 uninorth: remove obsolete pci_pmac_u3_init() function
> 019ce970d1 uninorth: remove obsolete pci_pmac_init() function
> d74cd9a986 uninorth: enable internal PCI host bridge
> eb2d8bcf25 uninorth: fix PCI and AGP bus mixup
> a444eabfcb uninorth: move PCI host bridge bus initialisation into device realize
> 6401c9c37f uninorth: introduce temporary pic_irqs device property
> 0f5fb4ec70 uninorth: move PCI mmio memory region initialisation into init function
> 2f7a628836 uninorth: alter pci_pmac_init() and pci_pmac_u3_init() to return uninorth device
> 780535bf21 uninorth: move uninorth definitions into uninorth.h
> d8816bc167 uninorth: remove stray PCIBus realize from mac_newworld.c
> f82a1a6d5c uninorth: QOMify PCI and AGP host bridges
> a0c06c803b uninorth: remove second set of uninorth token registers
> 4baa7ecf3b uninorth: trivial style fixups
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/19: uninorth: trivial style fixups...
> Checking PATCH 2/19: uninorth: remove second set of uninorth token registers...
> Checking PATCH 3/19: uninorth: QOMify PCI and AGP host bridges...
> Checking PATCH 4/19: uninorth: remove stray PCIBus realize from mac_newworld.c...
> Checking PATCH 5/19: uninorth: move uninorth definitions into uninorth.h...
> Checking PATCH 6/19: uninorth: alter pci_pmac_init() and pci_pmac_u3_init() to return uninorth device...
> Checking PATCH 7/19: uninorth: move PCI mmio memory region initialisation into init function...
> Checking PATCH 8/19: uninorth: introduce temporary pic_irqs device property...
> Checking PATCH 9/19: uninorth: move PCI host bridge bus initialisation into device realize...
> ERROR: if this code is redundant consider removing it
> #41: FILE: hw/pci-host/uninorth.c:127:
> +#if 0
> 
> total: 1 errors, 0 warnings, 221 lines checked

This is a false alarm since this #if 0 ... #endif block is removed in 
patch 11.

> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> Checking PATCH 10/19: uninorth: fix PCI and AGP bus mixup...
> Checking PATCH 11/19: uninorth: enable internal PCI host bridge...
> Checking PATCH 12/19: uninorth: remove obsolete pci_pmac_init() function...
> Checking PATCH 13/19: uninorth: remove obsolete pci_pmac_u3_init() function...
> Checking PATCH 14/19: uninorth: use object link to pass OpenPIC object to uninorth...
> Checking PATCH 15/19: uninorth: move PCI IO (ISA) memory region into the uninorth device...
> Checking PATCH 16/19: uninorth: rename UNINState to UNINHostState...
> Checking PATCH 17/19: uninorth: create new uninorth device...
> Checking PATCH 18/19: mac_newworld: remove pics IRQ array and wire up macio to OpenPIC directly...
> Checking PATCH 19/19: mac_newworld: move wiring of macio IRQs to macio_newworld_realize()...
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org


ATB,

Mark.
