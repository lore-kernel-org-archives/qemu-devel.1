Received: from eggs.gnu.org ([2001:4830:134:3::10]:35036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxh4-0002lc-OV
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1fcxgz-0002Jb-Lu
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:48:58 -0400
Received: from mail-bn3nam01on0102.outbound.protection.outlook.com
	([104.47.33.102]:45381
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1fcxgz-0002JA-Dj
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:48:53 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 10 Jul 2018 18:48:49 +0000
Message-ID: <BN7PR08MB48688AF8EF3E3BCAC2D8F7FAC65B0@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1531169431-10772-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<1531169431-10772-33-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1531169431-10772-33-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 32/33] gdbstub: Add XML support for GDB
 for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "f4bug@amsat.org" <f4bug@amsat.org>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

> Subject: [PATCH v2 32/33] gdbstub: Add XML support for GDB for nanoMIPS
>
> From: Stefan Markovic <smarkovic@wavecomp.com>
>
> Add XML support files for GDB for nanoMIPS.
>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  MAINTAINERS                |  3 ++-
>  gdb-xml/nanomips-cp0.xml   | 13 +++++++++++++
>  gdb-xml/nanomips-cpu.xml   | 44 ++++++++++++++++++++++++++++++++++++++++=
++++
>  gdb-xml/nanomips-dsp.xml   | 20 ++++++++++++++++++++
>  gdb-xml/nanomips-fpu.xml   | 45 ++++++++++++++++++++++++++++++++++++++++=
+++++
>  gdb-xml/nanomips-linux.xml | 20 ++++++++++++++++++++
>  6 files changed, 144 insertions(+), 1 deletion(-)
>  create mode 100644 gdb-xml/nanomips-cp0.xml
>  create mode 100644 gdb-xml/nanomips-cpu.xml
>  create mode 100644 gdb-xml/nanomips-dsp.xml
>  create mode 100644 gdb-xml/nanomips-fpu.xml
>  create mode 100644 gdb-xml/nanomips-linux.xml
>

Stefan,

Can you clarify here:

- Was the intention to implement XML support for nanoMIPS only?

- In any case, is there a way to support pre-nanoMIPS MIPS configurations t=
hat would require only a reasonable implementation time?


Thanks,
Aleksandar
