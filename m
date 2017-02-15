Received: from eggs.gnu.org ([2001:4830:134:3::10]:57288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cdwbm-0007Dx-O3
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cdwbi-0004w1-QO
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:46 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:35464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cdwbi-0004v3-H1
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:14:42 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v186so37931957wmd.0
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 02:14:41 -0800 (PST)
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Date: Wed, 15 Feb 2017 11:14:25 +0100
Message-Id: <20170215101427.23736-1-eduardo.otubo@profitbricks.com>
Subject: [Qemu-devel] [PATCH 0/2] add writeconfig command on monitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, armbru@redhat.com, Eduardo Otubo <eduardo.otubo@profitbricks.com>

This first patch extends the command line option `-writeconfig <file>' to a
command on HMP and QMP monitors. This is useful when live migrating after a
series of device hot plug events. One can just generate an updated config file
for the vm, transport it to the target host and start the vm with `-readconfig
<file>'.

The second patch re-includes the reference of the memory object on the config
file generated.

Eduardo Otubo (2):
  qmp/hmp: add writeconfig
  object_add not registering option

 hmp-commands.hx  | 14 ++++++++++++++
 hmp.c            | 10 +++++++++-
 hmp.h            |  1 +
 qapi-schema.json | 20 ++++++++++++++++++++
 ui/console.c     | 14 ++++++++++++++
 5 files changed, 58 insertions(+), 1 deletion(-)

-- 
2.11.0
