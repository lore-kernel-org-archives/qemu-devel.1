Received: from eggs.gnu.org ([2001:4830:134:3::10]:33840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d413p-0005sE-6M
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d413o-0008Vh-FQ
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 04:15:29 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
Date: Fri, 28 Apr 2017 10:15:17 +0200
In-Reply-To: <1493192202-3184-1-git-send-email-armbru@redhat.com> (Markus
	Armbruster's message of "Wed, 26 Apr 2017 09:36:35 +0200")
Message-ID: <87efwdne22.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/7] sockets: Flatten SocketAddress except
 in external interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, eblake@redhat.com, qemu-block@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> SocketAddress is a simple union, and simple unions are awkward: they
> have their variant members wrapped in a "data" object on the wire, and
> require additional indirections in C.  Flatten it as follows: rename
> SocketAddress to SocketAddressLegacy, rename its flat sibling
> SocketAddressFlat to SocketAddress, convert all users of
> SocketAddressLegacy to SocketAddress, except for existing external
> interfaces.  This completes the work outlined in commit 9445673.

This series could go in via "Sockets" maintainers, but if you guys don't
mind, I'll simply route it through qapi-next.
