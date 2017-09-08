Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqJnx-00025B-7f
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqJnr-0005Z5-MJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:58:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqJnr-0005Uc-Gc
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:58:39 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  8 Sep 2017 14:58:28 +0100
Message-Id: <20170908135831.10556-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/3] Improve websock response / error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Brian Rak <brak@vultr.com>, "Daniel P. Berrange" <berrange@redhat.com>

A followup of:

 v1: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01176.html
 v2: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01974.html

Changed in v3:

  - Use strftime instead of g_date_time_format

Changed in v2:

  - Drop redundant return statement
  - Drop redundant variable initialization
  - Assert that g_date_time_format is non-NULL

Daniel P. Berrange (3):
  io: send proper HTTP response for websocket errors
  io: include full error message in websocket handshake trace
  io: use case insensitive check for Connection & Upgrade websock
    headers

 io/channel-websock.c | 195 ++++++++++++++++++++++++++++++++++++++-------=
------
 io/trace-events      |   2 +-
 2 files changed, 146 insertions(+), 51 deletions(-)

--=20
2.13.5
