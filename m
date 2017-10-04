Received: from eggs.gnu.org ([2001:4830:134:3::10]:48438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dzfH3-0008MV-1d
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dzfGz-0004sp-U5
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:43:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dzfGz-0004r2-NV
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 04:43:21 -0400
Message-ID: <1507106598.27227.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 04 Oct 2017 10:43:18 +0200
In-Reply-To: <CAFEAcA-8gaOhkuNX9hBt0Ofg-CKkJ-v8puHJ4K3QOq0ZGMgB5w@mail.gmail.com>
References: <20170929110052.6111-1-kraxel@redhat.com>
	<CAFEAcA-8gaOhkuNX9hBt0Ofg-CKkJ-v8puHJ4K3QOq0ZGMgB5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/3] Usb 20170929 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> This fails to build from clean (x86-64 Linux host):
> 
> make[1]: *** No rule to make target '../hw/usb/host-stub.o', needed
> by
> 'qemu-system-microblaze'. Stop.
> 
> (and similar for other targets).

/me looks puzzled.

There is a "hw/usb/host-stub.c" file in the repo, so I fail so see why
make thinks it can't build the object file ...

Also it works fine in my testing, including a full build of all targets
(some with and some without usb support).

cheers,
  Gerd
