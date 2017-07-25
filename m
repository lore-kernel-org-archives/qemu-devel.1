Received: from eggs.gnu.org ([2001:4830:134:3::10]:55536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvMo-0000Wg-Sl
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:39:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZvMk-0004fT-V9
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:38:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZvMk-0004f5-Oj
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:38:54 -0400
Date: Tue, 25 Jul 2017 09:38:49 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725083849.GE26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
Subject: Re: [Qemu-devel] [PATCH] io: Improve websocket support by becoming
 more RFC compliant.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: qemu-devel@nongnu.org

On Mon, Jul 24, 2017 at 11:42:17AM -0700, Brandon Carpenter wrote:
> Remembering the opcode is sufficient for handling fragmented frames from
> the client, which may be introduced by an intermediary server/proxy.
> Respond to pings and ignore pongs rather than close the connection as
> many browsers use ping/pong to test an idle connection. Close
> connections according to the RFC, including providing reason code and
> message to aid debugging of unexpected disconnects. Empty payloads
> should not cause a disconnect.

Couuld you split this up into multiple patches, each one only fixing
a single problem at a time. It is rather hard to review this for
correctness when everything is changed at once.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
