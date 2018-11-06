Received: from eggs.gnu.org ([2001:4830:134:3::10]:44526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gK3VI-0007DA-E0
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:42:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gK3VH-0006bg-Hq
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 10:42:56 -0500
References: <20181102152257.20637-1-mark.cave-ayland@ilande.co.uk>
	<20181102152257.20637-7-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <f23c62b9-b1a5-d7c9-c9cf-b892dc247e10@tuxfamily.org>
Date: Tue, 6 Nov 2018 16:42:46 +0100
MIME-Version: 1.0
In-Reply-To: <20181102152257.20637-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 06/10] hw/m68k: add Nubus support
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
> ---
>  hw/Makefile.objs                    |   1 +
>  hw/nubus/Makefile.objs              |   4 +
>  hw/nubus/mac-nubus-bridge.c         |  45 ++++++++
>  hw/nubus/nubus-bridge.c             |  34 ++++++
>  hw/nubus/nubus-bus.c                | 111 +++++++++++++++++++
>  hw/nubus/nubus-device.c             | 215 ++++++++++++++++++++++++++++++++++++
>  include/hw/nubus/mac-nubus-bridge.h |  24 ++++
>  include/hw/nubus/nubus.h            |  69 ++++++++++++
>  8 files changed, 503 insertions(+)
>  create mode 100644 hw/nubus/Makefile.objs
>  create mode 100644 hw/nubus/mac-nubus-bridge.c
>  create mode 100644 hw/nubus/nubus-bridge.c
>  create mode 100644 hw/nubus/nubus-bus.c
>  create mode 100644 hw/nubus/nubus-device.c
>  create mode 100644 include/hw/nubus/mac-nubus-bridge.h
>  create mode 100644 include/hw/nubus/nubus.h

Reviewed-by: Thomas Huth <huth@tuxfamily.org>
