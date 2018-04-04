Received: from eggs.gnu.org ([2001:4830:134:3::10]:32806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3q8p-0007na-BG
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 17:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f3q8m-0006QX-3o
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 17:40:27 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f3q8l-0006QB-OE
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 17:40:23 -0400
Date: Wed, 4 Apr 2018 17:39:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180404213938.GA28643@flamenco>
References: <20180207225540.31698-1-richard.henderson@linaro.org>
	<20180207225540.31698-17-richard.henderson@linaro.org>
	<20180404164908.GA7582@flamenco> <878ta2de2z.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878ta2de2z.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PULL 16/20] target/arm: Use vector infrastructure
 for aa64 compares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Apr 04, 2018 at 19:24:52 +0100, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
> 
> > On Wed, Feb 07, 2018 at 14:55:36 -0800, Richard Henderson wrote:
> >> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> >> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >
> > Just bisected a segfault for aarch64 nbench on a PowerPC host
> > to this commit (79d61de6bdc398). I've also tested on x86_64 and
> > aarch64 hosts, and these do not seem to be affected.
> 
> I wonder about other hosts without TCG_vec backend support (powerpc is
> one)? I suspect it must be the fall-back for the vector expanders is
> wrong.

I just tried on two additional machines:

- Reproduced on a different PowerPC host with different endianness
  (gcc110, which is power7 and therefore big endian)

- Could not reproduce on a mips64 host (gcc23)

So it might be a Power-only thing.

Thanks,

		Emilio
