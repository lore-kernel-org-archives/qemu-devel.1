Received: from eggs.gnu.org ([2001:4830:134:3::10]:36130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1dKzms-0000qi-B7
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1dKzmr-0005wN-GD
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:20:10 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:34219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1dKzmr-0005vH-Al
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 00:20:09 -0400
Received: by mail-it0-x244.google.com with SMTP id 201so14648935itu.1
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 21:20:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <149741206273.576.11299001383096762722@4a9a010726c0>
References: <1497411544-80213-1-git-send-email-liqiang6-s@360.cn>
	<149741206273.576.11299001383096762722@4a9a010726c0>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 14 Jun 2017 12:20:07 +0800
Message-ID: <CAKXe6SLoc3XPMaSme-qWjQJOyrJLKZyMyX-zCiuHtiL4c2ZmVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb: xhci: fix info leak when writing
 event to the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: famz@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liqiang6-s@360.cn>, P J P <ppandit@redhat.com>

2017-06-14 11:47 GMT+08:00 <no-reply@patchew.org>:

> Hi,
>
> This series failed automatic build test. Please find the testing commands
> and
> their output below. If you have docker installed, you can probably
> reproduce it
> locally.
>
>
>
>   CC      hw/timer/a9gtimer.o
> In file included from /tmp/qemu-test/src/hw/net/vmxnet3.c:30:
> /tmp/qemu-test/src/include/migration/register.h:18: error: redefinition
> of typedef =E2=80=98LoadStateHandler=E2=80=99
> /tmp/qemu-test/src/include/migration/vmstate.h:32: note: previous
> declaration of =E2=80=98LoadStateHandler=E2=80=99 was here
>


Seems not related with my patch.

Thanks.
