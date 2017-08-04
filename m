Received: from eggs.gnu.org ([2001:4830:134:3::10]:44645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dde8J-0004Bs-LY
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dde8G-0004tm-5N
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:03:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dde8F-0004tG-W1
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:03:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 04 Aug 2017 17:03:11 +0200
Message-ID: <87o9rvbck0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] QAPI design mistake: RockerPort member @speed shoud bi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Scott Feldman <sfeldma@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>

RockerPort member @speed is documented to be "in Mbps" (presumably
Megabits/second).  It uses QAPI type 'uint32'.

This is inappropriate for QAPI/QMP.  It should have been made plain
bits/second (no multiple), and maybe 'uint64'.  As far as I can tell,
the QAPI part didn't get review from QAPI experts.  Probably because it
wasn't cc'ed to them.

Too late to fix now, but let's not repeat the mistake.
