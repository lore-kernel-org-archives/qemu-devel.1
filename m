Received: from eggs.gnu.org ([2001:4830:134:3::10]:38918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eC2nc-0005W1-34
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eC2nW-0001Eq-F0
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:16:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eC2nW-0001Eb-9f
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 07:16:06 -0500
References: <150391152035.18876.7874968547091336063.malonedeb@chaenomeles.canonical.com>
	<151005233294.4565.312386986743168705.malone@gac.canonical.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <226cd310-1d63-86af-77db-c932e24673c0@redhat.com>
Date: Tue, 7 Nov 2017 13:16:02 +0100
MIME-Version: 1.0
In-Reply-To: <151005233294.4565.312386986743168705.malone@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1713434] Re: prom-env-test test aborted and
 core dumped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1713434 <1713434@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "R.Nageswara Sastry" <nasastry@in.ibm.com>

On 07.11.2017 11:58, R.Nageswara Sastry wrote:
> Git head is at 299d1ea9bb56bd9f45f905125489bdd7d543a1aa
> latest today
>=20
> 100% re-producible. This is different & working Power9 machine than the
> other day.
>=20
> # ./sparc64-softmmu/qemu-system-sparc64 -nographic -M sun4u -prom-env '=
use-nvramrc?=3Dtrue' -prom-env 'nvramrc=3D." Hello World!" cr'
> OpenBIOS for Sparc64
> Unhandled Exception 0x0000000000000034
> PC =3D 0x00000000ffd0f704 NPC =3D 0x00000000ffd0f708
> Stopping execution
>=20
> and hung here. Not responding to ctrl+c or ctrl+z.

It works for me on POWER8. Could you please check with the QEMU 2.10
release to see whether this is a regression or whether it was already
failing there? (Sorry, I don't have access to POWER9 anymore, so I can't
check this right now). Could you please also locate your
openbios-sparc64 file and paste it's md5sum here, so we can be sure that
it is the right version? Thanks!

PS: It's normal that you can not quit that QEMU with Ctrl-c since it has
been started without "-nodefaults" here - and that means the HMP monitor
is running multiplexed with the serial output here. To quit QEMU, you've
got to press "CTRL-a c" and then type "quit" at the monitor prompt.

 Thomas
