Received: from eggs.gnu.org ([2001:4830:134:3::10]:33310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1f6Hn5-0006WQ-Ed
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1f6Hn4-0001Na-Ij
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:36:07 -0400
Message-ID: <1523460955.2942.5.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 11 Apr 2018 17:35:55 +0200
In-Reply-To: <20180410085200.GD5155@redhat.com>
References: <20180409154921.29906-1-wei@redhat.com>
	<20180409155634.GO18283@redhat.com>
	<6bb12858-3b4e-e92f-93ea-b8708c8be870@redhat.com>
	<1523346093.16671.23.camel@redhat.com>
	<20180410085200.GD5155@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] mach-virt: Change default cpu and
 gic-version setting to "max"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>
Cc: Wei Huang <wei@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, drjones@redhat.com, qemu-arm@nongnu.org

On Tue, 2018-04-10 at 09:52 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Apr 10, 2018 at 09:41:33AM +0200, Andrea Bolognani wrote:
> > I figure the people not explicitly specifying a CPU model on the
> > command line will probably also use '-M virt' instead of versioned
> > machine types, which means they will get a different guest behavior
> > after upgrading QEMU regardless.
>=20
> Libvirt uses versioned machine types and does not specify -cpu unless t=
he
> user has added <cpu> to their XML. IOW libvirt assumes the default CPU
> model is stable because that's what QEMU has promised in the past.

Hm, you have a point.

I wonder how well that works in practice, though. I started a guest
with no <cpu> element on my laptop and it ended up having

  vendor_id	 : GenuineIntel
  cpu family : 6
  model      : 6
  model name : QEMU Virtual CPU version 2.5+
  stepping   : 3

which I guess translates to the qemu64 CPU model, based on the
description. I have verified the -cpu option is not present on the
command line.

The name seems to imply that if I were using a QEMU release older
than 2.5 I would get a different CPU model, but maybe the stable CPU
guarantee you mention is just a fairly recent development.

I also know that ppc64 performs some trickery if you don't specify a
CPU model, so by default you get a behavior which is pretty close to
using -cpu host.

Basically I'm wondering how reasonable it is to expect a migratable
machine and a stable guest ABI when relying on QEMU defaults instead
of explicitly picking a CPU model.

--=20
Andrea Bolognani / Red Hat / Virtualization
