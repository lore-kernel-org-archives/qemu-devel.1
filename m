Received: from eggs.gnu.org ([209.51.188.92]:36186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gpFbb-0003ZG-Sf
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gpFbb-0004QW-04
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:54:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gpFba-0004QN-LM
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 11:54:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 660F72CD7E3
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 16:46:41 +0000 (UTC)
From: Christophe Fergeau <cfergeau@redhat.com>
Date: Thu, 31 Jan 2019 17:46:12 +0100
Message-Id: <20190131164614.19209-1-cfergeau@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v7 0/2] log: Make glib logging go through QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

The main goal of this patch series is to make logs output by
libspice-server.so go through qemu logging infrastructure so that their
format is the same as the rest of QEMU messages (in particular,
timestamps). This is done in the second patch, the first one is a
preparation patch.

Christophe Fergeau (2):
  qemu-io: Use error_[gs]et_progname()
  log: Make glib logging go through QEMU

 bsd-user/main.c             |  2 ++
 include/qemu/error-report.h |  3 +-
 linux-user/main.c           |  2 ++
 qemu-img.c                  |  2 +-
 qemu-io.c                   | 14 ++++------
 qemu-nbd.c                  |  2 +-
 scsi/qemu-pr-helper.c       |  1 +
 util/qemu-error.c           | 55 ++++++++++++++++++++++++++++++++++++-
 vl.c                        |  2 +-
 9 files changed, 70 insertions(+), 13 deletions(-)

--=20
2.20.1
