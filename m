Received: from eggs.gnu.org ([2001:4830:134:3::10]:59118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVbDh-0005AA-40
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVbDd-00084E-5o
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:19:41 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVbDd-000843-2D
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:19:37 -0400
Received: by mail-qt0-x244.google.com with SMTP id v31so5418021qtb.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:19:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170621043401.19842-1-hpoussin@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fda3e878-cad0-b5d7-ade7-11fdf77197f5@amsat.org>
Date: Thu, 13 Jul 2017 07:19:33 -0300
MIME-Version: 1.0
In-Reply-To: <20170621043401.19842-1-hpoussin@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] Support multiple adlib sound cards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 06/21/2017 01:33 AM, Hervé Poussineau wrote:
> Hi,
> 
> This patchset removes a global variable in adlib emulation, and allows to
> have multiple adlib sound cards.
> Note that indentation seem off because I have replaced some tabulations by spaces.
> 
> Before:
> qemu-system-i386 -device adlib,iobase=0x220 -device adlib,iobase=0x240
> qemu-system-i386: -device adlib,iobase=0x240: Cannot create more than 1 adlib device
> 
> After:
> qemu-system-i386 -device adlib,iobase=0x220 -device adlib,iobase=0x240
> Machine starts.
> 
> Hervé
> 
> Hervé Poussineau (2):
>    audio/fmopl: modify timer callback to give opaque and channel
>      parameters in two arguments
>    audio/adlib: remove limitation of one adlib card

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>   hw/audio/adlib.c | 14 +++-----------
>   hw/audio/fmopl.c | 18 +++++++++++++-----
>   hw/audio/fmopl.h |  7 ++++---
>   3 files changed, 20 insertions(+), 19 deletions(-)
> 
