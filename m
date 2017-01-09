Received: from eggs.gnu.org ([2001:4830:134:3::10]:43986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cQiIp-0007jB-Eb
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:20:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1cQiIk-0001lO-Gz
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 17:20:31 -0500
Date: Mon, 9 Jan 2017 23:20:22 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170109222022.GW9606@toto>
References: <1483988759-14606-1-git-send-email-peter.maydell@linaro.org>
	<148398903105.208.13573655327114962163@790289a7ca88>
	<CAFEAcA-S6txZ79_N1PTzAGb0dQSV9zpQ-kKyjnYDyyZzsv_4Ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-S6txZ79_N1PTzAGb0dQSV9zpQ-kKyjnYDyyZzsv_4Ug@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] disas/cris.c: Fix Coverity warning about
 unchecked NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Mon, Jan 09, 2017 at 09:35:16PM +0000, Peter Maydell wrote:
> On 9 January 2017 at 19:10,  <no-reply@patchew.org> wrote:
> > Checking PATCH 1/1: disas/cris.c: Fix Coverity warning about unchecked NULL...
> > ERROR: code indent should never use tabs
> > #24: FILE: disas/cris.c:2493:
> > +^Iif (sregp == NULL || sregp->name == NULL)$
> >
> > ERROR: suspect code indent for conditional statements (8, 10)
> > #24: FILE: disas/cris.c:2493:
> > +       if (sregp == NULL || sregp->name == NULL)
> >           /* Should have been caught as a non-match earlier.  */
> >
> > ERROR: braces {} are necessary for all arms of this statement
> > #24: FILE: disas/cris.c:2493:
> > +       if (sregp == NULL || sregp->name == NULL)
> > [...]
> >
> > total: 3 errors, 0 warnings, 8 lines checked
> 
> This is because the whole file is GNU coding standards
> style, being a binutils import. Better to stick with it rather
> than rework, I think.

Yes, I agree.

Cheers,
Edgar
