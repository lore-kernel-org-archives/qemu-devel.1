Received: from eggs.gnu.org ([2001:4830:134:3::10]:42982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1eEz6S-0002mg-LE
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng.mike@gmail.com>) id 1eEz6R-0001as-VA
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:55:48 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:49526)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <longpeng.mike@gmail.com>)
	id 1eEz6R-0001Z9-Qf
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 09:55:47 -0500
Received: by mail-oi0-x243.google.com with SMTP id r190so7142759oie.6
	for <qemu-devel@nongnu.org>; Wed, 15 Nov 2017 06:55:46 -0800 (PST)
MIME-Version: 1.0
From: "Longpeng(Mike)" <longpeng.mike@gmail.com>
Date: Wed, 15 Nov 2017 22:55:45 +0800
Message-ID: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [Question] why need to start all queues in
 vhost_net_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, "Longpeng(Mike)" <longpeng2@huawei.com>, arei.gonglei@huawei.com, king.wang@huawei.com, weidong.huang@huawei.com, stefanha@redhat.com, mst@redhat.com

Hi guys,

We got a BUG report from our testers yesterday, the testing scenario was
migrating a VM (Windows guest, *4 vcpus*, 4GB, vhost-user net: *7 queues*).

We found the cause reason, and we'll report the BUG or send a fix patch
to upstream if necessary( we haven't test the upstream yet, sorry... ).

We want to know why the vhost_net_start() must start *total queues* ( in our
VM there're 7 queues ) but not *the queues that current used* ( in our VM, guest
only uses the first 4 queues because it's limited by the number of vcpus) ?

Looking forward to your help, thx :)

-- 
Regards,
Longpeng
