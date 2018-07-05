Received: from eggs.gnu.org ([2001:4830:134:3::10]:52137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fb13I-0003z2-97
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Aleksandar.Markovic@rt-rk.com>) id 1fb13E-0003eP-CX
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:59:52 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:56137 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Aleksandar.Markovic@rt-rk.com>)
	id 1fb13E-0002WQ-0b
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:59:48 -0400
in-reply-to: <f5f4cd65-545e-42f7-3d8d-1d57ced676d7@amsat.org>
from: "Aleksandar Markovic" <Aleksandar.Markovic@rt-rk.com>
message-id: <4269-5b3dec00-3-5fa78980@135404596>
date: Thu, 05 Jul 2018 11:59:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel]
 =?utf-8?b?Pz09P3V0Zi04P3E/IFtQQVRDSCB2MyAyLzhdIHRh?=
 =?utf-8?q?rget/mips=3A_Workaround_for_checkpatch=2Epl_hanging_on_msa=5Fhe?=
 =?utf-8?q?lper=2Ec?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, qemu-devel@nongnu.org

> Hi Aleksandar,
> 
> On 07/04/2018 04:30 PM, Aleksandar Markovic wrote:
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > If checkpatch.pl is applied (using switch "-f") on file
> > target/mips/msa=5Fhelper.c, it will hang.
> >
> > This is a workaround by correcting the source file. The workaround =
is
> > found by partial deleting and undeleting of the code in msa=5Fhelpe=
r.c
> > in binary search fashion.
> >
> > The bug (for checkpatch.pl) is already reported to the qemu-devel l=
ist.
> 
> Paolo already sent a fix for this bug:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01250.html=

> 
> Can you test it?

Philippe, I tested Paolo's fix and I confirm that it fixed the original=
 issue - there is no hang.

Regards,
Aleksandar
=C2=A0
