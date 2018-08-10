Received: from eggs.gnu.org ([2001:4830:134:3::10]:49511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fo6yn-00017L-JT
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fo6yj-0002cV-CC
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 08:57:21 -0400
Date: Fri, 10 Aug 2018 09:57:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180810125713.GS15372@localhost.localdomain>
References: <20180810124027.10698-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810124027.10698-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: ignore suffixes in the bootdevice
 list dependent on machine class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com, marcel.apfelbaum@gmail.com, arei.gonglei@huawei.com, david@gibson.dropbear.id.au

On Fri, Aug 10, 2018 at 01:40:27PM +0100, Mark Cave-Ayland wrote:
> For the older machines (such as Mac and SPARC) the DT nodes representing
> bootdevices for disk nodes are irregular for mainly historical reasons.
> 
> Since the majority of bootdevice nodes for these machines either do not have a
> separate disk node or require different (custom) names then it is much easier
> for processing to just disable all suffixes for a particular machine.
> 
> Introduce a new ignore_boot_device_suffixes MachineClass property to control
> bootdevice suffix generation, defaulting to false in order to preserve
> compatibility.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Thanks, I'm queueing this for 3.1:
  https://github.com/ehabkost/qemu.git machine-for-3.1

-- 
Eduardo
