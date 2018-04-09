Received: from eggs.gnu.org ([2001:4830:134:3::10]:60181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5TXe-0007M9-D3
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f5TXd-0004sT-Ox
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:56:50 -0400
Date: Mon, 9 Apr 2018 11:56:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180409095632.GD5294@localhost.localdomain>
References: <20180404233238.8068-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180404233238.8068-1-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] hw/block/pflash_cfi: fix
 off-by-one error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, David Engraf <david.engraf@sysgo.com>, qemu-stable@nongnu.org

Am 05.04.2018 um 01:32 hat Philippe Mathieu-Daud=E9 geschrieben:
> ASAN reported:
>=20
>     hw/block/pflash_cfi02.c:245:33: runtime error: index 82 out of boun=
ds for type 'uint8_t [82]'
>=20
> Since the 'cfi_len' member is not used, remove it to keep the code safe=
r.
>=20
> Reported-by: AddressSanitizer
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Cc: qemu-stable@nongnu.org

Thanks, applied to the block branch.

Kevin
