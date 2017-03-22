Received: from eggs.gnu.org ([2001:4830:134:3::10]:50790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cqa9E-00067X-MP
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <janne.huttunen@nokia.com>) id 1cqa9A-000293-Qc
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:53:32 -0400
Received: from mail-db5eur01on0133.outbound.protection.outlook.com
	([104.47.2.133]:4313
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <janne.huttunen@nokia.com>)
	id 1cqa9A-000289-6f
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 02:53:28 -0400
Message-ID: <1490164614.19055.31.camel@nokia.com>
From: Janne Huttunen <janne.huttunen@nokia.com>
Date: Wed, 22 Mar 2017 08:36:54 +0200
In-Reply-To: <11a3eab4-77f8-87ea-9558-299fbfc77a07@redhat.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
	<11a3eab4-77f8-87ea-9558-299fbfc77a07@redhat.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 2017-03-21 at 18:55 +0100, Paolo Bonzini wrote:
>=20
> > Since real HW has this capability, there exist certain
> > auxiliary systems that are built on it. Having similar
> > semantics available in QEMU allows me to build a virtual
> > machine that works with these systems without modifying
> > them in any way.
>
> How does real hardware do it?=C2=A0=C2=A0I suppose you'd do it with a fir=
mware
> setup menu or something like that; would it be enough to add a way to
> modify bootindex during runtime?

On the real hardware the "boot once" really means *once*
i.e. it only affects the next reboot regardless of how
the next boot is triggered (reset button, power button,
software, etc.). After the next boot the normal boot
order is automatically restored.

Theoretically it should be possible to get a close
approximation of this by changing the main boot order,
waiting for the boot to happen and then restoring the
original order back. This would require having some
process that constantly monitors what QEMU is doing so
that it can notice when the boot happens and then
restore the order. I'm trying to avoid having such
a process if possible, which in this case means that
QEMU would need to restore the order by itself.
