Received: from eggs.gnu.org ([2001:4830:134:3::10]:46640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3oo-0001qZ-Fj
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3on-000523-Og
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:34:58 -0500
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:41675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3on-00051l-JJ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:34:57 -0500
Received: by mail-pf0-x232.google.com with SMTP id j28so5645063pfk.8
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:34:57 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
	by smtp.gmail.com with ESMTPSA id
	u12sm12156810pfi.87.2017.12.07.13.34.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Dec 2017 13:34:54 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
	by serve.minyard.net (Postfix) with ESMTPA id 7184B96
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 15:34:52 -0600 (CST)
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:34:42 -0600
Message-Id: <1512682489-4474-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 0/7] Add PCI IPMI interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I had to do some testing, so I went ahead and did this.  Most of the
changes are re-arranging and splitting up code to separate out the
KCS/BT code from the ISA-specific code.

There are also some migration fixes here.

This series requires the previous series: Small IPMI (and other)
fixes
