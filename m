Received: from eggs.gnu.org ([2001:4830:134:3::10]:39484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ej083-0003zD-9D
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ej07t-0004po-Js
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:05:31 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40976)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1ej07t-0004oz-0e
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:05:21 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180206095526.26436.86301.stgit@pasha-VirtualBox>
	<CAFEAcA9+H_WYPUgORtcVLKMHj1D=Fqah_ibVFp-G2LOQ1n5jdA@mail.gmail.com>
In-Reply-To: <CAFEAcA9+H_WYPUgORtcVLKMHj1D=Fqah_ibVFp-G2LOQ1n5jdA@mail.gmail.com>
Date: Tue, 6 Feb 2018 13:05:20 +0300
Message-ID: <000b01d39f31$ff465690$fdd303b0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [ PATCH ] replay additions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Peter Maydell' <peter.maydell@linaro.org>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: 'QEMU Developers' <qemu-devel@nongnu.org>, 'Laurent Vivier' <laurent@vivier.eu>

> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> On 6 February 2018 at 09:55, Pavel Dovgalyuk =
<Pavel.Dovgaluk@ispras.ru> wrote:
> > This set of patches includex fixes from Alex Benn=C3=A9e for fixing
> > BQL and replay locks after inventing the MTTCG. It also includes =
some
> > additional replay patches that makes this set of fixes working.
> > It is also fixes some vmstate creation (and loading) issues
> > in record/replay modes:
> >  - VM start/stop fixes in replay mode
> >  - overlay creation for blkreplay filter
> >  - fixes for vmstate save/load in record/replay mode
> >  - fixes for host clock vmstate
>=20
> This cover letter text doesn't seem to match the patch
> description?

Yes, I accidentally sent the cover letter with the single patch.
Please ignore it.

Pavel Dovgalyuk
