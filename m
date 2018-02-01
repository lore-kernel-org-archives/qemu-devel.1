Received: from eggs.gnu.org ([2001:4830:134:3::10]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehK4q-0000J5-RZ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ehK4o-0001QW-ME
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:59:16 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:37937)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ehK4o-0001PK-Fu
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:59:14 -0500
Received: by mail-ot0-x22f.google.com with SMTP id v5so17930579oth.5
	for <qemu-devel@nongnu.org>; Thu, 01 Feb 2018 10:59:14 -0800 (PST)
Received: from serve.minyard.net ([47.184.168.85])
	by smtp.gmail.com with ESMTPSA id r2sm112206oif.13.2018.02.01.10.59.10
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 01 Feb 2018 10:59:10 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
	by serve.minyard.net (Postfix) with ESMTPA id D46B1377
	for <qemu-devel@nongnu.org>; Thu,  1 Feb 2018 12:59:09 -0600 (CST)
From: minyard@acm.org
Date: Thu,  1 Feb 2018 12:59:05 -0600
Message-Id: <1517511547-10147-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 0/2] Fix vmstate for IPMI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There were several issues with vmstate transfers in the IPMI devices.
This new version is heavily tested and should be much better.  It will
not be possible to migrate BT devices from older systems, it was too
broken to handle that.

Just to make sure I got this right, could somebody knowledgeable
take a glance at this?

Thanks,

-corey
