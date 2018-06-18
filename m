Received: from eggs.gnu.org ([2001:4830:134:3::10]:36758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fUwYd-0007UM-4G
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:59:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fUwYZ-00040Z-Sl
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 11:59:07 -0400
Date: Mon, 18 Jun 2018 17:59:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180618175900.78578175.cohuck@redhat.com>
In-Reply-To: <1529330893-12180-1-git-send-email-thuth@redhat.com>
References: <1529330893-12180-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL SUBSYSTEM s390x v2 0/7] pxelinux.cfg-style
 booting for the s390x bios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

On Mon, 18 Jun 2018 16:08:12 +0200
Thomas Huth <thuth@redhat.com> wrote:

> This PULL request is not for master.
> 
> 
>  Hi Cornelia,
> 
> the following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268e2:
> 
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-request' into staging (2018-06-12 15:34:34 +0100)
> 
> are available in the git repository at:
> 
>   https://gitlab.com/huth/qemu.git tags/s390x-2018-06-18
> 
> for you to fetch changes up to 4046826d46618ef7eb11df41fe8878669ce6991c:
> 
>   pc-bios/s390-ccw: Update the s390-netboot.img binary (2018-06-18 15:24:44 +0200)
> 
> ----------------------------------------------------------------
> Add support for pxelinux.cfg-style network booting to the s390x firmware
> ----------------------------------------------------------------
> 
> Collin Walling (1):
>       pc-bios/s390-ccw: define loadparm length
> 
> Thomas Huth (6):
>       roms: Update SLOF submodule to current status
>       pc-bios/s390-ccw/net: Update code for the latest changes in SLOF
>       pc-bios/s390-ccw/net: Add support for pxelinux-style config files
>       pc-bios/s390-ccw/net: Try to load pxelinux.cfg file accoring to the UUID
>       pc-bios/s390-ccw: Optimize the s390-netboot.img for size
>       pc-bios/s390-ccw: Update the s390-netboot.img binary
> 
>  pc-bios/s390-ccw/Makefile    |   1 +
>  pc-bios/s390-ccw/iplb.h      |   4 +-
>  pc-bios/s390-ccw/main.c      |   8 +-
>  pc-bios/s390-ccw/netboot.mak |  13 +--
>  pc-bios/s390-ccw/netmain.c   | 226 +++++++++++++++++++++++++++++--------------
>  pc-bios/s390-ccw/sclp.c      |   2 +-
>  pc-bios/s390-ccw/sclp.h      |   2 +-
>  pc-bios/s390-netboot.img     | Bin 87872 -> 54944 bytes
>  roms/SLOF                    |   2 +-
>  9 files changed, 174 insertions(+), 84 deletions(-)

Thanks, pulled.
