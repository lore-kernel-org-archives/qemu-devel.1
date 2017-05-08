Received: from eggs.gnu.org ([2001:4830:134:3::10]:43957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7kAl-0007bg-BD
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfkarsten@gmail.com>) id 1d7kAk-00047B-4Q
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:02:03 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <cfkarsten@gmail.com>) id 1d7kAj-00046j-Uw
	for qemu-devel@nongnu.org; Mon, 08 May 2017 11:02:02 -0400
Received: by mail-qk0-x242.google.com with SMTP id y128so10449873qka.3
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 08:02:01 -0700 (PDT)
MIME-Version: 1.0
Sender: cfkarsten@gmail.com
In-Reply-To: <190f37d9-e18b-2be4-8579-043180b14ac7@tuxfamily.org>
References: <CADmzSSjY4n7bBBUVk45=_SRSj74AkSpN3O1d61Cik1q-eDiHKQ@mail.gmail.com>
	<83bb9749-ae49-3b26-dca8-3e600cf041d6@tuxfamily.org>
	<CADmzSSibDhGEExf2JSC9r1Nh7MZpCP34buM+Nv5DWmAg1NHMZQ@mail.gmail.com>
	<190f37d9-e18b-2be4-8579-043180b14ac7@tuxfamily.org>
From: Carl Karsten <carl@personnelware.com>
Date: Mon, 8 May 2017 10:01:30 -0500
Message-ID: <CADmzSSgLX6n2fw91Q_1N=0GHtZ+6XjH24Q2U00MGa_vMt8h0EQ@mail.gmail.com>
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

On Mon, May 8, 2017 at 2:57 AM, Thomas Huth <huth@tuxfamily.org> wrote:

> On 08.05.2017 06:22, Carl Karsten wrote:
> > neat.  missed that.
> >
> > except it doesn't work.
> >
> > juser@gator:~/temp$ qemu-system-x86_64 -drive
> > file=boot.img,format=raw,bootindex=1
> > qemu-system-x86_64: -drive file=boot.img,format=raw,bootindex=1: Block
> > format 'raw' does not support the option 'bootindex'
>
> bootindex is a property of the "-device" parameter, not of "-drive", so
> you've got to specify both parameters here (with "if=none" for -drive).
> See bootindex.txt for details.
>

got it.  Thank you and IRC folks for this:

qemu-system-x86_64 -m 256 \
    -drive file=disk.cow,index=0 \
    -drive file=/dev/sdb,index=1,format=raw,if=none,id=thumb \
      -device ide-hd,drive=thumb,bootindex=1




>
>  Thomas
>
> > On Sun, May 7, 2017 at 9:02 PM, Thomas Huth <huth@tuxfamily.org> wrote:
> >
> >> On 07.05.2017 07:42, Carl Karsten wrote:
> >>> In the real world I will have a machine with a sata hd and boot the
> >>> installer from a usb stick. I want to test this with 2 disk image
> files.
> >>>
> >>> The usb stick will be built like so:
> >>> https://github.com/CarlFK/video-stack-deploy/blob/
> >> usbstick/scripts/mk_usb_installer.sh
> >>>
> >>> but this will demo the problem I have run into with qemu:  how do I
> boot
> >>> from boot.img without using boot=menu?
> >>
> >> Have you already tried to use the bootindex property? See:
> >>
> >> http://git.qemu.org/?p=qemu.git;a=blob;f=docs/bootindex.txt
> >>
> >>  Thomas
> >>
> >>
> >
> >
>
>


-- 
Carl K
