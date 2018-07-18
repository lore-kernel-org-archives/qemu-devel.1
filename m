Received: from eggs.gnu.org ([2001:4830:134:3::10]:57362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ffjTI-0001zf-4g
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1ffjTH-0006Nq-AY
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 06:14:12 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 18 Jul 2018 12:14:07 +0200
From: Michael Walle <michael@walle.cc>
In-Reply-To: <20180702014022.12395-1-f4bug@amsat.org>
References: <20180702014022.12395-1-f4bug@amsat.org>
Message-ID: <be617722854ec9aba00e86e756336568@walle.cc>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] milkymist-minimac2: Use
 qemu_log_mask(GUEST_ERROR) instead of error_report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philippe.mathieu.daude@gmail.com>

Am 2018-07-02 03:40, schrieb Philippe Mathieu-Daud=C3=A9:
> qemu_log_mask(GUEST_ERROR) is more appropriate:
>=20
>   $ qemu -d help
>   Log items (comma separated):
>   guest_errors    log when the guest OS does something invalid (eg
> accessing a non-existent register)
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Michael Walle <michael@walle.cc>

Will this go through the qemu-trivial queue?

-michael
