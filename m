Received: from eggs.gnu.org ([209.51.188.92]:44429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <copymaster@howtolinux.de>) id 1gvDpv-0005Ck-Jh
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 23:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <copymaster@howtolinux.de>) id 1gvDpr-000131-T1
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 23:13:50 -0500
Received: from mout7.gn-server.de ([87.238.194.234]:41672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <copymaster@howtolinux.de>)
	id 1gvDpq-0000qf-0s
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 23:13:47 -0500
Received: from mout14.gn-server.de ([87.238.194.241])
	by mout7.gn-server.de with esmtp (Exim 4.84_2)
	(envelope-from <copymaster@howtolinux.de>) id 1gvDpT-0006Ir-Ae
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 05:13:23 +0100
Received: from pp1.greatnet.de ([178.254.50.204])
	by mout14.gn-server.de with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.88)
	(envelope-from <copymaster@howtolinux.de>) id 1gvDpS-0007UT-QU
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 05:13:23 +0100
Received: from [192.168.178.103] (ip1f115d71.dynamic.kabel-deutschland.de
	[31.17.93.113])
	by pp1.greatnet.de (Postfix) with ESMTPSA id 88BA43330082
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 05:13:13 +0100 (CET)
From: Alexander Marx <copymaster@howtolinux.de>
Message-ID: <1ee13520-b5f2-b539-7112-4e7de79e7c16@howtolinux.de>
Date: Sun, 17 Feb 2019 05:13:17 +0100
MIME-Version: 1.0
Content-Language: de-DE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] Please help corrupt filesystem image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Dear List!

I have a big problem and hope you can help me.
I built a new windows 2016 domain with virtual servers. 2 dc and 9 rds
hosts.
I was nearly finished with the setup and ready to migrate the users from
old to new domain.

Then i had to restart the physical servers. Unfortunately 1 dc and 2 rds
hosts could not be startet anymore.
Error says:

qemu-img: Could not open 'vm-150-disk-0.qcow2': Could not read qcow2
header: Input/output error

Even worst, a qemu-img check  also gave that error. and i was not able
to do anything i found in the internet to fix it.
always that error or the qemu-img could not determine the format.

Is there a chance to fix these images? What can i do?

I have no backup because the domain was not fully configured. But if i
have to rebuild the whole domain, i will need several weeks for it.
Any help is appreciated.

Thank you

Alex
