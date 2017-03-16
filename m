Received: from eggs.gnu.org ([2001:4830:134:3::10]:57617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gauravs.2010@gmail.com>) id 1coRxR-0006Nz-RP
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gauravs.2010@gmail.com>) id 1coRxQ-0002AM-NG
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:44:33 -0400
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:33744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gauravs.2010@gmail.com>)
	id 1coRxQ-00029r-J9
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:44:32 -0400
Received: by mail-ua0-x232.google.com with SMTP id u30so23006626uau.0
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 02:44:32 -0700 (PDT)
MIME-Version: 1.0
From: Gaurav Sharma <gauravs.2010@gmail.com>
Date: Thu, 16 Mar 2017 15:13:50 +0530
Message-ID: <CABiB5K7r5GRMGsQESzyr60X1EjhWVk2_Hyu=8ghJAZ83378tXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Device 'id' property not getting set for
 virtio-net-pci device type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I am using qemu 2.6.2 and i have the following option in my command line
"-device virtio-net-pci,netdev=net1,mac=XX:YY:XX:XX:99:99,id=n1". In the
realize function for virtio-net-pci the value of 'id' is not getting
reflected.

Is this a known issue or am i missing something ?

-Gaurav
