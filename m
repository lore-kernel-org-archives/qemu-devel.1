Received: from eggs.gnu.org ([2001:4830:134:3::10]:46934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1co3Hy-0002XF-7z
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1co3Hw-0004fy-Fd
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:24:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1co3Hw-0004fq-9r
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 03:24:04 -0400
Message-ID: <1489562641.15659.16.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 15 Mar 2017 08:24:01 +0100
In-Reply-To: <1489561105.24841.25.camel@nokia.com>
References: <cover.1489494746.git.janne.huttunen@nokia.com>
	<1489510640.8844.18.camel@redhat.com>
	<1489561105.24841.25.camel@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RFC][PATCH 0/6] "bootonceindex" property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janne Huttunen <janne.huttunen@nokia.com>
Cc: qemu-devel@nongnu.org

   Hi,

> The short answer: emulating real hardware.
>=20
> Since real HW has this capability, there exist certain
> auxiliary systems that are built on it. Having similar
> semantics available in QEMU allows me to build a virtual
> machine that works with these systems without modifying
> them in any way.

Ok, that is reason enough.

Adding bootonceindex everywhere doesn't look like the best plan to me
though.  Possibly we can pimp up bootindex in a backward-compatible way?
Something like bootindex=3D<normal>[.<once>] ?

cheers,
  Gerd
