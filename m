Received: from eggs.gnu.org ([2001:4830:134:3::10]:44796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCNdO-0000lo-NY
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gCNdO-0002c4-5K
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:35:34 -0400
Date: Tue, 16 Oct 2018 13:35:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181016113523.GD5620@dhcp-200-186.str.redhat.com>
References: <20181016103105.30927-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181016103105.30927-1-berrange@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] crypto: initialize sector
 size even when opening with no IO flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 16.10.2018 um 12:31 hat Daniel P. Berrang=E9 geschrieben:
> The qcow2 block driver expects to see a valid sector size even when it
> has opened the crypto layer with QCRYPTO_BLOCK_OPEN_NO_IO.
>=20
> Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Thanks, applied to the block branch (and staged before the other patch
that exposed the bug).

Kevin
