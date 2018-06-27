Received: from eggs.gnu.org ([2001:4830:134:3::10]:57000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fY5KH-0002eC-5U
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fY5KC-0002hI-7n
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:57:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fY5KC-0002go-3O
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 03:57:12 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
	<0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com>
Date: Wed, 27 Jun 2018 09:57:09 +0200
In-Reply-To: <0df8a05c-43fc-6e85-b13c-d3f5c4691964@redhat.com> (Thomas Huth's
	message of "Wed, 27 Jun 2018 09:24:46 +0200")
Message-ID: <87fu18ach6.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Drop support for 32bit hosts in qemu? (was: [PULL 1/6]
 audio/hda: create millisecond timers that handle IO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Max Reitz <mreitz@redhat.com>, Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> On 27.06.2018 08:51, Gerd Hoffmann wrote:
[...]
>> Drop support for 32bit hosts in qemu?
>
> I guess the only way to answer that question reliably is to send a patch
> to mark 32-bit hosts as deprecated...
>
> Anyway, you still have got to fix that problem with -m32 now somehow
> since we certainly can not drop 32-bit immediately.

We certainly can if we want to.

Our formal deprecation policy codifies our compromise between the need
to evolve QEMU and the need of its users for stable external interfaces.

"Compiles on host X" is also a need, but it's a different one.
Evidence: "Supported build platforms" has its own appendix, separate
from "Deprecated features".  It's mum on 32-bit hosts.

I'm not saying we *should* drop 32-bit hosts immediately.  Only that the
feature deprecation policy does not apply.

Is QEMU still useful on 32-bit hosts?  Honest question!
