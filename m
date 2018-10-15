Received: from eggs.gnu.org ([2001:4830:134:3::10]:46209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gBwZR-00031g-K9
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gBwZN-00054A-Ky
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:41:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gBwZN-00053g-Cp
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:41:37 -0400
References: <20181013151545.3731-1-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <763bb320-0b78-9478-feda-9ee1b14a4c70@redhat.com>
Date: Mon, 15 Oct 2018 08:41:29 +0200
MIME-Version: 1.0
In-Reply-To: <20181013151545.3731-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Avocado: more multi-arch tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>, Magnus Damm <magnus.damm@gmail.com>
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 2018-10-13 17:15, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> Another neanderthal approach to add multi-arch acceptance tests using A=
vocado.
>=20
> I couldn't figure how to use the R2D serial, the kernel boots using the=
 sm501
> display correctly, but I'm too console-oriented to write UI tests...
>=20
> Magnus or Zoltan, any hint on this?

IIRC you have to use the second UART, see:

https://wiki.qemu.org/Documentation/Platforms/SH4

 Thomas
