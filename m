Received: from eggs.gnu.org ([2001:4830:134:3::10]:44645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0swi-0007HE-NS
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f0swe-0006BI-Qg
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:03:44 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f0swe-0006B4-Md
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 14:03:40 -0400
Date: Tue, 27 Mar 2018 14:03:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180327180339.GD2693@flamenco>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-5-git-send-email-cota@braap.org>
	<87vadh92ho.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87vadh92ho.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v1 04/14] fp-test: add muladd variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Tue, Mar 27, 2018 at 12:33:55 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> 
> > These are a few muladd-related operations that the original IBM syntax
> > does not specify; model files for these are in muladd.fptest.
> >
> > Signed-off-by: Emilio G. Cota <cota@braap.org>
(snip)
> > +        case OP_MULADD_NEG_ADDEND:
> > +            res64 = float64_muladd(a, b, c, float_muladd_negate_c, s);
> > +            break;
> > +        case OP_MULADD_NEG_PRODUCT:
> > +            res64 = float64_muladd(a, b, c, float_muladd_negate_product, s);
> > +            break;
> > +        case OP_MULADD_NEG_RESULT:
> > +            res64 = float64_muladd(a, b, c, float_muladd_negate_result, s);
> > +            break;
> >          case OP_DIV:
> >              res64 = float64_div(a, b, s);
> >              break;
> 
> Are there any intrinsics we could use for the hard variant which would
> be useful if we want to run under translation?

I don't know of any portable way of doing this. We could add some
arch-specific code though, suitably ifdef'ed.

		E.
