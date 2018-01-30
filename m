Received: from eggs.gnu.org ([2001:4830:134:3::10]:43718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egYkL-0007xU-Ld
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1egYkH-0003o1-LW
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:26:57 -0500
Date: Tue, 30 Jan 2018 17:26:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180130162638.GB4503@localhost.localdomain>
References: <20180130062503.32596-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130062503.32596-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Fix CID for VMDK afl image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 30.01.2018 um 07:25 hat Fam Zheng geschrieben:
> This reverts commit 76bf133c4 which updated the reference output, and
> fixed the reference image, because the code path we want to exercise is
> actually the invalid image size.
> 
> The descriptor block in the image, which includes the CID to verify, has been
> invalid since the reference image was added. Since commit 9877860e7bd we report
> this error earlier than the "file too large", so 059.out mismatches.
> 
> The binary change is generated along the operations of:
> 
>   $ bunzip2 afl9.vmdk.bz2
>   $ qemu-img create -f vmdk fix.vmdk 1G
>   $ dd if=afl9.vmdk.bz2 of=fix.vmdk bs=512 count=1 conv=notrunc
>   $ mv fix.vmdk afl9.vmdk
>   $ bzip2 afl9.vmdk
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Thanks, applied to the block branch.

Kevin
