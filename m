Received: from eggs.gnu.org ([2001:4830:134:3::10]:47477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fRZfH-0006nb-8C
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 04:56:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1fRZfG-0006n9-IT
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 04:56:03 -0400
References: <20180608200558.386-1-laurent@vivier.eu>
	<20180608200558.386-14-laurent@vivier.eu>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <484ec115-91b9-8fce-d62a-0dc80e1a03be@reactos.org>
Date: Sat, 9 Jun 2018 10:55:55 +0200
MIME-Version: 1.0
In-Reply-To: <20180608200558.386-14-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 13/13] dp8393x: fix receiving buffer
 exhaustion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Le 08/06/2018 à 22:05, Laurent Vivier a écrit :
> The card is not able to exit from exhaustion state, because
> while the drive consumes the buffers, the RRP is incremented
> (when the driver clears the ISR RBE bit), so it stays equal
> to RWP, and while RRP == RWP, the card thinks it is always
> in exhaustion state. So the driver consumes all the buffers,
> but the card cannot receive new ones.
> 
> This patch fixes the problem by not incrementing RRP when
> the driver clears the ISR RBE bit.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/net/dp8393x.c | 31 ++++++++++++++++---------------
>   1 file changed, 16 insertions(+), 15 deletions(-)
> 

Works OK on NetBSD 5.1/arc on MIPS Magnum.

Tested-by: Hervé Poussineau <hpoussin@reactos.org>
