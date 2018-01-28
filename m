Received: from eggs.gnu.org ([2001:4830:134:3::10]:40072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1efp7T-0002m1-K0
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 10:43:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anatoly.trosinenko@gmail.com>) id 1efp7S-0002gZ-T4
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 10:43:47 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:39506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <anatoly.trosinenko@gmail.com>)
	id 1efp7S-0002g3-Mr
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 10:43:46 -0500
Received: by mail-oi0-x233.google.com with SMTP id j188so1972710oib.6
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 07:43:46 -0800 (PST)
MIME-Version: 1.0
From: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date: Sun, 28 Jan 2018 18:43:44 +0300
Message-ID: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

When QEMU is run with GTK UI, it changes what is drawn on its single window
when I press Ctrl-Alt-{1,2,3,4}. But when I use SDL2 UI, it opens multiple
windows: a separate window per each view (display, monitor, serial,
parallel). Is it by design or is it a bug?

-- 
Best regards,
Anatoly Trosinenko
e-mail: anatoly.trosinenko@gmail.com
