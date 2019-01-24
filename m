Received: from eggs.gnu.org ([209.51.188.92]:58730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmfFb-0005us-8V
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmf92-0000pZ-8X
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:34:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmf91-0000oj-Te
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:34:12 -0500
Date: Thu, 24 Jan 2019 13:34:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190124133405.GR7953@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <DM6PR01MB439558A3AEFF795A7072DB078E9A0@DM6PR01MB4395.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR01MB439558A3AEFF795A7072DB078E9A0@DM6PR01MB4395.prod.exchangelabs.com>
Subject: Re: [Qemu-devel] unknown keycodes `(unnamed)',
 please report to qemu-devel@nongnu.org
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Burgess, Alison E" <alison.burgess@wsu.edu>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Jan 24, 2019 at 08:34:50AM +0000, Burgess, Alison E wrote:
> I am running Ubuntu 18.04 and I am sending this email because when
> I try to run these series of commands in an executable file in
> 
> 
> arm-none-eabi-as -mcpu=arm926ej-s -g ts.s -o ts.o
> arm-none-eabi-gcc -c -mcpu=arm926ej-s -g t.c -o t.o
> arm-none-eabi-ld -T t.ld ts.o t.o -o t.elf
> arm-none-eabi-objcopy -O binary t.elf t.bin
> arm-none-eabi-readelf -a t.elf
> 
> rm *.o *.elf
> 
> echo ready to go?
> read dummy
> 
> qemu-system-arm -M realview-pbx-a9 -m 128M -kernel t.bin \
> -serial mon:stdio -serial /dev/pts/0 -serial /dev/pts/0 -serial /dev/pts/0
> 
> (where the number in /dev/pts/# is the number I get when I run ps in the terminal)
> 
> The qemu terminal appears, but once I press 'Enter' again so that
> my code runs, I am faced with the unknown keycodes `(unnamed)',
> please report to qemu-devel@nongnu.org error message. After a couple
> of hours searching online I have not been able to find a solution
> and I have download and reinstalled qemu a couple of times.

Can you tell us what version of QEMU you are using ?  In addition what
environment are you running it under ?  X11 or Wayland or something
else ?  Finally, what keyboard layout is your environment setup to use ?


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
