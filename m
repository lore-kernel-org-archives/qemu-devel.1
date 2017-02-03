Received: from eggs.gnu.org ([2001:4830:134:3::10]:44466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZa9t-0000WP-IV
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cZa9o-0007Io-Tv
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:27:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cZa9o-0007IU-OH
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:27:52 -0500
Message-ID: <1486114065.16444.17.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Feb 2017 10:27:45 +0100
In-Reply-To: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
References: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] KVM/QEMU on Raspberry Pi 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pekka Enberg <penberg@iki.fi>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>

On Do, 2017-02-02 at 16:44 +0200, Pekka Enberg wrote:
> Hi,
>=20
> Has anyone been able to successfully run QEMU/KVM under Raspberry Pi 3?

Yes.  The bits are not yet upstream though (Cc'ing alex for status).

> I have installed 64-bit Fedora 24 by Gerd Hoffmann on the hardware:
>=20
>    https://www.kraxel.org/blog/2016/04/fedora-on-raspberry-pi-updates/

Good.  Those kernels have the kernel patches already included.

> and updated to QEMU 2.8.0 from rawhide:

Not good.  You need qemu patches too.

https://www.kraxel.org/cgit/qemu/log/?h=3Dv28/arm-no-irqchip

> I also tried to enable GIC v3 by adding the =E2=80=9C-machine gic-version=
=3D3=E2=80=9D=20

/me runs gic-version=3D2.

cheers,
  Gerd
