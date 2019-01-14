Received: from eggs.gnu.org ([209.51.188.92]:56078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gj1T1-0006Qn-CU
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:35:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gj1Sx-000050-L3
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:35:45 -0500
Date: Mon, 14 Jan 2019 13:35:31 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190114123531.isddusgjtnl47wiv@sirius.home.kraxel.org>
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-16-philmd@redhat.com>
	<8a7ef73f-97a4-d270-9836-3936b7be1046@redhat.com>
	<f91cbbae-c3a0-d182-6de9-4ddd0c3892fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f91cbbae-c3a0-d182-6de9-4ddd0c3892fc@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 15/15] ui/console: Add
 "ui/pixelformat.h" to declare PixelFormat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-arm@nongnu.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, Jan 14, 2019 at 11:24:14AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 1/11/19 6:32 PM, Paolo Bonzini wrote:
> > On 11/01/19 15:08, Philippe Mathieu-Daud=E9 wrote:
> >> PixelFormat is used by "ui/console.h" and by "ui/qemu-pixman.h".
> >=20
> > ui/console.h already includes ui/qemu-pixman.h, just move it there?
>=20
> That was my first though but then noticed pixman seems a bit
> different/unrelated. If Gerd is OK I will do it. (I should have written
> that in the commit).

console depends on pixman anyway, so that move would be fine.

BTW: Should not be that hard to remove PixelFormat altogether, or move
the bits which are still needed to vnc which is the only user left
(beside deprecated sdl1 which should go away soon).

cheers,
  Gerd
