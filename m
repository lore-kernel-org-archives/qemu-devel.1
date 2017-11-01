Received: from eggs.gnu.org ([2001:4830:134:3::10]:60716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1e9nhc-0001qL-Gb
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:44:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1e9nhb-0000c9-MJ
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:44:44 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:49417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlfightup@gmail.com>) id 1e9nhb-0000bs-HT
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 03:44:43 -0400
Received: by mail-oi0-x231.google.com with SMTP id w197so2245698oif.6
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 00:44:43 -0700 (PDT)
MIME-Version: 1.0
From: Paul Schlacter <wlfightup@gmail.com>
Date: Wed, 1 Nov 2017 15:44:41 +0800
Message-ID: <CADak6y5eSo9=C2FJx+cTdqxArWeQqNDAvVgY+vS7H-9yGeuZvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qemu disk use writeback don't take effect in centos
 7.2 1511
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qemu version:  2.9.0
image: centos 7.2 1511 raw
cache mode: writeback


In centos7.2 time, the use of writeback and none, the result of dd disk is
the same io, no change

But I replaced centos7.1 centos7.3 centos7.4 when writeback was
significantly faster than none


Would like to ask what is going on, how to solve ?
