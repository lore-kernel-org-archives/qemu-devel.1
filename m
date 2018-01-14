Received: from eggs.gnu.org ([2001:4830:134:3::10]:40166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1earAU-0003sW-Pr
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:57:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ear9R-0001a7-J2
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:54:22 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:58059)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ear9R-0001ZX-Az
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 17:53:17 -0500
Date: Sun, 14 Jan 2018 23:53:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <35265a1e-3474-32e0-1915-2583cd2c306d@weilnetz.de>
Message-ID: <alpine.BSF.2.21.1801142347300.75725@zero.eik.bme.hu>
References: <151593225024.11261.9880390596143098449.malonedeb@soybean.canonical.com>
	<alpine.BSF.2.21.1801141421010.19489@zero.eik.bme.hu>
	<35265a1e-3474-32e0-1915-2583cd2c306d@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1743214] [NEW] OS/2 Warp 3 support broken in
 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <stefan.weil@weilnetz.de>
Cc: MVoloshin <1743214@bugs.launchpad.net>, qemu-devel@nongnu.org

On Sun, 14 Jan 2018, Stefan Weil wrote:
> Zoltan, did you run the test with KVM enabled?
>
> I=E2=80=8C get a crash when I run the image with latest QEMU on Linux w=
ith TCG.

No, I've used the same command as in the bug report. Now I've retried wit=
h=20
explicit -M pc,accel=3Dtcg and -M pc,accel=3Dkvm and it boots without pro=
blem=20
for me both ways on Linux. If it crashes for you maybe you could try=20
bisecting, that's what I was trying to do to help but I can't reproduce=20
it.

Regards,
BALATON Zoltan
