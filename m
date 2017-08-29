Received: from eggs.gnu.org ([2001:4830:134:3::10]:49057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1dmh8R-0003eN-3w
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crobinso@redhat.com>) id 1dmh8O-0004Ch-Ex
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 10:04:55 -0400
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
From: Cole Robinson <crobinso@redhat.com>
Message-ID: <8d0b77ca-fb3a-eead-2426-f25788e47893@redhat.com>
Date: Tue, 29 Aug 2017 10:04:49 -0400
MIME-Version: 1.0
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/79] Patch Round-up for stable 2.9.1,
 freeze on 2017-09-04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

On 08/28/2017 08:13 PM, Michael Roth wrote:
> Hi everyone,
> 
> The following new patches are queued for QEMU stable v2.9.1:
> 
>   https://github.com/mdroth/qemu/commits/stable-2.9-staging
> 
> The release is planned for 2017-09-07:
> 
>   http://wiki.qemu.org/Planning/2.9
> 
> Please respond here or CC qemu-stable@nongnu.org on any patches you
> think should be included in the release.
> 

Here's extra patches we are carrying for Fedora 26:

Applying: vmw_pvscsi: check message ring page count at initialisation
Applying: audio: release capture buffers
Applying: scsi: avoid an off-by-one error in megasas_mmio_write
Applying: 9pfs: local: forbid client access to metadata (CVE-2017-7493)
Applying: megasas: do not read sense length more than once from frame
Applying: megasas: do not read iovec count more than once from frame
Applying: megasas: do not read DCMD opcode more than once from frame
Applying: megasas: do not read command more than once from frame
Applying: megasas: do not read SCSI req parameters more than once from frame
Applying: megasas: always store SCSIRequest* into MegasasCmd
Applying: usb-redir: fix stack overflow in usbredir_log_data
Applying: qemu-nbd: Ignore SIGPIPE
Applying: vnc: Set default kbd delay to 10ms


The last one was part of agraf's input fixes, not sure if it's strictly
required to fix the root issue but when all 3 patches were applied it fixed
fedora's automated QA system.

The rest of the patches are for CVEs but not sure about the severity

Thanks,
Cole
