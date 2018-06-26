Received: from eggs.gnu.org ([2001:4830:134:3::10]:55683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXjHY-00089P-7C
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fXjHU-0000DT-6x
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:25:00 -0400
Date: Tue, 26 Jun 2018 10:24:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180626102449.50b65335.cohuck@redhat.com>
In-Reply-To: <7cb526fc-9da4-248b-d5c4-cb463a2c2bac@de.ibm.com>
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
	<cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
	<patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
	<7cb526fc-9da4-248b-d5c4-cb463a2c2bac@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390/boot: block uncompressed vmlinux
 booting attempts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On Tue, 26 Jun 2018 09:30:19 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 06/25/2018 05:09 PM, Vasily Gorbik wrote:
> > Since uncompressed kernel image "vmlinux" elf file is not bootable under
> > qemu anymore, add a check which would report that.
> > 
> > Qemu users are encouraged to use bzImage or
> > arch/s390/boot/compressed/vmlinux instead.
> > 
> > The check relies on s390 linux entry point ABI definition, which is only
> > present in bzImage and arch/s390/boot/compressed/vmlinux.
> > 
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>  
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> some proposals regarding the wording below..
> 
> [...]
> > +
> > +	sclp_early_printk("The linux kernel boot failure: the image is corrupted or not bootable.\n");
> > +	sclp_early_printk("Please check that you are using bootable kernel image \"bzImage\".\n");
> > +	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinux\" image for qemu)\n");  
> 
> What about making this explain things a bit more, e.g. something like
> 
> Linux kernel boot failure: The boot image does not contain all necessary
> components (like the entry point and decompressor). The plain vmlinux ELF
> file no longer carries all necessary parts for starting up. Please use
> bzImage or arch/s390/boot/compressed/vmlinux.

Yes, that sounds good. With the changed message,

Acked-by: Cornelia Huck <cohuck@redhat.com>
