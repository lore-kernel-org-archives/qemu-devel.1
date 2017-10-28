Received: from eggs.gnu.org ([2001:4830:134:3::10]:51851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e8IzZ-0007KZ-51
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 00:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e8IzU-0002w4-7Y
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 00:45:05 -0400
Received: from mail-io0-x230.google.com ([2607:f8b0:4001:c06::230]:45478)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e8IzU-0002vh-2W
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 00:45:00 -0400
Received: by mail-io0-x230.google.com with SMTP id i38so16743379iod.2
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 21:44:59 -0700 (PDT)
Received: from [192.168.0.7] (d14-69-20-184.try.wideopenwest.com.
	[69.14.184.20])
	by smtp.gmail.com with ESMTPSA id 8sm3992841iob.32.2017.10.27.21.44.58
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 27 Oct 2017 21:44:58 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <7CA6B03C-DFAA-4A15-9E33-E3FAD6647140@gmail.com>
Date: Sat, 28 Oct 2017 00:44:56 -0400
Subject: [Qemu-devel] drive_add: file names with spaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

I'm trying to use an image file that has spaces in its file name (and =
sometimes in the path) to be used as a USB flash drive. When I try =
adding the image file using the drive_add command I see this error: =
drive_add: extraneous characters at the end of the line

I have tried using single and double quotes around the file name but =
this does not help. Is there a way to use files that have spaces in it's =
name with drive_add?=
