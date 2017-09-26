Received: from eggs.gnu.org ([2001:4830:134:3::10]:46987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwt5l-0005BY-KK
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwt5k-0001r8-M4
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:52:17 -0400
References: <1506441116-16627-1-git-send-email-thuth@redhat.com>
	<CAKmqyKOCsyCHnaNzo_zrRQjZi30ENdPoSc+dFehHvevm-9nrZg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cbcf25a4-db9c-910f-fdbc-b7620d013b14@redhat.com>
Date: Tue, 26 Sep 2017 18:52:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOCsyCHnaNzo_zrRQjZi30ENdPoSc+dFehHvevm-9nrZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/xlnx-zynqmp: Mark the "xlnx,
 zynqmp" device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 26.09.2017 18:36, Alistair Francis wrote:
> On Tue, Sep 26, 2017 at 8:51 AM, Thomas Huth <thuth@redhat.com> wrote:
>> The device uses serial_hds in its realize function and thus can't be
>> used twice. Apart from that, the comma in its name makes it quite hard
>> to use for the user anyway, since a comma is normally used to separate
>> the device name from its properties when using the "-device" parameter
>> or the "device_add" HMP command.
>=20
> Is it worth changing the name now then as well?

Not sure, was there a reason for this name? E.g. is it used in a device
tree somewhere somehow? Anyway, with user_creatable =3D false, I think it
is not so urgent anymore to change it.

>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>=20
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks!

 Thomas
