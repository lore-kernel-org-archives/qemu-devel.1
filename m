Received: from eggs.gnu.org ([2001:4830:134:3::10]:58165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKkPi-0000d0-G4
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKkPh-0003O1-Lu
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:59:46 -0400
Received: from ssl.serverraum.org ([2a01:4f8:222:d45::1:2]:47203)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1fKkPh-0003LX-El
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:59:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Mon, 21 May 2018 14:59:42 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180509034658.26455-14-f4bug@amsat.org>
References: <20180509034658.26455-1-f4bug@amsat.org>
	<20180509034658.26455-14-f4bug@amsat.org>
Message-ID: <4ffdadd450170974d33c44022b5dc310@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 13/14] sdcard: Add a "validate-crc"
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?Philippe_Mathieu-Daud?= =?UTF-8?Q?=C3=A9?= <philippe.mathieu.daude@gmail.com>

Am 2018-05-09 05:46, schrieb Philippe Mathieu-Daud=C3=A9:
> Since not all modelled controllers use the CRC verification (which is
> somehow expensive), let the controller have a configurable property
> to enable verification.
>=20
> So far only the Milkymist controller uses it.
>=20
> This silent the Coverity warning:
>=20
>   "Code block is unreachable because of the syntactic structure of the
> code (CWE-561)"
>=20
> and fixes the following issue:
>=20
> - CID1005332 (hw/sd/sd.c::sd_req_crc_validate) Structurally dead code
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Tested-by: Michael Walle <michael@walle.cc>

-michael
