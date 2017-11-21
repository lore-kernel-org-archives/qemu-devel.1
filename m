Received: from eggs.gnu.org ([2001:4830:134:3::10]:59956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7Ie-0001Jy-3E
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eH7Id-0008S3-3D
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eH7Ic-0008RN-TS
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 07:05:11 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Nov 2017 12:04:33 +0000
Message-Id: <20171121120435.28728-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.11 v2 0/2] Update qemu.org domains
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>, ehabkost@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Do not change SeaBIOS extraversion string [Eduardo]
 * Do not change git submodules [Peter]

The first patch replaces qemu-project.org with qemu.org.

The second uses HTTPS URLs instead of HTTP.

I have left out the .gitmodules and SeaBIOS extraversion changes.  They will be
sent separately.

Stefan Hajnoczi (2):
  Use qemu.org domain name
  Use HTTPS for qemu.org and other domains

 MAINTAINERS                |  4 ++--
 docs/interop/qmp-intro.txt |  4 ++--
 docs/pcie.txt              |  4 ++--
 docs/rdma.txt              |  2 +-
 include/qemu-common.h      |  4 ++--
 Changelog                  |  2 +-
 README                     | 18 +++++++++---------
 pc-bios/README             |  4 ++--
 qemu-doc.texi              | 18 +++++++++---------
 qemu.nsi                   |  2 +-
 scripts/get_maintainer.pl  |  2 +-
 scripts/qmp/qemu-ga-client |  2 +-
 version.rc                 |  2 +-
 13 files changed, 34 insertions(+), 34 deletions(-)

-- 
2.14.3
