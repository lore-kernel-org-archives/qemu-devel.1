Received: from eggs.gnu.org ([2001:4830:134:3::10]:45303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmGE2-0005CQ-B5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dmGDz-0001yI-81
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:20:54 -0400
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<alpine.BSF.2.21.1708271402040.1289@zero.eik.bme.hu>
	<AM5P194MB01323322D359DF607B54C19EC8990@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ffb13f14-0a72-f3cc-baa7-c17355d00730@redhat.com>
Date: Mon, 28 Aug 2017 11:20:45 +0200
MIME-Version: 1.0
In-Reply-To: <AM5P194MB01323322D359DF607B54C19EC8990@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] Qemu 2.10 rc4 build issue on BE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>

On 27.08.2017 18:56, luigi burdo wrote:
> Hi all,
>=20
> the last rc4 from the qemu website fail in build in some parts on BE
> hardware.
>=20
> attached on this email there is the configure and the build log hope it
> helps
>=20
>=20
> My machine is : PowerMac G5 Quad .
>=20
> Distro is Ferdora 25 PPC64.

In your log there is:

/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c: In function
=E2=80=98pc_dimm_unplug_request=E2=80=99:
/home/amigaone/Downloads/qemu-2.10.0-rc4/hw/i386/pc.c:1744:9: error:
unknown type name =E2=80=98gCto=E2=80=99
         gCto out;

But if you have a look at the freshly unpacked sources, that line
clearly reads "goto out;" and not "gCto out;" ... so it looks like
something messed up your sources very badly.
Can you reproduce this problem when starting again from scratch?

 Thomas
