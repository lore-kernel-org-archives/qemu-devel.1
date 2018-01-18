Received: from eggs.gnu.org ([2001:4830:134:3::10]:49699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ec8TS-0002W1-Of
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:35:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ec8TO-0000Yd-Qe
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:35:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ec8TO-0000T0-L0
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:35:10 -0500
Date: Thu, 18 Jan 2018 12:35:00 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180118113500.GA4853@localhost.localdomain>
References: <1513877118-3149-1-git-send-email-jack.schwartz@oracle.com>
	<20180115155413.GJ32271@localhost.localdomain>
	<2f56a075-ba01-4329-b46c-33b3d40000cb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2f56a075-ba01-4329-b46c-33b3d40000cb@oracle.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH QEMU v1 0/4] multiboot: bss_end_addr can be
 zero / cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jack Schwartz <jack.schwartz@oracle.com>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>, ehabkost@redhat.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, daniel.kiper@oracle.com, mst@redhat.com, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org

Am 17.01.2018 um 21:06 hat Jack Schwartz geschrieben:
> Before I proceed with adding my multiboot test file, I'll clarify here =
that
> I started with a version from the grub2 tree.=A0 In that file I expande=
d a
> header file, also from the same tree.=A0 Neither file had any license h=
eader,
> though the tree I got them from (Dated October 2017) contains the GNU G=
PLv3
> license file.

I see. QEMU as a whole is GPLv2, so this might be a problem. It's
probably not as bad as merging GPLv3 code into QEMU proper because it's
a standalone test kernel that I suppose could have a different license.
But IANAL and maybe it's safer not to go there.

Maybe it would be less hassle to just reimplement the tests, based on
the MIT licensed tests that are already in tests/multiboot/.

Kevin
