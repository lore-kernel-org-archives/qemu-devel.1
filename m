Received: from eggs.gnu.org ([2001:4830:134:3::10]:56270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1eddtI-0004ol-Iw
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:20:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@mips.com>) id 1eddtD-00065y-L1
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:20:08 -0500
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:57263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@mips.com>)
	id 1eddtD-0005PH-CA
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 10:20:03 -0500
From: Aleksandar Markovic <Aleksandar.Markovic@mips.com>
Date: Mon, 22 Jan 2018 15:18:05 +0000
Message-ID: <BD3A5F1946F2E540A31AF2CE969BAEEE12393D67@MIPSMAIL01.mipstec.com>
References: <1516377391-25945-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1516377391-25945-4-git-send-email-aleksandar.markovic@rt-rk.com>,
	<87h8rhokv3.fsf@linaro.org>
In-Reply-To: <87h8rhokv3.fsf@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 3/7] Revert "target/mips: hold BQL for
 timer interrupts"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Aleksandar
	Markovic <aleksandar.markovic@rt-rk.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, Richard
	Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <Yongbok.Kim@mips.com>, Goran Ferenc <Goran.Ferenc@mips.com>, Miodrag Dinic <Miodrag.Dinic@mips.com>, Petar Jovanovic <Petar.Jovanovic@mips.com>

> From: Alex Benn=E9e [alex.bennee@linaro.org]=0A=
> =0A=
> > From: Aleksandar Markovic <aleksandar.markovic@mips.com>=0A=
> >=0A=
> > This reverts commit d394698d73836d1c50545bdb32dc58d09708fcfb.=0A=
> >=0A=
> > Ther revert is needed in order not to cause overlap with subsequent=0A=
> > patches related to handling synchronization of interrupt code paths.=0A=
> =0A=
> Hmm I'm fairly sure you should merge this with the follow-up patch to=0A=
> add BQL locking to the appropriate place. Otherwise you break=0A=
> bi-section.=0A=
=0A=
Thanks for the review, Alex!=0A=
=0A=
You are right, the bisect would have been broken. I am going to merge this =
and=0A=
subsequent patch in v2.=0A=
=0A=
I am going to address all your other concerns in v2 as well.=0A=
=0A=
Regards,=0A=
Aleksandar=
