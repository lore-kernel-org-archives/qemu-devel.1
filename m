Received: from eggs.gnu.org ([2001:4830:134:3::10]:33495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cnnyd-000568-Qs
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1cnnyY-0002Ld-UO
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:03:07 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Tue, 14 Mar 2017 15:02:58 +0000
Message-ID: <AM5P194MB012918B22ED117AE73302511C8240@AM5P194MB0129.EURP194.PROD.OUTLOOK.COM>
References: <36e41adf-b0b3-3efa-51c4-f1a70cd05b98@ilande.co.uk>
	<87wpbsp49a.fsf@linaro.org>
	<6491a446-bf23-5ab9-3431-c67efaf83f71@ilande.co.uk>,
	<alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.20.1703141450560.82811@zero.eik.bme.hu>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] qemu-system-ppc video artifacts since
 "tcg: drop global lock during TCG code execution"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, "cota@braap.org" <cota@braap.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "bobby.prani@gmail.com" <bobby.prani@gmail.com>, "rth@twiddle.net" <rth@twiddle.net>, =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, "fred.konrad@greensocs.com" <fred.konrad@greensocs.com>


framebuffer memory which is used to decide when a scan line needs update?

Hi Balton i have this artifacts since 2.20 on Linux PPC.
are more evident if the sdl driver is used, much less on GTK but still pres=
ent there too plus GTK have issue with pointer if gl is enabled (reported i=
n past in bugzilla)
I found it in STD when kvm is enabled on ppc32, virtio-vga gave this issue =
much less . (qemu-system-PPC64 have virtio enabled),
The strange thing is the std dont gave this issue on x86 emulation via tcg.=
..

I hope one day we will have virtio on ppc32 too.

Luigi
