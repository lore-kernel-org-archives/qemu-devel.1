Received: from eggs.gnu.org ([2001:4830:134:3::10]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cF2zz-00035G-5u
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 13:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cF2zw-00079d-6t
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 13:00:51 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cF2zw-00073r-2K
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 13:00:48 -0500
Received: by mail-oi0-f45.google.com with SMTP id y198so461117596oia.1
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 10:00:26 -0800 (PST)
MIME-Version: 1.0
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 8 Dec 2016 23:29:24 +0530
Message-ID: <CAC2QTZa8paD4kaY+fWqwWiAu9NKsCTZr9-=Ldn78HPHAUE1ZSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] migration: Introduce a new "--only-migratable" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "dgilbert@redhat.com" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Dave,

I have added the compatibility of this option for both command line
and hotplug via qmp and hmp. Although, please confirm that making use
of "device_add" is the only way of hotplugging devices into a QEMU
instance.

With this sorted out, there is one special case left where the device
dynamically declares itself 'unmigratable' via migrate_add_blocker. I
have a query regarding that which is, what is the preferred action in
this scenario? Should I unmount the device or restrict the device from
becoming unmigratable in the first place.
For example, restrict 9pfs from mounting the filesystem (which you
explained previously).

Or is there a completely different solution in your mind?

Thanks
Ashijeet
