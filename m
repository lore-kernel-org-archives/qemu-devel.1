Received: from eggs.gnu.org ([2001:4830:134:3::10]:44403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gUZjP-0001qB-5P
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gUZjL-0000f6-1P
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:08:58 -0500
Date: Wed, 5 Dec 2018 11:08:52 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181205160852.GA8760@flamenco>
References: <mailman.26358.1543950647.1282.qemu-devel@nongnu.org>
	<BB2DCBB2-1B72-4986-BB21-3A685D68EF88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BB2DCBB2-1B72-4986-BB21-3A685D68EF88@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 07/13] fpu: introduce hardfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Alex Benn?e <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On Wed, Dec 05, 2018 at 06:07:44 -0500, Programmingkid wrote:
> 
> > On Dec 4, 2018, at 2:10 PM, qemu-devel-request@nongnu.org wrote:
> > 
> > Emilio G. Cota <cota@braap.org> writes:
> > 
> >> On Tue, Dec 04, 2018 at 13:52:16 +0000, Alex Benn?e wrote:
> >>>> We could always
> >>>> 
> >>>> #ifdef __FAST_MATH__
> >>>> #error "Silliness like this will get you nowhere"
> >>>> #endif
> >>> 
> >>> Emilio, are you happy to add that guard with a suitable pithy comment?
> >> 
> >> Isn't it better to just disable hardfloat then?
> >> 
> >> --- a/fpu/softfloat.c
> >> +++ b/fpu/softfloat.c
> >> @@ -220,7 +220,7 @@ GEN_INPUT_FLUSH3(float64_input_flush3, float64)
> >>  * the use of hardfloat, since hardfloat relies on the inexact flag being
> >>  * already set.
> >>  */
> >> -#if defined(TARGET_PPC)
> >> +#if defined(TARGET_PPC) || defined(__FAST_MATH__)
> >> # define QEMU_NO_HARDFLOAT 1
> >> # define QEMU_SOFTFLOAT_ATTR QEMU_FLATTEN
> >> #else
> 
> Why can't PowerPC also benefit from a hardfloat? It uses IEEE754 also.  

Please see this message:
  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04974.html

Thanks,

		E.
