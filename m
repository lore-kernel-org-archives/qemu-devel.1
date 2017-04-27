Received: from eggs.gnu.org ([2001:4830:134:3::10]:45739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d3dWP-0001eb-FC
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d3dWK-0008EB-Mf
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:07:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d3dWK-0008BJ-GE
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:07:20 -0400
Message-ID: <1493276836.31995.38.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 27 Apr 2017 09:07:16 +0200
In-Reply-To: <201704271430117024953@zte.com.cn>
References: <201704271430117024953@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel]
 =?utf-8?q?New_function=3A=E3=80=80Remot_USB_support?=
 =?utf-8?q?_in_qemu?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuan.zhong@zte.com.cn
Cc: afaerber@suse.de, pbonzini@redhat.com, qemu-devel@nongnu.org, Hans de Goede <hdegoede@redhat.com>

On Do, 2017-04-27 at 14:30 +0800, yuan.zhong@zte.com.cn wrote:
> Mr. Hoffmann,
>=20
>=20
> Thank you for your time.
>=20
>=20
> This email will describe a new module that I'd like to commit to the
> qemu code source.
>=20
> We call it as remote usb, and this is features:
>=20
> 1. real usb device is aside on a windows client.
>=20
> 2. keeping a connection between the client and the VMs host OS
>=20
> 3. qemu simulate a remote usb device through our remote usb module
>=20
> 4. the communication between real usb device and the simulation remote
> usb is based on USB/IP protocol.

qemu supports that already.  It's called usb redirection.
https://www.spice-space.org/page/UsbRedir
https://github.com/SPICE/usbredir

usb redirection can use either plain tcp or a spice channel as
transport.  The spice client supports usb devices on windows clients.

Hans (Cc'ed, usbredir author) looked at the USB/IP protocol and found a
number of deficits and decided to not use it because of that.  I don't
remember the details though.

So I think using the existing usb redirection support is the better
option for you.

cheers,
  Gerd
