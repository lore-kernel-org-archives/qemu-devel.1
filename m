Received: from eggs.gnu.org ([2001:4830:134:3::10]:33393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7aC1-0004gt-V4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7aC0-0006z8-Qi
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:22:41 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cfkarsten@gmail.com>) id 1d7aC0-0006yz-LO
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:22:40 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so8182317qtb.2
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:22:40 -0700 (PDT)
MIME-Version: 1.0
Sender: cfkarsten@gmail.com
In-Reply-To: <83bb9749-ae49-3b26-dca8-3e600cf041d6@tuxfamily.org>
References: <CADmzSSjY4n7bBBUVk45=_SRSj74AkSpN3O1d61Cik1q-eDiHKQ@mail.gmail.com>
	<83bb9749-ae49-3b26-dca8-3e600cf041d6@tuxfamily.org>
From: Carl Karsten <carl@personnelware.com>
Date: Sun, 7 May 2017 23:22:09 -0500
Message-ID: <CADmzSSibDhGEExf2JSC9r1Nh7MZpCP34buM+Nv5DWmAg1NHMZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] boot order=d bug?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org

neat.  missed that.

except it doesn't work.

juser@gator:~/temp$ qemu-system-x86_64 -drive
file=boot.img,format=raw,bootindex=1
qemu-system-x86_64: -drive file=boot.img,format=raw,bootindex=1: Block
format 'raw' does not support the option 'bootindex'

juser@gator:~/temp$ qemu-system-x86_64 -drive
file=boot.img,bootindex=1WARNING: Image format was not specified for
'boot.img' and probing guessed raw.
         Automatically detecting the format is dangerous for raw images,
write operations on block 0 will be restricted.
         Specify the 'raw' format explicitly to remove the restrictions.
qemu-system-x86_64: -drive file=boot.img,bootindex=1: Block format 'raw'
does not support the option 'bootindex'


Is there a "yes you do --force" option ?


On Sun, May 7, 2017 at 9:02 PM, Thomas Huth <huth@tuxfamily.org> wrote:

> On 07.05.2017 07:42, Carl Karsten wrote:
> > In the real world I will have a machine with a sata hd and boot the
> > installer from a usb stick. I want to test this with 2 disk image files.
> >
> > The usb stick will be built like so:
> > https://github.com/CarlFK/video-stack-deploy/blob/
> usbstick/scripts/mk_usb_installer.sh
> >
> > but this will demo the problem I have run into with qemu:  how do I boot
> > from boot.img without using boot=menu?
>
> Have you already tried to use the bootindex property? See:
>
> http://git.qemu.org/?p=qemu.git;a=blob;f=docs/bootindex.txt
>
>  Thomas
>
>


-- 
Carl K
