Received: from eggs.gnu.org ([209.51.188.92]:36613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1Doi-00058p-9K
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1Doh-0004x4-Et
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:25:24 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1Doh-0004ub-8U
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:25:23 -0500
Received: by mail-ot1-x344.google.com with SMTP id q24so8143715otk.0
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
	<CAFEAcA_OLYno=YNS6bHOemwEp0gnc3fwRn8Rjvmo9v-i89xrMA@mail.gmail.com>
	<87d0nnsrx0.fsf@dusky.pond.sub.org>
	<c6d4c021-8d62-ada0-d152-b1d4f2b7aff2@redhat.com>
	<87ftsjptxk.fsf@dusky.pond.sub.org>
	<CANqRtoSOF8uvh-9-_CgsuhB_N18NhSiS=DPsY1+3+ff4NzgE+w@mail.gmail.com>
	<87mumbcd8k.fsf@dusky.pond.sub.org>
	<f2c8f20d-17ad-b72b-28fb-c835d6b97c10@redhat.com>
	<87k1he1wnz.fsf@dusky.pond.sub.org>
	<e8b000bc-d457-7c5a-b7d2-4e3ff63d0c73@redhat.com>
In-Reply-To: <e8b000bc-d457-7c5a-b7d2-4e3ff63d0c73@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 17:25:08 +0000
Message-ID: <CAFEAcA-9U_D=UWTUH69mBBuC+a=FgXBC5kSawoCxDM4nB_FPZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

On Tue, 5 Mar 2019 at 17:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> But I'd recommend changing/fixing the sector size during the next dev
> cycle, so we have more time for testing.

Nobody in the upstream dev community is using or testing this board.
The only way we'll find out if there's a problem with changing the
sector size is to put the change in and get it into a release.
I would vote for just making the change now.

thanks
-- PMM
