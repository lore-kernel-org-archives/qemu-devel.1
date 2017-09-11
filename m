Received: from eggs.gnu.org ([2001:4830:134:3::10]:35283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drIoA-0000Rx-JI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drIo7-0003mc-FM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:07:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1drIo7-0003il-4R
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 03:06:59 -0400
Message-ID: <59B63606.6050900@huawei.com>
Date: Mon, 11 Sep 2017 15:06:46 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RESEND] Question about the userfaultfd write-protect
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aarcange@redhat.com
Cc: linux-kernel@vger.kernel.org, kvm <kvm@vger.kernel.org>, QEMU-DEV <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, Gonglei <arei.gonglei@huawei.com>, "Longpeng(Mike)" <longpeng2@huawei.com>

(Add Zhanghailiang and Gonglei)


Hi Andrea,

We've implemented a demo of KVM live memory snapshot based on the userfaultfd
write-protect series in your private
tree(https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/log/). We did
a little hack on that series to make the demo works.

Zhang had discussed with you about this one or two years ago([1][2]), so do you
have any plan to make this series upstream ? If you will, then what is the time
schedule ? We really expect the userfaultfd write-protect series would be merged.

References:
[1] https://lists.gnu.org/archive/html/qemu-devel/2016-01/msg00664.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg02891.html

-- 
Regards,
Longpeng(Mike)
