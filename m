Received: from eggs.gnu.org ([2001:4830:134:3::10]:46264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPoDI-0004Xh-9h
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPoDF-0001En-5A
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:03:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55826 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPoDF-0001EN-1h
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 08:03:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A6FA7C6A9
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 12:03:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Mon,  4 Jun 2018 13:03:43 +0100
Message-Id: <20180604120345.12955-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/2] Avoid using RUN_STATE_PRECONFIG unless
 explicitly requested with --preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The change to use RUN_STATE_PRECONFIG as the default initial state, even
when not requested with --preconfig has caused a number of problems. This
series introduces a new RUN_STATE_NONE to act as the initial state, so
that we never use RUN_STATE_PRECONFIG unless the mgmt app has explicitly
requested todo so.

Daniel P. Berrang=C3=A9 (2):
  vl: don't use RUN_STATE_PRECONFIG as initial state
  vl: fix use of --daemonize with --preconfig

 qapi/run-state.json |  6 +++++-
 vl.c                | 49 +++++++++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 20 deletions(-)

--=20
2.17.0
