Received: from eggs.gnu.org ([209.51.188.92]:44106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gwBOs-0003su-BX
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:49:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gwBOk-0004H8-Sa
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:49:50 -0500
Received: from mail-eopbgr740099.outbound.protection.outlook.com
	([40.107.74.99]:58557
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1gwBOa-0004D3-QB
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 14:49:37 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 19 Feb 2019 19:49:30 +0000
Message-ID: <BN6PR2201MB1251A3DCB67C497BE890E60AC67C0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1550603704-22474-1-git-send-email-aleksandar.markovic@rt-rk.com>,
	<a9c77bb1-b392-06f7-c42d-471d12c75e0d@redhat.com>
In-Reply-To: <a9c77bb1-b392-06f7-c42d-471d12c75e0d@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2] target/mips: implement QMP
 query-cpu-definitions command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "aurelien@aurel32.net" <aurelien@aurel32.net>, "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>, "natalia.fursova@ispras.ru" <natalia.fursova@ispras.ru>, Aleksandar Rikalo <arikalo@wavecomp.com>

> From: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Subject: Re: [PATCH v2] target/mips: implement QMP query-cpu-definitions =
command
>=20
> On 2/19/19 8:15 PM, Aleksandar Markovic wrote:
> > From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> >
> > This patch enables QMP-based querying of the available CPU types for
> > MIPS and MIPS64 platforms.
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> Aleksandar, FYI I tested v1 and your v2 that way:
>=20
> $ mips64el-softmmu/qemu-system-mips64el -S \
>     -qmp tcp:localhost:4444,server,nowait
>=20
> $ telnet localhost 4444
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 3},
> "package": "v3.1.0-1924-gc7b700fafb"}, "capabilities": ["oob"]}}

...

That's fabulous! Thanks, Philippe!

Aleksandar
