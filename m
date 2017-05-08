Received: from eggs.gnu.org ([2001:4830:134:3::10]:45745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1d7Y0U-0006QT-5C
	for qemu-devel@nongnu.org; Sun, 07 May 2017 22:02:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1d7Y0P-0002BT-Ay
	for qemu-devel@nongnu.org; Sun, 07 May 2017 22:02:38 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1d7Y0P-0002BO-41
	for qemu-devel@nongnu.org; Sun, 07 May 2017 22:02:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id d127so3939980wmf.1
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 19:02:32 -0700 (PDT)
References: <CADmzSSjY4n7bBBUVk45=_SRSj74AkSpN3O1d61Cik1q-eDiHKQ@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <83bb9749-ae49-3b26-dca8-3e600cf041d6@tuxfamily.org>
Date: Mon, 8 May 2017 04:02:19 +0200
MIME-Version: 1.0
In-Reply-To: <CADmzSSjY4n7bBBUVk45=_SRSj74AkSpN3O1d61Cik1q-eDiHKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] boot order=d bug?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carl Karsten <carl@personnelware.com>, qemu-devel@nongnu.org

On 07.05.2017 07:42, Carl Karsten wrote:
> In the real world I will have a machine with a sata hd and boot the
> installer from a usb stick. I want to test this with 2 disk image files.
> 
> The usb stick will be built like so:
> https://github.com/CarlFK/video-stack-deploy/blob/usbstick/scripts/mk_usb_installer.sh
> 
> but this will demo the problem I have run into with qemu:  how do I boot
> from boot.img without using boot=menu?

Have you already tried to use the bootindex property? See:

http://git.qemu.org/?p=qemu.git;a=blob;f=docs/bootindex.txt

 Thomas
