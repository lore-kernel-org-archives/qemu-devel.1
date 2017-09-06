Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1dpZDG-0006i3-2H
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:13:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlfightup@gmail.com>) id 1dpZDB-0001iq-28
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:13:46 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:34888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlfightup@gmail.com>) id 1dpZDA-0001iF-SB
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:13:40 -0400
Received: by mail-yw0-x242.google.com with SMTP id s128so3214265yws.2
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 05:13:39 -0700 (PDT)
MIME-Version: 1.0
From: Paul Schlacter <wlfightup@gmail.com>
Date: Wed, 6 Sep 2017 20:13:38 +0800
Message-ID: <CADak6y7DSednJgLkivprv0fAkLvE2=Dge0LzNJ0MnigvBEz+_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] how to modify or add machines type ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I made the default config build the qemu-kvm , But I used virsh xml
corresponding machine-type inconsistent, resulting in an error.

error:
2017-09-06T12:16:36.036200Z qemu-kvm: -machine
pc-i440fx-rhel7.0.0,accel=kvm,usb=off: unsupported machine type
Use -machine help to list supported machines


Is there any way to modify the machines in qemu-kvm?


[root@nova02 qemu-2.6.0]# /usr/libexec/qemu-kvm -M ?
Supported machines are:
pc                   Standard PC (i440FX + PIIX, 1996) (alias of
pc-i440fx-2.6)
pc-i440fx-2.6        Standard PC (i440FX + PIIX, 1996) (default)
pc-i440fx-2.5        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-2.4        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-2.3        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-2.2        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-2.1        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-2.0        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-1.7        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-1.6        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-1.5        Standard PC (i440FX + PIIX, 1996)
pc-i440fx-1.4        Standard PC (i440FX + PIIX, 1996)
pc-1.3               Standard PC (i440FX + PIIX, 1996)
pc-1.2               Standard PC (i440FX + PIIX, 1996)
pc-1.1               Standard PC (i440FX + PIIX, 1996)
pc-1.0               Standard PC (i440FX + PIIX, 1996)
pc-0.15              Standard PC (i440FX + PIIX, 1996)
pc-0.14              Standard PC (i440FX + PIIX, 1996)
pc-0.13              Standard PC (i440FX + PIIX, 1996)
pc-0.12              Standard PC (i440FX + PIIX, 1996)
pc-0.11              Standard PC (i440FX + PIIX, 1996)
pc-0.10              Standard PC (i440FX + PIIX, 1996)
q35                  Standard PC (Q35 + ICH9, 2009) (alias of pc-q35-2.6)
pc-q35-2.6           Standard PC (Q35 + ICH9, 2009)
pc-q35-2.5           Standard PC (Q35 + ICH9, 2009)
pc-q35-2.4           Standard PC (Q35 + ICH9, 2009)
isapc                ISA-only PC
none                 empty machine
