Received: from eggs.gnu.org ([2001:4830:134:3::10]:56271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqGYH-0005Xl-Sx
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqGYD-0006at-4O
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqGYC-0006aF-Ux
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:17 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  8 Sep 2017 11:30:08 +0100
Message-Id: <20170908103011.25821-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/3] Improve websock response / error
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

also pullin in

  https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01266.html

Changed in v2:

  - Drop redundant return statement
  - Drop redundant variable initialization
  - Assert that g_date_time_format is non-NULL

Daniel P. Berrange (3):
  io: send proper HTTP response for websocket errors
  io: include full error message in websocket handshake trace
  io: use case insensitive check for Connection & Upgrade websock
    headers

 io/channel-websock.c | 190 +++++++++++++++++++++++++++++++++++++--------=
------
 io/trace-events      |   2 +-
 2 files changed, 141 insertions(+), 51 deletions(-)

--=20
2.13.5
