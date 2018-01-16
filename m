Received: from eggs.gnu.org ([2001:4830:134:3::10]:59561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZu-0007s8-9M
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1ebFZr-0000kH-5j
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:14 -0500
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:45258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1ebFZr-0000hm-1Q
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 19:58:11 -0500
Received: by mail-oi0-x22d.google.com with SMTP id j129so9487466oib.12
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 16:58:09 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 15 Jan 2018 18:57:52 -0600
Message-Id: <1516064279-14816-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] Small IPMI fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Eric Blake <eblake@redhat.com>

These are some fixes I've had for a while (mostly).  They are small
fixes and additions for various things.  It would be nice to be able
to get these into the upcoming release.

I also add myself as the maintainer for the IPMI code, since that
seemed appropriate.

Changes in v2:

I removed the "other" fixes (the one to vl.c) from the previous patch
set, these are all IPMI-related changes.  I also moved adding myself
as the IPMI maintainer to the first patch, per Marc-André.
