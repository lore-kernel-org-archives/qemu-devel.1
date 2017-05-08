Received: from eggs.gnu.org ([2001:4830:134:3::10]:38723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1d7au9-0003kT-5J
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1d7au5-0001KC-58
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:08:17 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:33783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1d7au4-0001Ja-V2
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:08:13 -0400
Received: by mail-oi0-x22f.google.com with SMTP id w10so38432474oif.0
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 22:08:11 -0700 (PDT)
Received: from [192.168.43.158] (me95336d0.tmodns.net. [208.54.83.233])
	by smtp.googlemail.com with ESMTPSA id
	c47sm6363637otc.28.2017.05.07.22.08.10 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 07 May 2017 22:08:10 -0700 (PDT)
From: Rob Landley <rob@landley.net>
Message-ID: <619adaac-955d-c6f6-f137-ff627b7cbfb0@landley.net>
Date: Mon, 8 May 2017 00:08:09 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] How do you -sd squashfs.img without truncating?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As far as I can tell "qemu-system-arm -M vexpress-a9" only implements sd
card, not any conventional hard drive, and it uses an sdcard block size
of 262144 bytes rounded down. This means when I create a squashfs image
and feed it in through the sd card, it truncates it.

Wouldn't -sd rounding _up_ be more useful?

Rob
