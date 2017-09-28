Received: from eggs.gnu.org ([2001:4830:134:3::10]:45854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongyi.zhao@gmail.com>) id 1dxZRd-0004pk-Qy
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongyi.zhao@gmail.com>) id 1dxZRW-0003ZH-Ep
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:05:41 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:52226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongyi.zhao@gmail.com>)
	id 1dxZRW-0003Vr-9W
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 10:05:34 -0400
Received: by mail-oi0-x231.google.com with SMTP id p126so2404534oih.9
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 07:05:33 -0700 (PDT)
MIME-Version: 1.0
From: Hongyi Zhao <hongyi.zhao@gmail.com>
Date: Thu, 28 Sep 2017 22:05:31 +0800
Message-ID: <CAGP6PO+pJO6iiXh_CeHRxbn__JGzOSMw60spJv3LC+WRZbbzXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] ehci warning: guest requested more bytes than allowed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all,

I use the lastest git version of qemu on Debian stretch, then I
install the masos sierra as the guest.

When I run the macos guest by using the qemu-system-x86_64 from
command line, I always see the following info:

---------------------------
ehci warning: guest requested more bytes than allowed
processing error - resetting ehci HC
ehci warning: guest requested more bytes than allowed
processing error - resetting ehci HC
ehci warning: guest requested more bytes than allowed
processing error - resetting ehci HC
---------------------------

Any hints for this issue?

Regards
-- 
Hongsheng Zhao <hongyi.zhao@gmail.com>
Institute of Semiconductors, Chinese Academy of Sciences
GnuPG DSA: 0xD108493
