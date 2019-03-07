Received: from eggs.gnu.org ([209.51.188.92]:58485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1qzk-0007fT-Gx
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1h1qzj-0000Ug-VZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:15:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1h1qzj-0000UP-PA
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 06:15:23 -0500
Date: Thu, 7 Mar 2019 06:15:18 -0500
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190307111518.jfkgu63bjxrpakon@dhcp-17-118.bos.redhat.com>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
	<20190305172139.32662-2-peter.maydell@linaro.org>
	<20190307000452.imsrx5t4egcpoe4h@localhost.localdomain>
	<CAFEAcA90-pKTZrVun1ibQMKMNxcMHNz_b1o5grbN0fO0cTXcZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA90-pKTZrVun1ibQMKMNxcMHNz_b1o5grbN0fO0cTXcZw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 01/12] docs/cpu-hotplug.rst: Fix rST
 markup issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, Mar 07, 2019 at 09:47:18AM +0000, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 00:04, Cleber Rosa <crosa@redhat.com> wrote:
> > But I'm assuming the extended sphinx roles/directives will be used, so
> > the only way to check against future breakage would be to build the
> > docs.
> >
> > Do we have strong position in favor or against putting that into the
> > "common" `make check` flow?
> 
> Assuming the host has sphinx-build, the docs will be built as
> part of "make", so actual errors will be caught. We should

That's even better IMO.

> add the sphinx-build flag to make warnings into errors in
> the same way we use -Werror, but I wanted to get the series
> into master first.
>

Absolutely!

Regards,
- Cleber.

> thanks
> -- PMM
