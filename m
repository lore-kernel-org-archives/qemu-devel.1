Received: from eggs.gnu.org ([2001:4830:134:3::10]:34890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gK32Z-0001Mx-CP
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:13:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gK2tn-0001ss-BO
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:04:13 -0500
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
	<20181102152257.20637-5-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <b77a47ba-d94f-a1d5-4fce-254ed7742970@tuxfamily.org>
Date: Tue, 6 Nov 2018 16:03:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181102152257.20637-5-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 04/10] hw/m68k: add macfb video card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, hpoussin@reactos.org, kraxel@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net, laurent@vivier.eu

On 2018-11-02 16:22, Mark Cave-Ayland wrote:
> From: Laurent Vivier <laurent@vivier.eu>
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  arch_init.c                |   4 +
>  hw/display/Makefile.objs   |   1 +
>  hw/display/macfb.c         | 419 +++++++++++++++++++++++++++++++++++++++++++++
>  include/hw/display/macfb.h |  43 +++++
>  qemu-options.hx            |   2 +-
>  vl.c                       |   3 +-
>  6 files changed, 470 insertions(+), 2 deletions(-)
>  create mode 100644 hw/display/macfb.c
>  create mode 100644 include/hw/display/macfb.h

Again, due to lack of knowledge about the Mac hardware, just a weak:

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
