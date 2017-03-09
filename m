Received: from eggs.gnu.org ([2001:4830:134:3::10]:40231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm2gO-0002kO-Qt
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cm2gJ-0004ns-UR
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:21:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cm2gJ-0004nU-Ip
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 13:20:55 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B506B76F4
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 18:20:55 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu,  9 Mar 2017 15:20:47 -0300
Message-Id: <20170309182049.30040-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9? v2 0/2] vl: Print warning if a
 non-empty default config-file is found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

(This missed hard freeze, but I would still like to include the
warning in 2.9 so we can remove the default config file in 2.10.
I will include this series in a pull request only if at least 2
other maintainers send their Acked-by.)

We plan to remove support for /etc/qemu/qemu.conf in the near
future. Make QEMU print a warning in case there a non-empty
/etc/qemu/qemu.conf is loaded, so users have time to adapt.

Changes v1 -> v2:
* Remove unnecessary translation of qemu_config_parse()
  erros to -EINVAL at block/blkdebug.c:read_config()
  * Suggsted-by: Markus Armbruster <armbru@redhat.com>

Eduardo Habkost (2):
  config: qemu_config_parse() return number of config groups
  vl: Print warning when a default config file is loaded

 block/blkdebug.c   |  1 -
 util/qemu-config.c | 15 +++++++--------
 vl.c               |  6 ++++++
 3 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.11.0.259.g40922b1
