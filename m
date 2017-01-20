Received: from eggs.gnu.org ([2001:4830:134:3::10]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1cUZas-0002tU-Cq
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1cUZap-00006h-8d
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:51:06 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vase@selfip.ru>) id 1cUZao-0008WP-Q8
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:51:03 -0500
Received: by mail-wm0-x230.google.com with SMTP id c206so44443630wme.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 05:51:01 -0800 (PST)
MIME-Version: 1.0
Sender: vase@selfip.ru
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Fri, 20 Jan 2017 16:50:39 +0300
Message-ID: <CACaajQsdnojBg-y8+2sAAtUx+aUtTsmqUTKKUBwSfr3QcV+vzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] questions and help with tight png encoding in qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi! I'm try to add support for TightPng to some node js package (not noVNC)
and stuck with some issues. I found some rfb spec description but may
be it not accurate in case of tight png...
https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#tight-encoding

1)  Rectangle with tightpng encoding sended with Encoding Tight or TightPng ?
As i see qemu sends encoding TightPng (-260)

2) I'm try to read len of png data by reading byte (b) from the stream
and if (b 0x80) then len += (b & 0x7f) << 7 and  read next byte, if (b
& 0x80) then len += (b & 0xff) << 14; but after that i need to skip 8
byte from stream to get png data... Can somebody correct me with len
calculating?

Thanks for any help!

-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
