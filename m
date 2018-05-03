Received: from eggs.gnu.org ([2001:4830:134:3::10]:56468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEFXG-0007Ne-B5
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fEFXD-0007GK-8R
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:48:42 -0400
Date: Thu, 3 May 2018 16:48:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180503164827.672675a8.cohuck@redhat.com>
In-Reply-To: <1525271609-2142-1-git-send-email-thuth@redhat.com>
References: <1525271609-2142-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL SUBSYSTEM s390x 00/10] s390-ccw firmware
 update - not for master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>

On Wed,  2 May 2018 16:33:19 +0200
Thomas Huth <thuth@redhat.com> wrote:

> This PULL request is not for master.
> 
> 
>  Hi Cornelia,
> 
> the following changes since commit 052888f043bacb18231046045b1f9cd946703170:
> 
>   hw/s390x: Allow to configure the consoles with the "-serial" parameter (2018-04-30 10:48:29 +0200)
> 
> are available in the git repository at:
> 
>   https://github.com/huth/qemu.git tags/s390x-2018-05-02
> 
> for you to fetch changes up to 312185cf35b5d8454a84c337ef9aadade877fb88:
> 
>   pc-bios/s390: Update firmware images (2018-05-02 15:42:57 +0200)
> 
> ----------------------------------------------------------------
> s390-ccw firmware updates:
> - Improvements to the boot menu (can now handle non-sequential entries)
> - s390-netboot now resets the machine before jumping into the OS kernel
> - s390-netboot now supports indirect loading via .INS files
> - some other minor fixes and clean-ups
> ----------------------------------------------------------------
> 
> Collin Walling (4):
>       pc-bios/s390-ccw: rename MAX_TABLE_ENTRIES to MAX_BOOT_ENTRIES
>       pc-bios/s390-ccw: fix loadparm initialization and int conversion
>       pc-bios/s390-ccw: fix non-sequential boot entries (eckd)
>       pc-bios/s390-ccw: fix non-sequential boot entries (enum)
> 
> Cornelia Huck (1):
>       s390-ccw: force diag 308 subcode to unsigned long
> 
> Thomas Huth (5):
>       pc-bios/s390-ccw: size_t should be unsigned
>       pc-bios/s390-ccw/net: Split up net_load() into init, load and release parts
>       pc-bios/s390-ccw/net: Use diag308 to reset machine before jumping to the OS
>       pc-bios/s390-ccw/net: Add support for .INS config files
>       pc-bios/s390: Update firmware images
> 
>  hw/s390x/ipl.c               |   4 ++
>  pc-bios/s390-ccw.img         | Bin 30520 -> 34568 bytes
>  pc-bios/s390-ccw/Makefile    |   4 +-
>  pc-bios/s390-ccw/bootmap.c   |  79 +++-----------------
>  pc-bios/s390-ccw/bootmap.h   |   6 --
>  pc-bios/s390-ccw/iplb.h      |   3 +-
>  pc-bios/s390-ccw/jump2ipl.c  |  91 +++++++++++++++++++++++
>  pc-bios/s390-ccw/libc.c      |   2 +-
>  pc-bios/s390-ccw/libc.h      |   2 +-
>  pc-bios/s390-ccw/main.c      |  14 ++--
>  pc-bios/s390-ccw/menu.c      |  58 ++++++++++-----
>  pc-bios/s390-ccw/netboot.mak |   3 +-
>  pc-bios/s390-ccw/netmain.c   | 168 +++++++++++++++++++++++++++++++++++--------
>  pc-bios/s390-ccw/s390-ccw.h  |   8 ++-
>  pc-bios/s390-netboot.img     | Bin 83856 -> 87872 bytes
>  15 files changed, 307 insertions(+), 135 deletions(-)
>  create mode 100644 pc-bios/s390-ccw/jump2ipl.c

Thanks, pulled.
