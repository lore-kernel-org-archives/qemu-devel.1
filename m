Received: from eggs.gnu.org ([209.51.188.92]:42837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <copymaster@howtolinux.de>) id 1gvDWv-0003V9-37
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 22:54:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <copymaster@howtolinux.de>) id 1gvDWr-0004SZ-G0
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 22:54:10 -0500
Received: from mout7.gn-server.de ([87.238.194.234]:55267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <copymaster@howtolinux.de>)
	id 1gvDWo-0004M0-GD
	for qemu-devel@nongnu.org; Sat, 16 Feb 2019 22:54:06 -0500
Received: from mout14.gn-server.de ([87.238.194.241])
	by mout7.gn-server.de with esmtp (Exim 4.84_2)
	(envelope-from <copymaster@howtolinux.de>) id 1gvDWj-0005sL-Ew
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 04:54:01 +0100
Received: from pp1.greatnet.de ([178.254.50.204])
	by mout14.gn-server.de with esmtps
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.88)
	(envelope-from <copymaster@howtolinux.de>) id 1gvDWj-0006iW-6c
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 04:54:01 +0100
Received: from [192.168.178.103] (ip1f115d71.dynamic.kabel-deutschland.de
	[31.17.93.113])
	by pp1.greatnet.de (Postfix) with ESMTPSA id E8E893326BDC
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 04:53:56 +0100 (CET)
From: Alexander Marx <copymaster@howtolinux.de>
Message-ID: <d5dc1bda-6b43-cbd6-3faa-69bb0ae45af4@howtolinux.de>
Date: Sun, 17 Feb 2019 04:54:00 +0100
MIME-Version: 1.0
Content-Language: de-DE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Even worst, a qemu-img check=C2=A0 also gave that error. and i was not ab=
le
to do anything i found in the internet to fix it.
always that error or the qemu-img could not determine the format.

Is there a chance to fix these images? What can i do?

I have no backup because the domain was not fully configured. But if i
have to rebuild the whole domain, i will need several weeks for it.
Any help is appreciated.

Thank you

Alex
