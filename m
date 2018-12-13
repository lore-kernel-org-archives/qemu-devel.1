Received: from eggs.gnu.org ([2001:4830:134:3::10]:54038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXPVl-0004Aa-BX
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:50:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gXPVk-0007g0-HZ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:50:37 -0500
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gXPVk-0007fg-Bs
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:50:36 -0500
Received: by mail-io1-xd41.google.com with SMTP id n3so1314333iog.12
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 03:50:36 -0800 (PST)
MIME-Version: 1.0
References: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA8tG-mXv63dDuJ-DFNDmxvv=AzK2rJXVFG5mnpPadGjGQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8tG-mXv63dDuJ-DFNDmxvv=AzK2rJXVFG5mnpPadGjGQ@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 13 Dec 2018 19:49:59 +0800
Message-ID: <CAKXe6SLRXKAeZpK_R0KHLqRu8NvideCYV8eDCrvRptVf8mGDTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: marcandre lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>

Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=881=
3=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=887:45=E5=86=99=E9=81=93=EF=BC=
=9A

> On Thu, 13 Dec 2018 at 11:37, Li Qiang <liq3ea@gmail.com> wrote:
> >
> > Also add diagnostics info in 'qemu_set_cloexec' so that we can know
> > what happen when error occurs.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> > Change since v1: add diagnostics info
>
> We need to fix the assert in the test suite first...
>

Agree, as I  mentioned in the last email, this assert seems occurs in
aarch64.
But I have no this environment. So this patch add diagnostics info to let
the bot tell us
what happen.

Thanks,
Li Qiang



> thanks
> -- PMM
>
