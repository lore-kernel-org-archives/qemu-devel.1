Received: from eggs.gnu.org ([2001:4830:134:3::10]:59997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPVxc-0008Ju-7o
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPVxb-0006Ot-Hu
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 12:06:44 -0500
Date: Wed, 21 Nov 2018 18:06:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181121170635.GE4030@linux.fritz.box>
References: <20181120175646.25763-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181120175646.25763-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: fix nbd test to work correctly with
 raw images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

[ Cc: qemu-block ]

Am 20.11.2018 um 18:56 hat Daniel P. Berrang=E9 geschrieben:
> The first qemu-io command must honour the $IMGFMT that is set rather
> than hardcoding qcow2. The qemu-nbd commands should also set $IMGFMT
> to avoid the insecure format probe warning.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks, applied to the block branch.

Kevin
