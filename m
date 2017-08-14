Received: from eggs.gnu.org ([2001:4830:134:3::10]:37278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhKNh-0003Pf-Pv
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dhKNe-00015I-LF
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:46:29 -0400
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:34239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dhKNe-00014x-Gf
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 14:46:26 -0400
Received: by mail-io0-x244.google.com with SMTP id m88so8018694iod.1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 11:46:26 -0700 (PDT)
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <695CE828-CE3F-48D0-B20E-7B88C76453B8@gmail.com>
Date: Mon, 14 Aug 2017 14:46:22 -0400
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

Sorry but there appears to be an issue with your patchset. I ran this =
command:

./configure --target-list=3Dppc-softmmu,i386-softmmu

Then saw this error message:=20

error: pathspec 'ui/keycodemapdb' did not match any file(s) known to =
git.

Running 'make' I saw this error message:

make: *** No rule to make target `ui/input-keymap-atset1-to-qcode.c', =
needed by `Makefile'.  Stop.
make: *** Waiting for unfinished jobs....

Running the 'make clean' command produces this error message:

make[1]: *** No rule to make target `ui/input-keymap-atset1-to-qcode.c', =
needed by `Makefile'.  Stop.
make: *** [clean] Error 1

Perhaps a missing patch?=
