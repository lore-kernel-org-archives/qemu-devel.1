Received: from eggs.gnu.org ([2001:4830:134:3::10]:52212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1ekZDu-0001PU-BR
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 12:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1ekZDt-0006Sj-Me
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 12:46:02 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <B7504AC7-F974-4C7A-8FAA-C4D803C941E4@alex.org.uk>
Date: Sat, 10 Feb 2018 18:45:55 +0100
Content-Transfer-Encoding: quoted-printable
Message-Id: <10CE70C1-D812-485C-A498-8D5057D4F5A0@alex.org.uk>
References: <20180208132336.6519-1-edgar.kaziakhmedov@virtuozzo.com>
	<8eb7f38c-ff46-df7d-1d43-d5c98bfd4ff2@redhat.com>
	<B7504AC7-F974-4C7A-8FAA-C4D803C941E4@alex.org.uk>
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: increase maximum size of the
 PWRITE_ZERO request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alex Bligh <alex@alex.org.uk>, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, nbd list <nbd@other.debian.org>, vsementsov@virtuozzo.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, mreitz@redhat.com, den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>


> On 10 Feb 2018, at 18:43, Alex Bligh <alex@alex.org.uk> wrote:
>=20
> So I think a reasonable logic for Qemu would be to try NBD_CMD_INFO =
and find the maximum write size, and if that's unsupported use =
0xffffffff (capping at export size, or export size minus write offset).

Ur actually capping it at (2^16 - blocksize) would be the right thing to =
do (writes should be multiples of the block size).

--=20
Alex Bligh
