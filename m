Received: from eggs.gnu.org ([2001:4830:134:3::10]:42733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dsaDM-000870-4U
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1dsaDH-0001Zj-4m
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:54:20 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:47797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1dsaDG-0001XO-Ur
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:54:15 -0400
Received: by mail-qk0-x229.google.com with SMTP id b82so396227qkc.4
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:54:13 -0700 (PDT)
Date: Thu, 14 Sep 2017 15:54:11 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170914195411.GB3022@morn.lan>
References: <1503012801-10855-1-git-send-email-zuban32s@gmail.com>
	<CAKSfGUCz8oa2gLE7C1xvWP7PB8jjA+0recj1=MeJwD7NONdc2Q@mail.gmail.com>
	<f95c0dd1-45f2-d5bf-c7c5-0afbaf8e8950@redhat.com>
	<CAKSfGUD+Zdb=0xOoJRi=HpqZJG6d9ZbU=4JKCZ=nVxz3gmO3kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKSfGUD+Zdb=0xOoJRi=HpqZJG6d9ZbU=4JKCZ=nVxz3gmO3kg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH RESEND v7 0/3] Red Hat PCI bridge resource
 reserve capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandr Bezzubikov <zuban32s@gmail.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, seabios@seabios.org, Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On Thu, Sep 14, 2017 at 11:15:43AM +0300, Aleksandr Bezzubikov wrote:
> 2017-09-10 22:40 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:
> > On 10/09/2017 21:34, Aleksandr Bezzubikov wrote:
> >> And what about this series? The matching QEMU series has been applied,
> >> that's why there should be no problems with picking this series up for
> >> SeaBIOS
> >>
> >
> > Hi Aleksandr,
> >
> > Since SeaBIOS is a different project, we need to monitor the QEMU
> > patches by ourselves and only then ask the maintainer to merge the
> > patches if he has no objections, of course. (no automated process)
> >
> > Can you please verify the series still applies to SeaBIOS AS IS
> > and run a quick test against today's QEMU master branch?
> > Can you please give Kevin your OK before he proceeds with the merge?
> 
> Just did it, it's sitll OK and works fine. That's why this series can
> be merged AS IS.

Thanks.  I committed this series.  (I did prune some spurious trailing
newlines during the commit).

-Kevin
