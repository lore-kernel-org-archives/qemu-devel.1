Received: from eggs.gnu.org ([209.51.188.92]:50509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hMNYo-000758-So
	for qemu-devel@nongnu.org; Thu, 02 May 2019 22:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hMNYn-0002zM-M4
	for qemu-devel@nongnu.org; Thu, 02 May 2019 22:04:26 -0400
MIME-Version: 1.0
References: <20190103144124.18917-1-stefanha@redhat.com>
	<CAFEAcA-B_T9E3ezWFXg-wp3RotMjv3-z3qY7hSJZEoqFBqCWnQ@mail.gmail.com>
	<62b29bc1-cc78-cd64-4377-fc4007ba7189@redhat.com>
	<20190426091702.GA2071@stefanha-x1.localdomain>
	<CACPK8Xc5KgiaYCTs=8ceRu_hV=vC3M6pGV0=7jJNsbuz2a6LDA@mail.gmail.com>
	<20190501162316.GD21155@stefanha-x1.localdomain>
In-Reply-To: <20190501162316.GD21155@stefanha-x1.localdomain>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 3 May 2019 02:04:11 +0000
Message-ID: <CACPK8Xc-7MOCMDKi=by0DVZrUW2vPL0QVT_G2NTuhi_fvwU1Aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Revert "armv7m: Guard against no -kernel
 argument"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jim Mussared <jim@groklearning.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Julia Suvorova <jusual@mail.ru>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Wed, 1 May 2019 at 16:23, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Mon, Apr 29, 2019 at 12:53:48PM +0000, Joel Stanley wrote:
> > On Fri, 26 Apr 2019 at 09:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >
> > > A user-friendly error message is needed here.  The check for -kernel was
> > > too specific and is not desirable for microbit where we use -device
> > > loader.
> > >
> > > Old boards probably want to continue using -kernel.  New boards like
> > > microbit may use just -device loader.  Perhaps there is even a group
> > > that wants both options.
> >
> > FWIW, I used -kernel exclusively when working on the microbit model.
> > Other users may chose to use the device loader/hex file.
> >
> > I am all for usability, but getting rid of the ability to use -kernel
> > on some machine types would be a step in the wrong direction.
>
> -kernel doesn't support the .hex file format that is most commonly used
> for micro:bit programs.  Are you loading ELFs?

Yes, I am loading ELFs.
