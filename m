Received: from eggs.gnu.org ([2001:4830:134:3::10]:44259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dmLAS-0007Lc-MU
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dmLAO-0000H3-Mx
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:37:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1dmLAO-0000Gd-D1
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:37:28 -0400
Received: from mail-yw0-f198.google.com ([209.85.161.198])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dmLAM-0006x6-NI
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 14:37:26 +0000
Received: by mail-yw0-f198.google.com with SMTP id q72so1030955ywg.0
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 07:37:26 -0700 (PDT)
MIME-Version: 1.0
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Mon, 28 Aug 2017 16:36:54 +0200
Message-ID: <CAATJJ0KveNV1tHT-w5TCL9_TrCdMzp34=fGfhMm7NzZux=7K+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to best handle the reoccurring of rom changes
 breaking cross version migrations?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi,
migration issues due to rom changes seem to occur over and over in past
years [1], [2],[3],[4],[5].
>From the past I know several workarounds (like just truncating to the
bigger size) but all have various deficiencies.

But OTOH rom's will always change due to fixes in them. And recently I
found one such change [6] that affects the next Ubuntu release and wonder
what the ?right?, well lets say best way to fix it would be.
Current issue:
Length mismatch: 0000:00:03.0/virtio-net-pci.rom: 0x40000 in != 0x80000:
Invalid argument
Due to efi-virtio.rom growing over 256k due to an update to a newer ipxe
from upstream.

I beg your pardon (for not being educated enough on this yet), but I want
to avoid to go a route that is fixing it in a sub-optimal way and ask for
some guidance. There might be better ways in the modern qemu of today than
there were in the past.
TL;DR I look for the best way (if any) to declare in the new qemu: "I know
that the old size was smaller, let me fix that up on migration".

I'll try on my own as I expect the machine type structures/mechanisms (and
we have Ubuntu specific types that could encapsulate the rom status from
the ipxe package to be coupled with the type) have all that is needed.
Yet me almost randomly trying around there surely isn't the best way to go
- so if there is some existing case or a short hint at what in there might
be the best way to fixup a changed rom size on a migration I'd be very
happy to hear about that.

[1]: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/1536331
[2]: https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg01881.html
[3]: https://bugzilla.redhat.com/show_bug.cgi?id=1293566
[4]: https://bugzilla.redhat.com/show_bug.cgi?id=1090093
[5]: https://forge.univention.org/bugzilla/show_bug.cgi?id=38877
[6]: https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1713490

P.S: As everybody else I don't mind so much on reverse migration to older
releases

-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
