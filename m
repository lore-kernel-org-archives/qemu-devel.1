Received: from eggs.gnu.org ([209.51.188.92]:35169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjppm-0006yp-04
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gjppj-0005C5-68
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:22:36 -0500
Date: Wed, 16 Jan 2019 13:21:50 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190116182150.GA32175@flamenco>
References: <e94b51d7-c90f-b599-fb68-ea8c2603989b@redhat.com>
	<87zhs3nk1m.fsf@linaro.org>
	<a0646a85-603d-99a8-c676-76e43a42e0fb@twiddle.net>
	<87y37monyr.fsf@linaro.org>
	<CAFEAcA8u4AdhW-MF6uMP7=B4iYVO9ZEQCtcQKpN6KWALwAfLnw@mail.gmail.com>
	<87won6nfl1.fsf@linaro.org>
	<6cb80b50-0352-430e-0c46-85ed69f95c88@redhat.com>
	<87va2poqoz.fsf@linaro.org> <20190115200527.GB7844@flamenco>
	<479044cb-345a-0faa-795a-f67da0077198@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <479044cb-345a-0faa-795a-f67da0077198@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] include/fpu/softfloat: Fix compilation
 with Clang on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Wed, Jan 16, 2019 at 07:33:28 +0100, Thomas Huth wrote:
> On 2019-01-15 21:05, Emilio G. Cota wrote:
> > On Tue, Jan 15, 2019 at 16:01:32 +0000, Alex Bennée wrote:
> >> Ahh I should have mentioned we already have the technology for this ;-)
> >>
> >> If you build the fpu/next tree on a s390x you can then run:
> >>
> >>   ./tests/fp/fp-bench f64_div
> >>
> >> with and without the CONFIG_128 path. To get an idea of the real world
> >> impact you can compile a foreign binary and run it on a s390x system
> >> with:
> >>
> >>   $QEMU ./tests/fp/fp-bench f64_div -t host
> >>
> >> And that will give you the peak performance assuming your program is
> >> doing nothing but f64_div operations. If the two QEMU's are basically in
> >> the same ballpark then it doesn't make enough difference. That said:
> > 
> > I think you mean here `tests/fp/fp-bench -o div -p double', otherwise
> > you'll get the default op (-o add).
> 
> I tried that now, too, and -o div -p double does not really seem to
> exercise this function at all.

You can check what is being called then with perf record/report.

		E.
