Received: from eggs.gnu.org ([2001:4830:134:3::10]:52964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eFj9n-0002E5-3i
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eFj9j-00067f-5h
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:06:19 -0500
Received: from mail-io0-x22a.google.com ([2607:f8b0:4001:c06::22a]:46992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eFj9j-00066s-0O
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 11:06:15 -0500
Received: by mail-io0-x22a.google.com with SMTP id t11so9197150iof.13
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 08:06:14 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <mailman.8273.1510914667.27993.qemu-devel@nongnu.org>
Date: Fri, 17 Nov 2017 11:06:12 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <50461419-2FB0-4A94-A6E6-4EFB459FF39D@gmail.com>
References: <mailman.8273.1510914667.27993.qemu-devel@nongnu.org>
Subject: Re: [Qemu-devel] [PATCH 02/24] sdl: remove -alt-grab and -ctrl-grab
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


> With absolute pointer devices such as usb-tablet being widely used
> mouse grabs (for relative pointing devices) should be rarely needed
> these days.  So the benefit of the options to configure the hotkey
> modifiers for grab (and other actions) seems questionable.  Which
> is expecially true for the -ctrl-grab which isn't handled in the
> handle_keyup() code.

So does this mean you are against a patch that would allow the user to =
chose a key to act as a mouse ungrab key?=
