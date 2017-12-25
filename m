Received: from eggs.gnu.org ([2001:4830:134:3::10]:56268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTIjh-0005BE-Ne
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTIjd-0000P8-80
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:43:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eTIjd-0000NX-26
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 21:43:25 -0500
Date: Mon, 25 Dec 2017 10:43:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171225024321.GA9418@lemon>
References: <151389782710.99.6783851039862691089@5adcb62bf0d6>
	<fa552f1c-d4ba-87a3-ded8-3fd67e6a4511@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa552f1c-d4ba-87a3-ded8-3fd67e6a4511@acm.org>
Subject: Re: [Qemu-devel] [PATCH 0/8] Small IPMI (and other) fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org

On Sat, 12/23 08:36, Corey Minyard wrote:
> On 12/21/2017 05:10 PM, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed automatic build test. Please find the testing commands and
> > their output below. If you have docker installed, you can probably reproduce it
> > locally.
> 
> The error here doesn't seem to have anything to do with these patches:
> 
> 
> >    CC      aarch64-softmmu/hw/virtio/virtio.o
> >    CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
> > /tmp/qemu-test/src/hw/i386/vmport.c: In function 'vmport_ioport_read':
> > /tmp/qemu-test/src/hw/i386/vmport.c:81:9: error: implicit declaration of function 'qemu_log_mask' [-Werror=implicit-function-declaration]
> >           qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
> >           ^~~~~~~~~~~~~
> > /tmp/qemu-test/src/hw/i386/vmport.c:81:9: error: nested extern declaration of 'qemu_log_mask' [-Werror=nested-externs]
> > /tmp/qemu-test/src/hw/i386/vmport.c:81:23: error: 'LOG_UNIMP' undeclared (first use in this function)
> >           qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
> >                         ^~~~~~~~~
> > /tmp/qemu-test/src/hw/i386/vmport.c:81:23: note: each undeclared identifier is reported only once for each function it appears in
> > cc1: all warnings being treated as errors
> > make[1]: *** [hw/i386/vmport.o] Error 1
> > make: *** [subdir-x86_64-softmmu] Error 2
> > make: *** Waiting for unfinished jobs....
> > /tmp/qemu-test/src/rules.mak:66: recipe for target 'hw/i386/vmport.o' failed
> > Makefile:387: recipe for target 'subdir-x86_64-softmmu' failed
> 
> Am I missing something here?
> 

It's a false positive because the master was broken at the time your series was
tested. Now it's fixed. Sorry for the noise. Patchew is being worked on to only
report errors when the merge base passes the same tests.

Fam
