Received: from eggs.gnu.org ([2001:4830:134:3::10]:51245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1e9UhF-0004K0-Tu
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1e9UhE-0000v5-TO
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:27:05 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45454)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1e9UhE-0000ug-Li
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 07:27:04 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CAPnv1PJeMRPKv9UUSmSWxyn=GFOPaWY8eUgH8ZeL=ZBMDJpbdg@mail.gmail.com>
	<CAJhHMCCZh7hvQT8x9Bks9k6=ka4G1Oybv1MrkKJ9_VZ_eRZBfQ@mail.gmail.com>
	<CAPnv1PL7-BAt36BvTxP7G8J8990Ur9MJJbr-QPccWziD4sy28g@mail.gmail.com>
	<87bmrj8eks.fsf@linaro.org>
	<CAPnv1PKyak1G-uL=H=-Vh_9TH2dZKffYjDf_2Z+LWuqovMKCBQ@mail.gmail.com>
	<CAKSfGUC_k6K=2Xy8pGcwuQ66DMPYCDvA47Ojgm7ntQfALGwDsQ@mail.gmail.com>
	<CAKSfGUD-FEb+DGwtrVHm2_NR_WOes9_+WkPm3Z76OPNhc3vbGA@mail.gmail.com>
	<000601d33128$2dd9d5e0$898d81a0$@ru> <87bmm7dohw.fsf@linaro.org>
	<CAKSfGUCt7p95nDeW12Q_-BSTXVhRLPtL+=u_WLx5_BZEgAgeLw@mail.gmail.com>
	<878thaepe2.fsf@linaro.org>
In-Reply-To: <878thaepe2.fsf@linaro.org>
Date: Tue, 31 Oct 2017 14:27:04 +0300
Message-ID: <000d01d3523b$2e00f880$8a02e980$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] What is the best commit for record-replay?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Aleksandr Bezzubikov' <zuban32s@gmail.com>
Cc: 'QEMU Developers' <qemu-devel@nongnu.org>, 'Pranith Kumar' <bobby.prani+qemu@gmail.com>, pavel.dovgaluk@ispras.ru, 'Aleksandr Bezzubikov' <abezzubikov@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>, 'Igor R' <boost.lists@gmail.com>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Aleksandr Bezzubikov <zuban32s@gmail.com> writes:
>=20
> > 2017-09-19 12:30 GMT+03:00 Alex Benn=C3=A9e =
<alex.bennee@linaro.org>:
> >>
> >>> As I know, RR is still broken in the current version.
> >>> It was caused by the MTTCG implementation.
> >>> Alex Bennee tried to fix RR back. Alex, have you found any =
solution?
> >>>
> >>> We also trying to find a way to fix RR. It seems, that we will =
reinvent BQL for RR.
> >>
> >> I think the method outlined in my RFC is the way to go, essentially =
the
> >> RR mutex taking over for the what the BQL did. The RFC patch hadn't
> >> hoisted the mutex for the additional devices so I'm just re-basing =
now
> >> and I'll see if I can make the changes for Igor's test case.
> >>
> >> --
> >> Alex Benn=C3=A9e
>=20
> Could you try:
>=20
>   https://github.com/stsquad/qemu/tree/bql-and-replay-locks-v2
>=20
> And report back?

Please check the new series of the patches.
It includes patches from Alex and some fixes that made them working.

Pavel Dovgalyuk
