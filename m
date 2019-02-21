Received: from eggs.gnu.org ([209.51.188.92]:45373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwukw-0001ql-QB
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:15:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gwukv-0005k0-VC
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:15:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gwukv-0005jg-Od
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:15:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id t206so2460512oib.3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 12:15:41 -0800 (PST)
MIME-Version: 1.0
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-7-git-send-email-pbonzini@redhat.com>
	<20190221154417.h3i5m5pwxbiiufae@steredhat>
	<dae04588-9ea3-b53f-b4b6-a60322c18995@redhat.com>
In-Reply-To: <dae04588-9ea3-b53f-b4b6-a60322c18995@redhat.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 21 Feb 2019 21:15:30 +0100
Message-ID: <CAGxU2F7wuEwZUzQ3v60jWF5Ruqxpvjaz6E=H-cnoQXx1AcKOvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 06/51] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, philmd@redhat.com, qemu-devel@nongnu.org, thuth@redhat.com

Il giorno gio 21 feb 2019 alle 19:00 Paolo Bonzini <pbonzini@redhat.com> ha
scritto:

> On 21/02/19 16:44, Stefano Garzarella wrote:
> >> +
> > Hi Paolo,
> > I'm playing with Kconfig but with a simple configuration
> > (./configure --target-list=x86_64-softmmu --disable-docs) the build
> fails:
> > /usr/bin/ld: ../hw/xen/xen-legacy-backend.o: in function
> `xen_be_register_common':
> > /home/stefano/repos/qemu-kconfig/hw/xen/xen-legacy-backend.c:757:
> undefined reference to `xen_9pfs_ops'
> > collect2: error: ld returned 1 exit status
> >
> > Analyzing the Makefile.objs files maybe we should pass the CONFIG_VIRTFS
> from
> > config-host.mak down to Kconfig.
> > I tried this simple patch and it seems to fix the issue:
> >
> > diff --git a/Makefile b/Makefile
> > index df0732a050..bad583b01c 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -336,6 +336,7 @@ MINIKCONF_ARGS = \
> >      CONFIG_XEN=$(CONFIG_XEN) \
> >      CONFIG_OPENGL=$(CONFIG_OPENGL) \
> >      CONFIG_VHOST_USER=$(CONFIG_VHOST_USER) \
> > +    CONFIG_VIRTFS=$(CONFIG_VIRTFS) \
> >      CONFIG_LINUX=$(CONFIG_LINUX)
> >
> > I'm not sure if we need to add "config VIRTFS" entry in the
> > Kconfig.host, because it is already defined in hw/9pfs/Kconfig.
>
> Yes, we should remove it from hw/9pfs/Kconfig too.  I had made this
> exact change today in my branch. :)
>
>
Great! :)

Thanks,
Stefano
-- 
Stefano Garzarella
Software Engineer @ Red Hat
