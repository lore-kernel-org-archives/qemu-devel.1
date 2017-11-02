Received: from eggs.gnu.org ([2001:4830:134:3::10]:50665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1eAHCf-000806-D0
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1eAHCb-00029Q-D1
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:14:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1eAHCb-000286-31
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 11:14:41 -0400
Received: from mail-yw0-f199.google.com ([209.85.161.199])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1eAHCY-0000YQ-OK
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 15:14:38 +0000
Received: by mail-yw0-f199.google.com with SMTP id q126so10844032ywq.6
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 08:14:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAATJJ0KveNV1tHT-w5TCL9_TrCdMzp34=fGfhMm7NzZux=7K+Q@mail.gmail.com>
References: <CAATJJ0KveNV1tHT-w5TCL9_TrCdMzp34=fGfhMm7NzZux=7K+Q@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Thu, 2 Nov 2017 16:14:06 +0100
Message-ID: <CAATJJ0L6Xs6vbauBeznVuf+e_GjRLbU2Kz8MWSrBHzD_+wLhhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] How to best handle the reoccurring of rom changes
 breaking cross version migrations?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Libvirt Devel <libvir-list@redhat.com>

Ping - since there wasn't any reply so far - any best practices one could
share?

Let me add a TL;DR:
- bump of ipxe rom versions change the size of virtio-net-pci.rom
- that breaks on migration "Length mismatch"

I'd guess the size of that rom has to be fixed up on the fly, but if that
is really ok and how/where is the question.

Also to +1 on bad things for today - I made this a cross post to libvirt in
case there is one that has done that in the past.


On Mon, Aug 28, 2017 at 4:36 PM, Christian Ehrhardt <
christian.ehrhardt@canonical.com> wrote:

> Hi,
> migration issues due to rom changes seem to occur over and over in past
> years [1], [2],[3],[4],[5].
> From the past I know several workarounds (like just truncating to the
> bigger size) but all have various deficiencies.
>
> But OTOH rom's will always change due to fixes in them. And recently I
> found one such change [6] that affects the next Ubuntu release and wonder
> what the ?right?, well lets say best way to fix it would be.
> Current issue:
> Length mismatch: 0000:00:03.0/virtio-net-pci.rom: 0x40000 in != 0x80000:
> Invalid argument
> Due to efi-virtio.rom growing over 256k due to an update to a newer ipxe
> from upstream.
>
> I beg your pardon (for not being educated enough on this yet), but I want
> to avoid to go a route that is fixing it in a sub-optimal way and ask for
> some guidance. There might be better ways in the modern qemu of today than
> there were in the past.
> TL;DR I look for the best way (if any) to declare in the new qemu: "I know
> that the old size was smaller, let me fix that up on migration".
>
> I'll try on my own as I expect the machine type structures/mechanisms (and
> we have Ubuntu specific types that could encapsulate the rom status from
> the ipxe package to be coupled with the type) have all that is needed.
> Yet me almost randomly trying around there surely isn't the best way to go
> - so if there is some existing case or a short hint at what in there might
> be the best way to fixup a changed rom size on a migration I'd be very
> happy to hear about that.
>
> [1]: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1536331
> [2]: https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg01881.html
> [3]: https://bugzilla.redhat.com/show_bug.cgi?id=1293566
> [4]: https://bugzilla.redhat.com/show_bug.cgi?id=1090093
> [5]: https://forge.univention.org/bugzilla/show_bug.cgi?id=38877
> [6]: https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1713490
>
> P.S: As everybody else I don't mind so much on reverse migration to older
> releases
>
> --
> Christian Ehrhardt
> Software Engineer, Ubuntu Server
> Canonical Ltd
>



-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
