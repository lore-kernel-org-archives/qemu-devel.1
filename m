Received: from eggs.gnu.org ([2001:4830:134:3::10]:38585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAhcY-0002yd-Q1
	for qemu-devel@nongnu.org; Tue, 16 May 2017 14:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dAhcU-0003zI-0B
	for qemu-devel@nongnu.org; Tue, 16 May 2017 14:54:58 -0400
Date: Tue, 16 May 2017 15:54:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170516185435.GB22043@thinpad.lan.raisama.net>
References: <20170508205735.23444-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170508205735.23444-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] arch_init: Move soundhw code to
 hw/audio/soundhw.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: hpoussin@reactos.org, agraf@suse.de, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, david@gibson.dropbear.id.au

Ping?

On Mon, May 08, 2017 at 05:57:32PM -0300, Eduardo Habkost wrote:
> Changes v2 -> v3:
> * Build fix: update hw/ppc/prep.c too
> 
> Changes v1 -> v2:
> * Rebase to latest qemu.git master
> 
> This moves the arch_init.c soundhw code to its own file, renames
> audio_init() to soundhw_init(), and renames hw/audio/audio.h to
> hw/audio/soundhw.h.
> 
> Eduardo Habkost (3):
>   audio: Move arch_init audio code to hw/audio/soundhw.c
>   audio: Rename audio_init() to soundhw_init()
>   audio: Rename hw/audio/audio.h to hw/audio/soundhw.h
> 
>  include/hw/audio/{audio.h => soundhw.h} |   3 +
>  include/sysemu/arch_init.h              |   2 -
>  arch_init.c                             | 126 +-------------------------
>  hw/audio/ac97.c                         |   2 +-
>  hw/audio/adlib.c                        |   2 +-
>  hw/audio/cs4231a.c                      |   2 +-
>  hw/audio/es1370.c                       |   2 +-
>  hw/audio/gus.c                          |   2 +-
>  hw/audio/intel-hda.c                    |   2 +-
>  hw/audio/pcspk.c                        |   2 +-
>  hw/audio/sb16.c                         |   2 +-
>  hw/audio/soundhw.c                      | 156 ++++++++++++++++++++++++++++++++
>  hw/ppc/prep.c                           |   3 +-
>  vl.c                                    |   3 +-
>  hw/audio/Makefile.objs                  |   2 +
>  15 files changed, 174 insertions(+), 137 deletions(-)
>  rename include/hw/audio/{audio.h => soundhw.h} (81%)
>  create mode 100644 hw/audio/soundhw.c
> 
> -- 
> 2.11.0.259.g40922b1
> 
> 

-- 
Eduardo
