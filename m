Received: from eggs.gnu.org ([2001:4830:134:3::10]:42661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1eZIpZ-0006bI-Qu
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1eZIpQ-00011A-7E
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:02:21 -0500
From: luigi burdo <intermediadc@hotmail.com>
Date: Wed, 10 Jan 2018 16:02:08 +0000
Message-ID: <AM5P194MB01328FAFC2F2E25ECCDB23E1C8110@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>
	<20180109121653.GN2131@umbus.fritz.box>
	<AM5P194MB0132AB1A7F3CE7E09346CDC4C8110@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>,
	<CAFEAcA8u0b_+W7GBwy6knV3_zvZLc00fbbSjDT42CkS83Gb29w@mail.gmail.com>
In-Reply-To: <CAFEAcA8u0b_+W7GBwy6knV3_zvZLc00fbbSjDT42CkS83Gb29w@mail.gmail.com>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>, "surajjs@au1.ibm.com" <surajjs@au1.ibm.com>

Hi Peter,

thanks for reply.

I will check the ram banks and will try again to build it .

but i have more fear about gcc now because the issue come exactly in the sa=
me point every time i try to rebuild everyting.


Thankyou

Luigi


________________________________________

This means that gcc crashed. This is either:
 (a) a hardware problem with your machine (eg bad memory)
or
 (b) a bug in gcc (which you can report to the gcc team
as they suggest in the error message)

You should check whether gcc reliably crashes in the
same way every time you try to build that source file.
If it does, that suggests a gcc bug is more likely. If
it sometimes works and sometimes doesn't, I would suspect
hardware problems.

thanks
-- PMM
