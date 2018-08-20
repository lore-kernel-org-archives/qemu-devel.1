Received: from eggs.gnu.org ([2001:4830:134:3::10]:51502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frql7-0002ih-Af
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1frql0-0002Sq-Gp
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:41 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:36265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1frqkw-0002E1-8r
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:26:30 -0400
Received: by mail-oi0-x22f.google.com with SMTP id n21-v6so28176955oig.3
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 13:26:26 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 20 Aug 2018 15:26:00 -0500
Message-Id: <1534796770-10295-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 0/8] Make the pm_smbus code more correct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

These changes make the pm_smbus device work more like the real thing,
adding block transfers, I2C block transfers, and interrupts.

It also adds vmstate transfer for the smbus device in patch 5.
That patch could probably be left out if that is not desirable.

Patch 7 works around a change made to work around an AMIBIOS bug and
is necessary for interrupts to work.

Patches 9 and 10 add vmstate transfer for SMBus EEPROMs, and obviously
requires patch 5 to work properly.  These could also be left out.
