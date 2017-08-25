Received: from eggs.gnu.org ([2001:4830:134:3::10]:46502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dlB0A-00019b-PH
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dlB05-0001Kn-R8
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:34:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dlB05-0001KR-Lk
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:34:01 -0400
Date: Fri, 25 Aug 2017 17:33:58 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170825093358.GJ11465@lemon.lan>
References: <mailman.3749.1503600836.21955.qemu-devel@nongnu.org>
	<74846968-830E-4239-9DC7-B1252A5AC946@gmail.com>
	<60e13112-931d-a517-ddb1-20c2f2de736e@redhat.com>
	<9CE89958-B59C-4D3C-91C5-ECB4B153C43D@gmail.com>
	<89d8b7b1-fb0f-a967-927e-8795c7d2b324@redhat.com>
	<1adde8d7-762f-8e89-7192-32d370b72af6@redhat.com>
	<CAFEAcA-OiC_BxpK3_aBrkqie9B2AuefQRupJrnnfSq_asfQLNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-OiC_BxpK3_aBrkqie9B2AuefQRupJrnnfSq_asfQLNw@mail.gmail.com>
Subject: Re: [Qemu-devel] Make test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Programmingkid <programmingkidx@gmail.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Fri, 08/25 10:10, Peter Maydell wrote:
> On 25 August 2017 at 06:49, Thomas Huth <thuth@redhat.com> wrote:
> > On 25.08.2017 00:16, Cleber Rosa wrote:
> >>
> >> On 08/24/2017 05:50 PM, Programmingkid wrote:
> >>>
> >>> Thank you for the patches. I will test them. I was wondering what is the point to having both 'make check' and 'make test'. It looks like everyone is using 'make check'. Maybe we are better off removing the 'make test' target.
> >>>
> >>
> >> I think the removing the `make test` target is a good thing, if its
> >> tests are either absorbed by an existing `make check*` one.  Now that
> >> depends on what people think the tcg tests (and others) deserve... TLC?
> >> Total annihilation?
> >
> > Since we do not have very good test coverage for TCG yet, I'd like to
> > see this rather fixed than removed! Could you please CC: me on future
> > versions of your patch series (I missed v1)?
> 
> The problem is that we don't have a good framework for building
> guest binaries to run under TCG. We should sort out one of those
> so that it's easy for a new test to say "this is the .c file,
> build it with an ARM gcc [eg using our docker stuff], then
> run it with this QEMU command". When we have that it should
> be straightforward to convert the 'make test' tests to use
> that, and they can be run under 'make check'.

This seems straigtforward to do with docker. Could you elaborate a concrete
example of one of the "this is the .c file, ..." test so I can try translate it
to a Makefile rule using our docker images?

fam
