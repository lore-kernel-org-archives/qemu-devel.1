Received: from eggs.gnu.org ([2001:4830:134:3::10]:51256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3zw-0003xT-Tb
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN3zw-0006Ix-8e
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:28 -0500
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:35457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN3zw-0006Ic-3Q
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:28 -0500
Received: by mail-pf0-x234.google.com with SMTP id j124so5675805pfc.2
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:27 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
	by smtp.gmail.com with ESMTPSA id
	a23sm10552691pfa.177.2017.12.07.13.46.24 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Dec 2017 13:46:25 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from t430.minyard.net (t430m.minyard.net [192.168.27.3])
	by serve.minyard.net (Postfix) with ESMTPA id 2C9A7377
	for <qemu-devel@nongnu.org>; Thu,  7 Dec 2017 15:46:23 -0600 (CST)
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:07 -0600
Message-Id: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 00/13] pm_smbus fixes and and IPMI SMBus device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The pm_smbus code has a few issues, and it's missing a lot of the
device capabilities required by IPMI.  This has been submitted
before, but it has some new things, like vmstate handling for the
smbus devices.
