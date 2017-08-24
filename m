Received: from eggs.gnu.org ([2001:4830:134:3::10]:48836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa5-0006Si-If
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkxa3-0004AV-So
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkxa3-00049y-KH
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 15:14:15 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 21:13:52 +0200
Message-Id: <1503602048-12268-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 00/16] qapi-schema: Reorganize along
 maintenance boundaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Alberto Garcia <berto@igalia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>
Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>

Much of the QAPI schema really belongs to a subsystem, but MAINTAINERS
can't tell when it's all in a big ball of mud (qapi-schema.json) with
a small ball of mud (event.json) on the side.

Create sub-schemas for the subsystems with the most substantial QAPI
footprint in the mud.  The big ball shrinks by half, and the small
ball goes away.

Bonus: the generated documentation's structure makes more sense now.
It needs further improvement (see last patch), but it's a start.

I generally kept the order intact when moving source code.  It may be
smarter to reorder it for improved legibility (both source and
generated doc).  Subsystem maintainers, please tell me whether you'd
like things reordered.

v2:
* Title changed from "qapi-schema: Generated doc structure fixes"
* PATCH 01: say "source order" rather than "textual order"
* PATCH 02: no change
* PATCH 03: rocker.json included before event.json to reduce churn
* PATCH 04-16: new

Markus Armbruster (16):
  qapi-schema: Document how generated documentation is ordered
  qapi-schema: Introspection doc is in the wrong section, fix
  qapi-schema: Rocker doc section contains unrelated stuff, fix
  qapi-schema: Collect sockets stuff in qapi/sockets.json
  qapi-schema: Collect run state stuff in qapi/run-state.json
  qapi-schema: Collect char device stuff in qapi/char.json
  qapi-schema: Collect net device stuff in qapi/net.json
  qapi-schema: Collect UI stuff in qapi/ui.json
  qapi-schema: Collect migration stuff in qapi/migration.json
  qapi-schema: Collect transaction stuff in qapi/transaction.json
  qapi-schema: Collect TPM stuff in qapi/tpm.json
  qapi-schema: Move block events from event.json to block.json
  qapi-schema: Fold event.json back into qapi-schema.json
  qapi-schema: Make block-core.json self-contained
  qapi-schema: Move queries from common.json to qapi-schema.json
  qapi-schema: Improve section headings

 MAINTAINERS           |   16 +
 Makefile              |   15 +-
 qapi-schema.json      | 3866 +++----------------------------------------=
------
 qapi/block-core.json  |    5 +-
 qapi/block.json       |   73 +-
 qapi/char.json        |  538 +++++++
 qapi/common.json      |  132 +-
 qapi/crypto.json      |    2 +-
 qapi/event.json       |  646 ---------
 qapi/introspect.json  |    6 +-
 qapi/migration.json   | 1085 ++++++++++++++
 qapi/net.json         |  706 +++++++++
 qapi/run-state.json   |  352 +++++
 qapi/sockets.json     |  147 ++
 qapi/tpm.json         |  137 ++
 qapi/trace.json       |    2 +-
 qapi/transaction.json |  158 ++
 qapi/ui.json          |  977 +++++++++++++
 18 files changed, 4477 insertions(+), 4386 deletions(-)
 create mode 100644 qapi/char.json
 delete mode 100644 qapi/event.json
 create mode 100644 qapi/migration.json
 create mode 100644 qapi/net.json
 create mode 100644 qapi/run-state.json
 create mode 100644 qapi/sockets.json
 create mode 100644 qapi/tpm.json
 create mode 100644 qapi/transaction.json
 create mode 100644 qapi/ui.json

--=20
2.7.5
