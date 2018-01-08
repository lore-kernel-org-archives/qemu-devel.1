Received: from eggs.gnu.org ([2001:4830:134:3::10]:40877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYfuf-0000Jm-Rs
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eYfua-0003aE-Sy
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:29:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eYfua-0003Zj-KO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 17:28:56 -0500
Date: Mon, 8 Jan 2018 20:28:53 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180108222853.GL6646@localhost.localdomain>
References: <20180108205052.24385-1-vincent@bernat.im>
	<20180108211623.GJ6646@localhost.localdomain>
	<m3d12k9fyj.fsf@luffy.cx>
	<20180108221422.GK6646@localhost.localdomain>
	<m38td89ej7.fsf@luffy.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m38td89ej7.fsf@luffy.cx>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-i386: add pcid to both Sandy Bridge
 and Ivy Bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vincent Bernat <vincent@bernat.im>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On Mon, Jan 08, 2018 at 11:22:36PM +0100, Vincent Bernat wrote:
>  =E2=9D=A6  8 janvier 2018 20:14 -0200, Eduardo Habkost <ehabkost@redha=
t.com>=C2=A0:
>=20
> >> What are the consequences of running a too old kernel? Would KVM jus=
t
> >> hide PCID flag?
> >
> > On an old kernel, the SandyBridge and IvyBridge CPU models will
> > be unexpectedly become not runnable.
>=20
> But, isn't it the same for more recent models that already have PCID
> enabled?

Yes, the more recent models are already not runnable on those
hosts.  The key here is "unexpectedly": management software can
assume that the CPU model won't become unrunnable when it was
runnable in the past, and logic that decides if/where a VM can be
started (or migrated to) might break.

--=20
Eduardo
