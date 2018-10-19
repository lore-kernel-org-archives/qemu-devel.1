Received: from eggs.gnu.org ([2001:4830:134:3::10]:42795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDXtU-0007p3-0q
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:45:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDXtS-0007Og-QX
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:44:59 -0400
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-5-git-send-email-thuth@redhat.com>
	<CAFEAcA-ahq3Y4sgs=Vijq_fsDPgX4JuG0gGdMwE5oOLOrsvxjQ@mail.gmail.com>
	<a6b421a6-439e-ac87-0f96-b28ca349bc70@redhat.com>
	<CAAdtpL4M9zD3LPOMgQNtN50pKzZAsoKn0c_uBe5vajPFwUMJvQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b43a36a4-bb35-77e4-42e3-d15aebd618f9@redhat.com>
Date: Fri, 19 Oct 2018 18:44:50 +0200
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4M9zD3LPOMgQNtN50pKzZAsoKn0c_uBe5vajPFwUMJvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/5] configs: Add a CONFIG_UNIMP switch for
 the "unimplemented-device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>

On 19/10/2018 18:25, Philippe Mathieu-Daud=C3=A9 wrote:
>=20
> First because I'm using it heavily on MIPS and PPC boards, when no
> datashits are available.
> I'll submit that during the next merge window, although the MIPS tree
> seems now reluctant to that kind of hobbyist work.
>=20
> Second, because it is very clean when you implement a SoC to first
> start with an empty UNIMP region and a cpu core,
> then declare the mmio regions for each device (still UNIMP), then you
> can slowly add devices one at a time.
> This let you (me, so far) push at most a dozen of tiny patches in a
> working series, instead of a small series of a dozen of huge patches,
> or a series of 100 tiny patches.

I don't see however why it's a problem to add/remove CONFIG_UNIMP to
default-configs though (in the Kconfig world the board would "select
UNIMP").

Paolo
