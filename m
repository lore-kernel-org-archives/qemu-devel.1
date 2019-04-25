Received: from eggs.gnu.org ([209.51.188.92]:50648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJZXb-0006JD-3D
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:15:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJZXa-0003Fl-54
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:15:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJZXV-0003EK-C6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:15:30 -0400
Date: Thu, 25 Apr 2019 10:15:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

On Wed, Apr 24, 2019 at 09:16:56AM +0800, Li Qiang wrote:
> Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > Is this endianess-safe? Or do you need to byteswap reboot_timeout if =
the
> > host and guest endianess does not match?
>=20
> Good question!
>=20
> IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream.

No.  Integers are defined to be little endian.  See fw_cfg_add_i64() for
example, there is an explicit cpu_to_le64() call for that.

cheers,
  Gerd
