Received: from eggs.gnu.org ([2001:4830:134:3::10]:48069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnsj9-0007no-VI
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cnsj5-0005ew-5Y
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cnsj5-0005dg-0S
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 16:07:23 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 14 Mar 2017 17:06:40 -0300
Message-Id: <20170314200641.2958-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/1] Fix global property and -cpu handling bug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Bandan Das <bsd@redhat.com>

The following changes since commit d84f714eafedd8bb9d4aaec8b76417bef8e3535e:

  Update version for v2.9.0-rc0 release (2017-03-14 19:18:23 +0000)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-pull-request

for you to fetch changes up to 0bcba41fe379e4c6834adcf1456d9099db31a5b2:

  machine: Convert abstract typename on compat_props to subclass names (2017-03-14 16:53:44 -0300)

----------------------------------------------------------------
Fix global property and -cpu handling bug

This bug fix was supposed to be applied just after 2.8.0 was
released, but it slipped through the cracks. Sending it now for
the next -rc.

----------------------------------------------------------------

Eduardo Habkost (1):
  machine: Convert abstract typename on compat_props to subclass names

 hw/core/machine.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

-- 
2.11.0.259.g40922b1
