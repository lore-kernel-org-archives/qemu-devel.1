Received: from eggs.gnu.org ([2001:4830:134:3::10]:42341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dinBF-0000sW-EA
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dinBC-0002Jt-AO
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 15:43:41 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Fri, 18 Aug 2017 19:43:35 +0000
Message-ID: <AM5P194MB01328DE5DCCC5E8CDD9C3C44C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <cover.1502643878.git.balaton@eik.bme.hu>,
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<AM5P194MB0132F81D398EB4EB8EB13E22C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>,
	<alpine.BSF.2.21.1708181418010.19483@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.1708181418010.19483@zero.eik.bme.hu>
Content-Language: it-IT
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 09/12] ppc440: Add emulation
 of plb-pcix controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Francois Revol <revol@free.fr>, David Gibson <david@gibson.dropbear.id.au>


hi Balaton,
> I know about this and if you read the cover message (RFC PATCH 00/12) I l=
ink to a fixed version of that U-Boot firmware (rebuilt from source with th=
e mentioned patches) which works with this emulation. (The original one fro=
m the updater also starts but cannot boot due to some problems which are fi=
xed by these patches in my image. This is described in the cover message.) =
With that fixed firmware image it should be possible to at least try bootin=
g AmigaOS on the emulation and get some logs. I'd be surprised if it also w=
orked at this point but I could not try it as it needs an appropriate Amiga=
OS version that runs on the Sam460. It should produce some logs though with=
 -serial stdio which may help finding what is missing.

i have sam460 amigaos cdrom iso as my backup and can test it inside qemu. s=
haring the logs if you needed.

> I think it would not be possible to use the U-Boot in QEMU now as that is=
 for e500 CPU but this is not needed either. See above, we are aiming to em=
ulate enough of the board that it can run the original firmware which shoul=
d be able to boot these Amiga like OSes and normal Linux images used on the=
 Sam460ex. This already works but things fail after or during boot currentl=
y. This is what needs to be debugged. So we'd need someone who has a Sam460=
 (ex or cr) board and can test on that to get logs from OSes on real hardwa=
re for comparison.

 about real hardware no problem i will ask inside amigan community if someo=
ne have the opportunity to share the serial debug of sam 460 runinng amigao=
s.

can i ask you something ?
why you dont try to integrate in qemu the pegasos 2 or the efika machine. i=
 have the feeling that probably it can be more simple because more old mach=
ine and components.

bye=20
luigi=
