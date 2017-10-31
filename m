Received: from eggs.gnu.org ([2001:4830:134:3::10]:36776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1e9Oze-0000GV-5L
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1e9OzZ-0003kX-W5
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:21:42 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:54756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <batmanustc@gmail.com>)
	id 1e9OzZ-0003kL-RH
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 01:21:37 -0400
Received: by mail-qt0-x22c.google.com with SMTP id z19so19275911qtg.11
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 22:21:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171027070833.GA24218@redhat.com>
References: <CAOE=1Z31T6nHcO4P6GWW8GK_o0VB66HivPc-m1LZRh_x6nY_6g@mail.gmail.com>
	<20171026140203.GG10055@redhat.com>
	<CAOE=1Z3Umt+mLDKyJ04qRsH-E=EPYC2ozeHm5a3jbqF0=yv-hQ@mail.gmail.com>
	<20171027070833.GA24218@redhat.com>
From: Sam <batmanustc@gmail.com>
Date: Tue, 31 Oct 2017 13:21:36 +0800
Message-ID: <CAOE=1Z0m+Wa42BYToj10cR2tTjBAGyKPaMtZgFvLNjG5VKMU6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu start VM in huge page without '-mem-prealloc'
 will get memory leak?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Why could I not find in ovs-dpdk maillist? could some one give the bug
number?

2017-10-27 15:08 GMT+08:00 Daniel P. Berrange <berrange@redhat.com>:

> On Fri, Oct 27, 2017 at 11:28:33AM +0800, Sam wrote:
> > After restart ovs-dpdk(which is openvswitch with dpdk lib), memory is
> > released.
> >
> > But problem is in product environment, I could not restart ovs-dpdk......
>
> This is a clear bug in ovs-dpdk then - it is failing to release memory
> when QEMU exits.
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/
> dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/
> dberrange :|
>
