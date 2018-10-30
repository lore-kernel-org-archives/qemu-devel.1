Received: from eggs.gnu.org ([2001:4830:134:3::10]:38549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNnx-00042n-J0
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNnw-0003W9-Pf
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:47:09 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <e361c22a-3a0e-6e28-ef03-8a527798836c@reactos.org>
Date: Tue, 30 Oct 2018 07:46:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181029134000.11157-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/11] hw/m68k: Apple Sound Chip (ASC)
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

Le 29/10/2018 à 14:39, Mark Cave-Ayland a écrit :
> From: Laurent Vivier <laurent@vivier.eu>
> 
> This is broken as the linux driver seems broken too...
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/audio/Makefile.objs |   1 +
>   hw/audio/asc.c         | 446 +++++++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/audio/asc.h |  48 ++++++
>   3 files changed, 495 insertions(+)
>   create mode 100644 hw/audio/asc.c
>   create mode 100644 include/hw/audio/asc.h

According to above comment, this device is broken.
Is it necessary for Q800 emulation? What happens if you remove it?
