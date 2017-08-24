Received: from eggs.gnu.org ([2001:4830:134:3::10]:56988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkpIK-00033a-Me
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:23:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkpIH-0008Ha-J0
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:23:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dkpIH-0008HR-Cn
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:23:21 -0400
Message-ID: <1503570199.22313.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Aug 2017 12:23:19 +0200
In-Reply-To: <ad0f6973-af7e-61ba-c2da-3bb934eb63b7@redhat.com>
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
	<CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
	<be880655-0c04-8369-01fc-76dd6241ca78@redhat.com>
	<1503316706.26016.11.camel@redhat.com> <874lt1587y.fsf@linaro.org>
	<ad0f6973-af7e-61ba-c2da-3bb934eb63b7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> > How big?
> 
> The ArmVirtQemu firmware binary, and its matching varstore template,
> need to be padded to 64MB each, after the edk2 build process
> completes,
> before the fw binary, and a variable store created from the varstore
> template, can be passed to QEMU.
> 
> So, "pretty big".

Most of it is zeros though, so it wouldn't change on updates.
Actual content is almost 3MB (code + vars template combined).

cheers,
  Gerd
