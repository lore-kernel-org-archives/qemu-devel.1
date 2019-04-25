Received: from eggs.gnu.org ([209.51.188.92]:54176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJZlq-0005qI-TQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJZlp-0003Fu-VL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hJZlp-0003EQ-Pg
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id l203so16517802oia.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 01:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
	<20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
In-Reply-To: <20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 25 Apr 2019 16:29:39 +0800
Message-ID: <CAKXe6SKvkJxauOPmBMS+CDPq9NS0qKpydkyOAuS7mHVrA8JVbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Li Qiang <liq3ea@163.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:15=E5=86=99=E9=81=93=EF=BC=9A

> On Wed, Apr 24, 2019 at 09:16:56AM +0800, Li Qiang wrote:
> > Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Is this endianess-safe? Or do you need to byteswap reboot_timeout if
> the
> > > host and guest endianess does not match?
> >
> > Good question!
> >
> > IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream.
>
> No.  Integers are defined to be little endian.  See fw_cfg_add_i64() for
> example, there is an explicit cpu_to_le64() call for that.
>


Yes, for the fw_cfg 'integer' entry it is stored as little endian.
But for the fw_cfg 'file' entry interpred as an integer, there is no
specify the endianess.

Thanks,
Li Qiang



> cheers,
>   Gerd
>
>
