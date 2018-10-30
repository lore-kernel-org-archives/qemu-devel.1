Received: from eggs.gnu.org ([2001:4830:134:3::10]:38382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNnh-0003ue-7B
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNnf-0003Am-4A
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:46:52 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <2c72c6f1-a167-e325-68c6-f6265bbce03d@reactos.org>
Date: Tue, 30 Oct 2018 07:46:26 +0100
MIME-Version: 1.0
In-Reply-To: <20181029134000.11157-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 03/11] escc: introduce a selector for
 the register bit
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
> On Sparc and PowerMac, the bit 0 of the address
> selects the register type (control or data) and
> bit 1 selects the channel (B or A).
> 
> On m68k Macintosh, the bit 0 selects the channel and
> bit 1 the register type.
> 
> This patch introduces a new parameter (bit_swap) to
> the device interface to indicate bits usage must
> be swapped between registers and channels.
> 
> For the moment all the machines use the bit 0,
> but this change will be needed to emulate Quadra 800.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/char/escc.c         | 30 ++++++++++++++++++++++++------
>   include/hw/char/escc.h |  1 +
>   2 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
