Received: from eggs.gnu.org ([2001:4830:134:3::10]:47640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gHWZY-0000ju-9H
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gHWZU-0002kJ-Qc
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:08:52 -0400
Received: from m12-12.163.com ([220.181.12.12]:42178)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gHWZT-0000hb-Om
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:08:48 -0400
MIME-Version: 1.0
From: Li Qiang <liq3ea@163.com>
Date: Wed, 31 Oct 2018 00:08:21 +0800
Message-Id: <5BD881F6.0B8479.13021@m12-12.163.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [Question] About object oriented programming in qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hello all,

Today I read the BusClass=E2=80=99 definition.

The comment=20
/* FIXME first arg should be BusState */
remind me that OOP in qemu is not very OOP.

Maybe we should take the first arg as the Object pointer, just as the cpp=
=E2=80=99s this pointer.

For example, we can define the BusClass function as this

void (*print_dev)(BusState*, Monitor *mon, DeviceState *dev, int indent);
char *(*get_dev_path)(BusState*,  DeviceState *dev);
char *(*get_fw_dev_path)(BusState*, DeviceState *dev);

So we don=E2=80=99t need get the BusState in the callback function, such as=
 =E2=80=98usb_bus_dev_print=E2=80=99.

I want to know do do you think it make senses?
If not I will not spend time to write the patch.

Thanks,
Li Qiang
