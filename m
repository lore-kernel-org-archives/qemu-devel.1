Received: from eggs.gnu.org ([209.51.188.92]:53223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gla5O-0001So-TF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gla5O-00017h-6q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:57:58 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gla5O-00017J-2K
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 08:57:58 -0500
Received: by mail-oi1-x243.google.com with SMTP id w13so14570432oiw.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 05:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20190118185402.3065-1-peter.maydell@linaro.org>
	<906bafd8-2a2a-9cae-142e-c7045edaa9d0@redhat.com>
	<CAP+75-X_2oyq9siWs0ubUnUp0DGzp-CvYhwJZenfdz6b_BatrA@mail.gmail.com>
In-Reply-To: <CAP+75-X_2oyq9siWs0ubUnUp0DGzp-CvYhwJZenfdz6b_BatrA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 13:57:45 +0000
Message-ID: <CAFEAcA_0M-1HRyeytDrUT7WQpMgXbAC1qbFYDpVWU0UXMuAH+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Disable ipmi-bt-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, "patches@linaro.org" <patches@linaro.org>, Thomas Huth <thuth@redhat.com>

On Mon, 21 Jan 2019 at 10:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On Mon, Jan 21, 2019 at 11:39 AM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
> >
> > Cc'ing Corey, the tests author.
> >
> > On 1/18/19 7:54 PM, Peter Maydell wrote:
> > > The ipmi-bt-test fails intermittently, especially on the NetBSD VM.
> > > The frequency of this failure has recently gone up sharply to the
> > > point that I'm having to retry the NetBSD build multiple times
> > > to get a pass when merging pull requests.
> > >
> > > Disable the test until we can figure out why it's failing.
> > >
> > > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Oops wrong paste, FWIW:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


Applied to master, thanks.

-- PMM
