Received: from eggs.gnu.org ([2001:4830:134:3::10]:58158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e1fLC-0007tz-HA
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1e1fL9-00017F-7g
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:11:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41434
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1e1fL9-00016X-23
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 17:11:55 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99L8pfk023779
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 17:11:50 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dggma8j4m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:11:50 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 15:11:49 -0600
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon,  9 Oct 2017 18:11:35 -0300
Message-Id: <20171009211136.31640-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/1] Avoid LMB unplug if a previous unplug
 isn't
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

v2:
- changed the approach: abort the LMB unplug if there is already
an unplug operation ongoing for the same DIMM.

v1 can be found at
http://lists.nongnu.org/archive/html/qemu-ppc/2017-10/msg00084.html

This fixes https://bugs.launchpad.net/qemu/+bug/1718118 .

Daniel Henrique Barboza (1):
  hw/ppc/spapr.c: abort unplug_request if previous unplug isn't done

 hw/ppc/spapr.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

-- 
2.13.6
