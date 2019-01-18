Received: from eggs.gnu.org ([209.51.188.92]:39706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkYhS-0001AG-DO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:17:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gkYhQ-00070Z-EI
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:17:02 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52007)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gkYhO-0006wT-GL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 13:17:00 -0500
Date: Fri, 18 Jan 2019 13:16:51 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190118181651.GA4194@flamenco>
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
	<871s5byriy.fsf@linaro.org>
	<e655e325-15ad-9e97-eb27-8a15ea77a889@redhat.com>
	<87won1yk7y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87won1yk7y.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PULL 0/7] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 18, 2019 at 17:00:17 +0000, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> > Can you modify the Makefile.include to use:
> >  "fp-test ... 2>int-to-float.err || {cat int-to-float.err && exit 1;}"
> 
> Well it's in the test-softfloat macro but sure...

Actually, can we do &> instead of 2> ?

The errors coming from berkeley-testfloat are printed to stdout,
so we should get those too. (We could fix testfloat to print
to stderr, but I'd rather only make strictly necessary changes
to berkeley-testfloat.)

Thanks,

		E.
