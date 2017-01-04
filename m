Received: from eggs.gnu.org ([2001:4830:134:3::10]:38985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.fangyi@huawei.com>) id 1cOhF8-0006Ev-EV
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:48:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.fangyi@huawei.com>) id 1cOhF7-0005SL-SG
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 03:48:22 -0500
From: "Fangyi (C)" <eric.fangyi@huawei.com>
Message-ID: <586CB62C.6080504@huawei.com>
Date: Wed, 4 Jan 2017 16:45:32 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] NBD handshake may block qemu main thread when socket
 delays or has packet loss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com
Cc: wu.wubin@huawei.com, eblake@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, subo7@huawei.com, lina.lulina@huawei.com, "jiangxiaoqing (C)" <sochin.jiang@huawei.com>

     As we all know, socket is in blocking mode when nbd is negotiating 
with the other end. If the network is poor because of delay or packet 
loss, socket read or write will return very slowly. The mainloop events 
won't be handled in time util nbd handshake ends.

     Any advices to solve the problem?
     Thanks,


Regards,
     FANG Yi.
