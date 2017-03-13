Received: from eggs.gnu.org ([2001:4830:134:3::10]:58841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cnGtM-0000e9-6k
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cnGtJ-0005Zo-4Q
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:43:28 -0400
Received: from ip35.imatronix.com ([200.73.112.45]:42856
	helo=cpanel.imatronix.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kripper@imatronix.cl>)
	id 1cnGtI-0005K9-NC
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:43:25 -0400
Received: from [200.73.112.45] by cpanel.imatronix.com with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.88)
	(envelope-from <kripper@imatronix.cl>) id 1cnGsZ-00055j-2G   
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 00:42:39 -0300
From: Christopher Pereira <kripper@imatronix.cl>
Message-ID: <2e5a75c0-b142-5e23-4314-445385b2cdb6@imatronix.cl>
Date: Mon, 13 Mar 2017 00:42:40 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Swap disks virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We are currently providing Linux swap disks with QEMU driver, virtio bus 
and qcow2 type.

Do you know any alternatives that provide better performance?

Considering that swap disks contain less critical data, QEMU could avoid 
disk IOs by using unassigned memory whenever possible. This could also 
be handled by the underlying linux filesystem of course. Can we tell 
QEMU to use the linux swap disk for creating a guest swap disk? What's 
the state of the art regarding swap disks virtualization?

Best regards,

-- 

*J. Christopher Pereira*
IMATRONIX S.A.
www.imatronix.com
