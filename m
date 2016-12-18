Received: from eggs.gnu.org ([2001:4830:134:3::10]:58269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cIlGN-0006N9-86
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 18:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cIlGJ-0006TC-Cp
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 18:53:07 -0500
Received: from ip35.imatronix.com ([200.73.112.45]:44683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kripper@imatronix.cl>)
	id 1cIlGI-00067e-VJ
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 18:53:03 -0500
Received: from [200.73.112.45] by ip35.imatronix.com with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.87)
	(envelope-from <kripper@imatronix.cl>) id 1cIlEz-0003KJ-BI   
	for qemu-devel@nongnu.org; Sun, 18 Dec 2016 20:51:41 -0300
From: Christopher Pereira <kripper@imatronix.cl>
Message-ID: <53e52412-cd32-cb9e-2261-882a7b5b84ea@imatronix.cl>
Date: Sun, 18 Dec 2016 20:52:19 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Can qemu reopen image files?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

We are doing a "qemu-img convert" operation (qcow2, with compression) to 
shorten the backing-chain (in the middle of the backing-chain).
In order to force qemu to reopen files, we do a save and restore operation.
Is there a faster way to reopen image files using virsh or qemu?

Best regards,
Christopher
