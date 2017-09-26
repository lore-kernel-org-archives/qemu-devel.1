Received: from eggs.gnu.org ([2001:4830:134:3::10]:37765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxx1-0004J1-AB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dwxww-00035s-Ew
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dwxww-00035F-93
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:03:30 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 26 Sep 2017 19:03:22 -0300
Message-Id: <20170926220326.12996-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/4] qmp: query-device-type command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Gibson <dgibson@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>

This series implements a new 'query-device-type' command, that
can be used to query TYPE_DEVICE-specific information that is not
returned by qom-list-types.

The new field can be used instead of "info qdm" parsing by the
device-crash-test script.  It can be also used by hotplug test
cases, to skip non-hotpluggable device types.

Eduardo Habkost (4):
  qmp: qom_type_get_info() helper
  qmp: get_device_class() helper
  qmp: query-device-type command
  device-crash-test: Use query-device-info for user-creatable check

 qapi-schema.json          | 35 ++++++++++++++++++++++++++
 qmp.c                     | 63 +++++++++++++++++++++++++++++++++++++++--------
 scripts/device-crash-test | 19 ++------------
 3 files changed, 90 insertions(+), 27 deletions(-)

-- 
2.13.5
