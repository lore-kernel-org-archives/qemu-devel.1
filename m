Received: from eggs.gnu.org ([2001:4830:134:3::10]:51378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eekk9-0003ff-0N
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eekk5-0004wC-St
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:17 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:40628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eekk5-0004vd-PF
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:13 -0500
Received: by mail-qt0-x243.google.com with SMTP id s39so20801486qth.7
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 08:51:13 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180125164351.17154-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7a1afea-408f-3ecf-7aac-ed5cfd9f1bc9@amsat.org>
Date: Thu, 25 Jan 2018 13:51:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180125164351.17154-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20180125 v2 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 01/25/2018 01:43 PM, Gerd Hoffmann wrote:
> The following changes since commit 834a336eb911db8a8ca00e760ee6a85faca19414:
> 
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-01-24 19:24:26 +0000)
> 
> are available in the git repository at:
> 
>   git://git.kraxel.org/qemu tags/usb-20180125-v2-pull-request
> 
> for you to fetch changes up to 112d9cb43c70658b890559ff6dcfc5d9e821f368:
> 
>   usb-storage: Fix share-rw option parsing (2018-01-25 17:26:07 +0100)
> 
> ----------------------------------------------------------------
> usb: -usbdevice cleanups, storage fix, ccid cleanup.
> 
> ----------------------------------------------------------------
> 
> Fam Zheng (1):
>   usb-storage: Fix share-rw option parsing
> 
> Mao Zhongyi (1):
>   hw/usb/ccid: Make ccid_card_init() take an error parameter

NACK s->card not set in ccid_card_realize() ?

> 
> Thomas Huth (1):
>   usb: Remove legacy -usbdevice options (host, serial, disk and net)
> 
>  hw/usb/ccid.h                 |   2 +-
>  include/hw/scsi/scsi.h        |   1 +
>  include/hw/usb.h              |   1 -
>  hw/scsi/scsi-bus.c            |   9 ++-
>  hw/usb/ccid-card-emulated.c   |  44 ++++++-------
>  hw/usb/ccid-card-passthru.c   |  12 ++--
>  hw/usb/dev-network.c          |  26 --------
>  hw/usb/dev-serial.c           |  30 ---------
>  hw/usb/dev-smartcard-reader.c |  34 +++++-----
>  hw/usb/dev-storage.c          |  61 +-----------------
>  hw/usb/host-legacy.c          | 144 ------------------------------------------
>  hw/usb/host-stub.c            |   6 --
>  vl.c                          |  15 -----
>  hw/usb/Makefile.objs          |   2 +-
>  qemu-options.hx               |  19 ------
>  15 files changed, 60 insertions(+), 346 deletions(-)
>  delete mode 100644 hw/usb/host-legacy.c
> 
