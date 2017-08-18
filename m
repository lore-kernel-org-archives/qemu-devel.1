Received: from eggs.gnu.org ([2001:4830:134:3::10]:49180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diWkj-0002Mh-JG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 22:11:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diWkg-0007Lb-FN
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 22:11:13 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diWkg-0007LP-Ah
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 22:11:10 -0400
Received: by mail-qt0-x241.google.com with SMTP id i19so7855442qte.1
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 19:11:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAMM1KhhxQg8H8uYeGEHpXYgE=iTRyhik7pU+MdRr7HL6utpREg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11bbf041-b0b8-00a6-6201-b4deb3ccf673@amsat.org>
Date: Thu, 17 Aug 2017 23:11:05 -0300
MIME-Version: 1.0
In-Reply-To: <CAMM1KhhxQg8H8uYeGEHpXYgE=iTRyhik7pU+MdRr7HL6utpREg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] nVidia emulation in QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Darius Goad <alegend45@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

Hi,

On 08/17/2017 10:01 PM, Darius Goad wrote:
> Hello. I'm Melissa, a trans woman who is the main developer of the nVidia
> emulation code for 86Box. I'm interested in porting this code over to QEMU
> as QEMU has higher compatibility with newer operating systems, as well as
> expanding the developer base for nVidia graphics card emulation.
> 
> The 86Box code currently only handles the RIVA 128, the RIVA TNT, and a few
> versions of the RIVA TNT2, and in a very incomplete state at that. I have
> not been able to progress further due to the fact that 86Box's support of
> modern Linux operating systems is poor, and due to the lack of a debugger
> in 86Box.
> 
> I do need some help, however, as QEMU's code structure is not my strong
> suit.
> 
> Anyway, my code is here:
> https://github.com/MoochMcGee/86Box-experimental/blob/experimental/src/VIDEO/vid_nv_riva128.c

This code seems to match how devices are implemented in QEMU.

You can start looking at this concise QEMU device (no PCI):

https://github.com/qemu/qemu/blob/master/hw/display/cg3.c

and a device with PCI:

https://github.com/qemu/qemu/blob/master/hw/display/sm501.c

Regards,

Phil.
