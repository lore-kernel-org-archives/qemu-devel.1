Received: from eggs.gnu.org ([2001:4830:134:3::10]:40068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drl5f-00059D-D4
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drl5c-0001Ex-7m
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:18:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drl5c-0001Dk-1y
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:18:56 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 14:18:44 +0100
Message-Id: <20170912131847.27684-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 0/3] Improve websock response / error
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
 v3: https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02108.html

Changed in v4:

  - Use time() instead of gettimeofday() to avoid data type
    cast problems on mingw

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

 io/channel-websock.c | 194 ++++++++++++++++++++++++++++++++++++++-------=
------
 io/trace-events      |   2 +-
 2 files changed, 145 insertions(+), 51 deletions(-)

--=20
2.13.5
