Received: from eggs.gnu.org ([2001:4830:134:3::10]:35117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqbau-0002lr-QL
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:30:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqbaq-00028t-C0
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:30:44 -0500
Date: Tue, 27 Feb 2018 10:30:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180227103018.38eef220.cohuck@redhat.com>
In-Reply-To: <1519641757-12396-1-git-send-email-thuth@redhat.com>
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL-for-s390x 00/14] s390-ccw firmware update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 26 Feb 2018 11:42:23 +0100
Thomas Huth <thuth@redhat.com> wrote:

>  Hi Cornelia!
> 
> The following changes since commit 0a773d55ac76c5aa89ed9187a3bc5af8c5c2a6d0:
> 
>   maintainers: Add myself as a OpenBSD maintainer (2018-02-23 12:05:07 +0000)
> 
> are available in the git repository at:
> 
>   https://github.com/huth/qemu.git tags/s390-ccw-bios-2018-02-26
> 
> for you to fetch changes up to 9c050f3d15697c4c84c9d6aa7af779a273b71d87:
> 
>   pc-bios/s390: Rebuild the s390x firmware images with the boot menu changes (2018-02-26 11:10:30 +0100)
> 
> ----------------------------------------------------------------
> Boot menu patches by Collin L. Walling
> ----------------------------------------------------------------
> 
> Collin L. Walling (13):
>       s390-ccw: refactor boot map table code
>       s390-ccw: refactor eckd_block_num to use CHS
>       s390-ccw: refactor IPL structs
>       s390-ccw: update libc
>       s390-ccw: move auxiliary IPL data to separate location
>       s390-ccw: parse and set boot menu options
>       s390-ccw: set up interactive boot menu parameters
>       s390-ccw: read stage2 boot loader data to find menu
>       s390-ccw: print zipl boot menu
>       s390-ccw: read user input for boot index via the SCLP console
>       s390-ccw: set cp_receive mask only when needed and consume pending service irqs
>       s390-ccw: use zipl values when no boot menu options are present
>       s390-ccw: interactive boot menu for scsi
> 
> Thomas Huth (1):
>       pc-bios/s390: Rebuild the s390x firmware images with the boot menu changes
> 
>  hw/s390x/ipl.c              |  77 +++++++++++++-
>  hw/s390x/ipl.h              |  31 +++++-
>  pc-bios/s390-ccw.img        | Bin 26416 -> 34568 bytes
>  pc-bios/s390-ccw/Makefile   |   2 +-
>  pc-bios/s390-ccw/bootmap.c  | 184 +++++++++++++++++++++++---------
>  pc-bios/s390-ccw/bootmap.h  |  91 ++++++++++------
>  pc-bios/s390-ccw/iplb.h     |  24 ++++-
>  pc-bios/s390-ccw/libc.c     |  88 ++++++++++++++++
>  pc-bios/s390-ccw/libc.h     |  37 ++++++-
>  pc-bios/s390-ccw/main.c     |  49 ++++++---
>  pc-bios/s390-ccw/menu.c     | 249 ++++++++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/s390-ccw.h |  10 ++
>  pc-bios/s390-ccw/sclp.c     |  39 ++++---
>  pc-bios/s390-ccw/virtio.c   |   2 +-
>  pc-bios/s390-netboot.img    | Bin 83864 -> 83776 bytes
>  15 files changed, 757 insertions(+), 126 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/libc.c
>  create mode 100644 pc-bios/s390-ccw/menu.c
>  mode change 100755 => 100644 pc-bios/s390-netboot.img

Thanks, pulled into s390-next.
