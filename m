Received: from eggs.gnu.org ([2001:4830:134:3::10]:36854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cQUcV-0002lw-Ve
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:43:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cQUcU-0003dp-L3
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 02:43:56 -0500
References: <1483802623-5507-1-git-send-email-hpoussin@reactos.org>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <317d34e8-a3fa-2748-1245-3f8555d0738b@tuxfamily.org>
Date: Mon, 9 Jan 2017 08:43:47 +0100
MIME-Version: 1.0
In-Reply-To: <1483802623-5507-1-git-send-email-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 0/4] ppc: add a IBM 40p
 machine (RS/6000, PReP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Giancarlo Teodori <gteodori@gmail.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 07.01.2017 16:23, Hervé Poussineau wrote:
> Hi,
> 
> This patchset adds the emulation of the IBM RS/6000 7020 (40p). The real machine is
> able to run AIX (up to 4.3.3), Windows NT (up to 4.0 SP1), the beta of OS/2 PowerPC,
> Solaris, Linux, NetBSD/PReP ...
> 
> I've tested current emulation with Open Hack'Ware, OpenBIOS and official firmware.
> 
> Linux kernel starts, and freezes during boot (seems like a problem with the SCSI adapter).
> Windows NT starts up to the point where it wants to change endianness.
> Other OSes have not been tested.
> 
> This machine is a superset of the 'prep' one, because we know exactly what is/should
> emulated, and that operating system list running on it is quite wide.
> I hope that 'prep' machine can be deprecated soon and then later removed.
> 
> Patch 1 is a cleanup, and can probably be committed first.
> Patches 2 to 4  are the real implementation of the IBM 40p.
> 
> Changes since v2:
> - patch 2: fix mismatch between read and write functions for port 92
> - patch 4: use error_report instead of fprintf/hw_error
> 
> Changes since v1:
> - removed patches related to display adapter:
>   Let's wait for an emulation of the real display adapter (an S3 Trio), as current
>   VGA adapter already mostly works with Open Hack'Ware and OpenBIOS
> - various changes due to David Gibson's remarks
> 
> Hervé Poussineau (4):
>   prep: do not use global variable to access nvram
>   prep: add PReP System I/O
>   prep: add IBM RS/6000 7020 (40p) memory controller
>   prep: add IBM RS/6000 7020 (40p) machine emulation
> 
>  default-configs/ppc-softmmu.mak |   2 +
>  hw/ppc/Makefile.objs            |   2 +
>  hw/ppc/prep.c                   | 233 +++++++++++++++++++++++++++++-
>  hw/ppc/prep_systemio.c          | 303 ++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/rs6000_mc.c              | 232 ++++++++++++++++++++++++++++++
>  hw/ppc/trace-events             |  11 ++
>  6 files changed, 781 insertions(+), 2 deletions(-)
>  create mode 100644 hw/ppc/prep_systemio.c
>  create mode 100644 hw/ppc/rs6000_mc.c

By the way, the PReP machine currently does not have a proper maintainer
according to the MAINTAINERS file ... would you maybe volunteer to do
that job? If so, could you please send a patch for the MAINTAINERS file?

 Thomas
