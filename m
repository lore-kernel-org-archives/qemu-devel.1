Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g852O-0003tZ-In
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g852J-0006Uc-P6
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:55:36 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g852J-0006Pq-CC
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:55:31 -0400
Date: Thu, 4 Oct 2018 10:55:25 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181004145525.GA9715@flamenco>
References: <20181003180711.19335-1-richard.henderson@linaro.org>
	<871s96rs4s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s96rs4s.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On Thu, Oct 04, 2018 at 10:13:55 +0100, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
> > Changes from v1:
> >   * Preserve udiv_qrnnd as a separate division primitive that
> >     could be used as a building block for float128 division.
> >   * Include asm fragments for x86_64, s390x, and ppc64.
> 
> It passes my fops fdiv_double test but Emilio's test is reporting:
> 
>   Errors found in f64_div, rounding near_even:
>   +252.7FFFFFFFFFF80  +001.FFFFFFFFFFFFE
>           => +64F.7FFFFFFFFFF82 ....x  expected +64F.7FFFFFFFFFF81 ....x

Did you rebuild the test program? v2 passes all f64_div tests for me.

Tested-by: Emilio G. Cota <cota@braap.org>
for patches 1 and 2.

Thanks,

		E.
