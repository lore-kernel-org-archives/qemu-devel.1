Received: from eggs.gnu.org ([2001:4830:134:3::10]:55402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cWKOI-0003Cb-I8
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cWKOH-0006wX-Tk
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:01:22 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:35863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cWKOH-0006w0-OE
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:01:21 -0500
Received: by mail-ot0-x22c.google.com with SMTP id 104so148095999otd.3
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 02:01:20 -0800 (PST)
MIME-Version: 1.0
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Wed, 25 Jan 2017 15:31:19 +0530
Message-ID: <CAC2QTZY0SJczV9_e3TwJbEXwyuTQXDQesAP5W6U0JeYvsV5uQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] migration: QEMU aborts migration of "none" machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

Hi Thomas,

I was able to reproduce the bug you encountered while trying to migrate a
"none" machine.

After digging deep and debugging the problem with gdb, I found that
bitmap_new() is the function that crashes qemu as it always has zero bits
being passed to it.

I had a discussion with Dave on the IRC yesterday and he suggested the
reason of crash being the absence of RAM ( since machine is "none") while
attempting the migration.

I am not sure what the ideal solution will be in this case; Do any of the
maintainers have any suggestions or even a starting point which I can
ponder upon?

Thanks
Ashijeet
