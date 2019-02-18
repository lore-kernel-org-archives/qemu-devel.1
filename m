Received: from eggs.gnu.org ([209.51.188.92]:48294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gvc54-0002Eu-Vg
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 01:07:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gvc54-0007jb-AR
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 01:07:06 -0500
Received: from mail-it1-x132.google.com ([2607:f8b0:4864:20::132]:52308)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gvc54-0007in-1r
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 01:07:06 -0500
Received: by mail-it1-x132.google.com with SMTP id r11so38579818itc.2
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 22:07:05 -0800 (PST)
Received: from worksec.oberlin.net (ip-210-181.oberlin.net. [208.66.210.181])
	by smtp.gmail.com with ESMTPSA id
	d6sm5245395ioc.44.2019.02.17.22.07.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 17 Feb 2019 22:07:03 -0800 (PST)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Message-Id: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
Date: Mon, 18 Feb 2019 01:07:02 -0500
Subject: [Qemu-devel] Testing sysbus devices
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

I've been working on some improvements to the pflash_cfi02 block device =
(interleaved flash devices similar to pflash_cfi01, multi-sector erase, =
nonuniform sector sizes, and some bug fixes and I'm planning on =
implementing sector erase suspend/resume commands in the near future).

There appear to be no existing tests for this device and I'm unsure what =
the appropriate way to add tests for sysbus devices is. -device can't be =
used because sysbus devices aren't user-creatable (and even if they =
were, creating the device wouldn't be sufficient since it wouldn't =
connect it to the sysbus).

Any suggestions would be appreciated.

Thank you,

--=20
Stephen Checkoway
