Received: from eggs.gnu.org ([2001:4830:134:3::10]:53604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpjg-0002Uc-Tq
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <makovick@gmail.com>) id 1eDpjd-00043Y-Rk
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:32 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:39971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <makovick@gmail.com>) id 1eDpjd-00042q-Kc
	for qemu-devel@nongnu.org; Sun, 12 Nov 2017 05:43:29 -0500
Received: by mail-wm0-x234.google.com with SMTP id b189so3027037wmd.5
	for <qemu-devel@nongnu.org>; Sun, 12 Nov 2017 02:43:29 -0800 (PST)
From: Jindrich Makovicka <makovick@gmail.com>
Date: Sun, 12 Nov 2017 11:42:38 +0100
Message-Id: <20171112104246.10007-1-makovick@gmail.com>
In-Reply-To: <20171023210803.20998-1-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
Subject: [Qemu-devel] [PATCH] SDL2 various fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>

Hi,

here is a revised patchset:

- sdl2: Do not hide the cursor on auxilliary windows 
    split into two

- sdl2: Only accept the hotkeys on the main window 
    reworked, also with a more descriptive commit message

- sdl2: Do not quit the emulator when an auxilliary window is closed
    added missing scon->hidden update

- sdl2: Fix broken display updating after the window is hidden
    added scon->hidden update instead + the SHOWN part changed
    the same way

Regards, Jindrich
