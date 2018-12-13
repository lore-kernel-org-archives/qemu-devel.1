Received: from eggs.gnu.org ([2001:4830:134:3::10]:52501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXUJe-0003m0-PF
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:58:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXUJa-0006NI-Mf
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:58:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXUJX-00065f-EY
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:58:20 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181210140808.26794-1-kraxel@redhat.com>
Date: Thu, 13 Dec 2018 17:58:12 +0100
In-Reply-To: <20181210140808.26794-1-kraxel@redhat.com> (Gerd Hoffmann's
	message of "Mon, 10 Dec 2018 15:08:08 +0100")
Message-ID: <87a7l9l5y3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] input: avoid malloc for mouse events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, felix.yzg@gmail.com

Gerd Hoffmann <kraxel@redhat.com> writes:

> There is no reason to allocate mouse events using malloc, we can
> allcoate them from stack instead, save a few cpu cycles and make the
> code more readable with c99 initializers.
>
> Suggested-by: FelixYao <felix.yzg@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
