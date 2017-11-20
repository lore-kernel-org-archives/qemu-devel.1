Received: from eggs.gnu.org ([2001:4830:134:3::10]:50570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGds9-0006l5-Ul
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 23:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eGds6-0008Ts-1y
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 23:39:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eGds5-0008Tb-Re
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 23:39:49 -0500
References: <151114945961.516.12961636629059722792@bafd83ae6430>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7970693-0e13-0028-5e1d-a0e303d4cfe3@redhat.com>
Date: Mon, 20 Nov 2017 05:39:43 +0100
MIME-Version: 1.0
In-Reply-To: <151114945961.516.12961636629059722792@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/6] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, jasowang@redhat.com
Cc: peter.maydell@linaro.org, famz@redhat.com

On 20.11.2017 04:44, no-reply@patchew.org wrote:
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Subject: [Qemu-devel] [PULL 0/6] Net patches
> Type: series
> Message-id: 1511148687-24909-1-git-send-email-jasowang@redhat.com
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
>  t [tag update]            patchew/1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk -> patchew/1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk
>  * [new tag]               patchew/1511148687-24909-1-git-send-email-jasowang@redhat.com -> patchew/1511148687-24909-1-git-send-email-jasowang@redhat.com
> Switched to a new branch 'test'
> 6d998dcb3e hw/net/vmxnet3: Fix code to work on big endian hosts, too
> e3b7d3045b net: Transmit zero UDP checksum as 0xFFFF
> 528693e2ba MAINTAINERS: Add missing entry for eepro100 emulation
> 434d3f0987 hw/net/eepro100: Fix endianness problem on big endian hosts
> c2e0b52dd7 Revert "Add new PCI ID for i82559a"
> 3e70742c2d colo-compare: fix the dangerous assignment
> 
> === OUTPUT BEGIN ===
> Checking PATCH 1/6: colo-compare: fix the dangerous assignment...
> Checking PATCH 2/6: Revert "Add new PCI ID for i82559a"...
> Checking PATCH 3/6: hw/net/eepro100: Fix endianness problem on big endian hosts...
> Checking PATCH 4/6: MAINTAINERS: Add missing entry for eepro100 emulation...
> Checking PATCH 5/6: net: Transmit zero UDP checksum as 0xFFFF...
> Checking PATCH 6/6: hw/net/vmxnet3: Fix code to work on big endian hosts, too...
> ERROR: spaces required around that ':' (ctx:VxV)
> #237: FILE: hw/net/vmxnet3.h:232:
> +            u32 msscof:14;  /* MSS, checksum offset, flags */
>                        ^
> 
> ERROR: spaces required around that ':' (ctx:VxV)
> #238: FILE: hw/net/vmxnet3.h:233:
> +            u32 ext1:1;
>                      ^

Just for the records (again): These errors seem to be false positives
from checkpatch. I originally tried to add spaces to all changed
bitfields, but then checkpatch suddenly complains that spaces are not
allowed there...

 Thomas
