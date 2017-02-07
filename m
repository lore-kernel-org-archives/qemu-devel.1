Received: from eggs.gnu.org ([2001:4830:134:3::10]:40100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stenavin@gmail.com>) id 1cbD6S-0002DJ-0l
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stenavin@gmail.com>) id 1cbD6Q-0003G2-UZ
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:15:08 -0500
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:34088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stenavin@gmail.com>) id 1cbD6Q-0003EG-Qp
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 16:15:06 -0500
Received: by mail-qt0-x229.google.com with SMTP id w20so142362602qtb.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 13:15:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3b1b880d-8e1f-a447-1d00-a1c9b6cbe44e@redhat.com>
References: <CAHwdxNf8CZ2x-UdFWUJ2BhgZQC6yKPnbM6T7FNGwow-=ez+rvw@mail.gmail.com>
	<3b1b880d-8e1f-a447-1d00-a1c9b6cbe44e@redhat.com>
From: Nikolay Ivanets <stenavin@gmail.com>
Date: Tue, 7 Feb 2017 23:14:46 +0200
Message-ID: <CAHwdxNdxf0M-tGzt-zxajLQKS5gW1dtFwShR-mZkeXWNWu6yAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] How to find backing file for qemu-nbd?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Yes, it is what i'm doing now: ps -C qemu-nbd -o cmd='.

Thanks!

--
    Nikolay Ivanets
    Mobile: +380979184774
    Skype: n_ivanets

2017-02-07 17:36 GMT+02:00 Eric Blake <eblake@redhat.com>:

> On 02/07/2017 08:25 AM, Nikolay Ivanets wrote:
> > Is there any way to find source file supplied for qemu-nbd similar to
> loop
> > device:
> >
> > cat /sys/block/loop0/loop/backing_file
>
> qemu-nbd is userspace, so there's no way it will be found in /sys/.  But
> since it is userspace, is it not sufficient to just use 'ps' or
> /proc/$n/cmdline to determine what command line qemu-nbd was started with?
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
>
