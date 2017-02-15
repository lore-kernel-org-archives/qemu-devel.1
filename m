Received: from eggs.gnu.org ([2001:4830:134:3::10]:58145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwgh-0003jg-RL
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cdwgd-0007KH-UP
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 05:19:51 -0500
References: <20170214225535.6880-1-f4bug@amsat.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <14f5cd23-bf50-e52b-ce90-6f199a3ee6d1@msgid.tls.msk.ru>
Date: Wed, 15 Feb 2017 13:19:46 +0300
MIME-Version: 1.0
In-Reply-To: <20170214225535.6880-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] register: fix incorrect read mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org

15.02.2017 01:55, Philippe Mathieu-Daud=C3=A9 wrote:
> The register_read() and register_write() functions expect a bitmask arg=
ument.
> To avoid duplicated code, a new inlined function register_enabled_mask(=
) is
> introduced.

Applied to -trivial, thanks!

/mjt
