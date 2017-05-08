Received: from eggs.gnu.org ([2001:4830:134:3::10]:39200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1d7dXj-0000JD-C8
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1d7dXg-0001u8-78
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:57:19 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1d7dXg-0001u0-0B
	for qemu-devel@nongnu.org; Mon, 08 May 2017 03:57:16 -0400
Received: by mail-wr0-f193.google.com with SMTP id w50so7196420wrc.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 00:57:15 -0700 (PDT)
References: <CADmzSSjY4n7bBBUVk45=_SRSj74AkSpN3O1d61Cik1q-eDiHKQ@mail.gmail.com>
	<83bb9749-ae49-3b26-dca8-3e600cf041d6@tuxfamily.org>
	<CADmzSSibDhGEExf2JSC9r1Nh7MZpCP34buM+Nv5DWmAg1NHMZQ@mail.gmail.com>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <190f37d9-e18b-2be4-8579-043180b14ac7@tuxfamily.org>
Date: Mon, 8 May 2017 09:57:13 +0200
MIME-Version: 1.0
In-Reply-To: <CADmzSSibDhGEExf2JSC9r1Nh7MZpCP34buM+Nv5DWmAg1NHMZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] boot order=d bug?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Carl Karsten <carl@personnelware.com>
Cc: qemu-devel@nongnu.org

On 08.05.2017 06:22, Carl Karsten wrote:
> neat.  missed that.
> 
> except it doesn't work.
> 
> juser@gator:~/temp$ qemu-system-x86_64 -drive
> file=boot.img,format=raw,bootindex=1
> qemu-system-x86_64: -drive file=boot.img,format=raw,bootindex=1: Block
> format 'raw' does not support the option 'bootindex'

bootindex is a property of the "-device" parameter, not of "-drive", so
you've got to specify both parameters here (with "if=none" for -drive).
See bootindex.txt for details.

 Thomas

> On Sun, May 7, 2017 at 9:02 PM, Thomas Huth <huth@tuxfamily.org> wrote:
> 
>> On 07.05.2017 07:42, Carl Karsten wrote:
>>> In the real world I will have a machine with a sata hd and boot the
>>> installer from a usb stick. I want to test this with 2 disk image files.
>>>
>>> The usb stick will be built like so:
>>> https://github.com/CarlFK/video-stack-deploy/blob/
>> usbstick/scripts/mk_usb_installer.sh
>>>
>>> but this will demo the problem I have run into with qemu:  how do I boot
>>> from boot.img without using boot=menu?
>>
>> Have you already tried to use the bootindex property? See:
>>
>> http://git.qemu.org/?p=qemu.git;a=blob;f=docs/bootindex.txt
>>
>>  Thomas
>>
>>
> 
> 
