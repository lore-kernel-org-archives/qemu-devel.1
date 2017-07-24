Received: from eggs.gnu.org ([2001:4830:134:3::10]:46984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZeW5-0007E6-Um
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZeW4-000574-W1
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:39:26 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:34335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZeW4-00054o-Oq
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:39:24 -0400
Received: by mail-pf0-x233.google.com with SMTP id q85so47757058pfq.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 07:39:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500889352.15837.7.camel@redhat.com>
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<1500761510-1556-5-git-send-email-zuban32s@gmail.com>
	<20170723054445-mutt-send-email-mst@kernel.org>
	<CAKSfGUAHPHwgLa=jNUGpW-saHK6rGK5epBY2ixizeuCwvE77wA@mail.gmail.com>
	<CAKSfGUDbW8psdPGOXUQDWBV6OJL8z_hxp5NL-=Pg+OHu5ZGfvA@mail.gmail.com>
	<1500889352.15837.7.camel@redhat.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Mon, 24 Jul 2017 17:39:21 +0300
Message-ID: <CAKSfGUDBRj8QMi45EKaDb0Ce19Yd_XqkMVUWQiaeUqCyMVcQpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/4] pci: enable RedHat PCI bridges
 to reserve additional buses on PCI init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, seabios@seabios.org, Marcel Apfelbaum <marcel@redhat.com>, Kevin OConnor <kevin@koconnor.net>, lersek@redhat.com, qemu-devel@nongnu.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

2017-07-24 12:42 GMT+03:00 Gerd Hoffmann <kraxel@redhat.com>:

> On Sun, 2017-07-23 at 22:44 +0300, Alexander Bezzubikov wrote:
> > By the way, any ideas on how to avoid 'bus overstealing' would
> > be greatly appreciated.
> > Static BIOS variable isn't applicable since its value isn't saved
> > across reboots.
>
> I think the reservation hints should be a absolute number, not a
> increment.  i.e. if qemu suggests to reserve three extra bus numbers
> seabios should reserve three, no matter whenever there are zero, one,
> two or three child busses present.  And I guess seabios should
> interpret that as minimum, so in case it finds five child busses it
> will allocate five bus numbers of course ...
>

Personally I have nothing against it. Marcel, Michael, what do you think?


>
> Same with the other limit hints.  If the hint says to allocate 16M, and
> existing device bars sum up to 4M, allocate 16M (and therefore leave
> 12M address space for hotplug).  If the device bars sum up to 32M,
> allocate that.
>
> While being at it:  I have my doubts the capability struct layout
> (which mimics register layout) buys us that much, seabios wouldn't
> blindly copy over the values anyway.  Having regular u32 fields looks
> more useful to me.
>
>
Again, if nobody has any objections, I can change it in v3.


> cheers,
>   Gerd
>
>


-- 
Alexander Bezzubikov
