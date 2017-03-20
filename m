Received: from eggs.gnu.org ([2001:4830:134:3::10]:38202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cpt9U-0005Xm-Vy
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cpt9R-000297-VJ
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:58:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34500
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cpt9R-00028s-Oe
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:58:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2K8rwsR064540
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:58:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 298wtxmxck-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:58:52 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Mar 2017 08:58:50 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Mar 2017 09:58:43 +0100
Message-Id: <20170320085844.15178-1-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 0/1] s390x: one bugfix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

The following changes since commit ebedf0f9cd46b617df331eecc857c379d574ac62:

  nios2: iic: Convert CPU prop to qom link (2017-03-18 18:22:54 +0000)

are available in the git repository at:

  git://github.com/cohuck/qemu tags/s390x-20170320

for you to fetch changes up to 3c788ebc6f6eef5ac6e9cb4a28c578abcf08247d:

  s390x/css: reassign subchannel if schid is changed after migration (2017-03-20 09:22:57 +0100)

----------------------------------------------------------------
One bugfix for device plug/unplug and migration in the
channel subsystem code.

----------------------------------------------------------------

Dong Jia Shi (1):
  s390x/css: reassign subchannel if schid is changed after migration

 hw/s390x/css.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.11.0
