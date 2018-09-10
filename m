Received: from eggs.gnu.org ([2001:4830:134:3::10]:46011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzNK7-00069j-CD
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fzNK2-00027A-Lq
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:37:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fzNK2-00025U-7N
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:37:50 -0400
Date: Mon, 10 Sep 2018 10:37:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180910143747.GB19941@flamenco>
References: <20180908191735.22861-1-cota@braap.org>
	<20180908191735.22861-3-cota@braap.org> <87a7opd3br.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7opd3br.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] tests: add floating point tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>

On Mon, Sep 10, 2018 at 12:00:56 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 87c81d1dcc..363f133101 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -657,6 +657,9 @@ tests/qht-bench$(EXESUF): tests/qht-bench.o $(test-util-obj-y)
> >  tests/test-bufferiszero$(EXESUF): tests/test-bufferiszero.o $(test-util-obj-y)
> >  tests/atomic_add-bench$(EXESUF): tests/atomic_add-bench.o $(test-util-obj-y)
> >
> > +tests/fp/%:
> > +	$(MAKE) -C $(dir $@) $(notdir $@)
> > +
> 
> This isn't enough to cause the build to be included in make check or
> indeed be run. Perhaps that should be included in a new patch in the
> series?

Yes I figured we should fix the reported errors first -- otherwise
we'll knowingly break the integration tests.

		Emilio
