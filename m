Received: from eggs.gnu.org ([2001:4830:134:3::10]:53351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62vA-0001Cp-OF
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1d62v6-0008Li-Ql
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:38:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1d62v6-0008KB-LN
	for qemu-devel@nongnu.org; Wed, 03 May 2017 18:38:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79E4480460
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 22:38:51 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu,  4 May 2017 02:38:41 +0400
Message-Id: <20170503223846.6559-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 0/5] Memory leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Hi,

A new series of leaks spotted by ASAN. Mostly after introducing of the
test-hmp. Would it be useful having a configure --enable-asan, and
enabled by default with --enable-debug?

Marc-Andr=C3=A9 Lureau (5):
  test-keyval: fix leaks
  audio: fix capture buffer leaks
  audio: fix WAVState leak
  slirp: fix leak
  dump: fix memory_mapping_filter leak

 audio/audio.c       | 2 ++
 audio/wavcapture.c  | 1 +
 memory_mapping.c    | 1 +
 slirp/socket.c      | 3 +++
 tests/test-keyval.c | 4 ++++
 5 files changed, 11 insertions(+)

--=20
2.12.0.191.gc5d8de91d
