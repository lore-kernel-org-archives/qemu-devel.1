Received: from eggs.gnu.org ([2001:4830:134:3::10]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eEFjw-0002UJ-G3
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:29:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1eEFjs-0006Rb-GD
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:29:32 -0500
Received: from mail-io0-x22e.google.com ([2607:f8b0:4001:c06::22e]:56934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1eEFjs-0006RP-BQ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:29:28 -0500
Received: by mail-io0-x22e.google.com with SMTP id t11so1555859iof.13
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 06:29:27 -0800 (PST)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <03123F70-98FA-439A-868C-855E63916259@gmail.com>
Date: Mon, 13 Nov 2017 09:29:25 -0500
Subject: [Qemu-devel] Command-line option to change ungrab key(s)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

Would you accept a patch that allows the user to change the mouse ungrab =
key(s) in QEMU?

It would look something like this:=20

-ungrab <key>=20

or=20

-ungrab <key>,<key>,...

If the user wanted the F19 key to be the ungrab key, this is what would =
be sent to QEMU:

-ungrab F19

If the user wanted F16 and F17 held down to ungrab the mouse, this is =
what would be sent to QEMU:

-ungrab F16,F17


Would this feature be something you would consider adding to QEMU?=
