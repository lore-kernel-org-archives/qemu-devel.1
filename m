Received: from eggs.gnu.org ([2001:4830:134:3::10]:45134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7y1b-0008IY-1c
	for qemu-devel@nongnu.org; Tue, 09 May 2017 01:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1d7y1X-0006bu-PB
	for qemu-devel@nongnu.org; Tue, 09 May 2017 01:49:31 -0400
References: <20170508205735.23444-1-ehabkost@redhat.com>
	<20170508205735.23444-2-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2f7b9e2e-dca4-6ab4-26db-275ed6f60d6f@redhat.com>
Date: Tue, 9 May 2017 07:49:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170508205735.23444-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 1/3] audio: Move arch_init
 audio code to hw/audio/soundhw.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: hpoussin@reactos.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, david@gibson.dropbear.id.au

On 08.05.2017 22:57, Eduardo Habkost wrote:
> There's no reason to keep the soundhw table in arch_init.c. Move
> that code to a new hw/audio/soundhw.c file.
> 
> While moving the code, trivial coding style issues were fixed.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Update hw/ppc/prep.c to include hw/audio/audio.h too
> 
> Changes v1 -> v2:
> * Rebase to latest qemu.git master
> ---
>  include/hw/audio/audio.h   |   3 +
>  include/sysemu/arch_init.h |   2 -
>  arch_init.c                | 124 -----------------------------------
>  hw/audio/soundhw.c         | 156 +++++++++++++++++++++++++++++++++++++++++++++
>  hw/ppc/prep.c              |   1 +
>  vl.c                       |   1 +
>  hw/audio/Makefile.objs     |   2 +
>  7 files changed, 163 insertions(+), 126 deletions(-)
>  create mode 100644 hw/audio/soundhw.c

Good idea!

Reviewed-by: Thomas Huth <thuth@redhat.com>
