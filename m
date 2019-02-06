Received: from eggs.gnu.org ([209.51.188.92]:36006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1grPfF-00027I-TE
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 11:03:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1grPYO-0001BZ-FY
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:56:01 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1grPYO-00010J-2H
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:56:00 -0500
Date: Wed, 6 Feb 2019 10:55:47 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20190206155547.GA13624@flamenco>
References: <20190205151810.571-1-peter.maydell@linaro.org>
	<b8c414fe-e0cb-29ea-84cd-1f4386e6a10b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8c414fe-e0cb-29ea-84cd-1f4386e6a10b@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Consider cluster index in
 tb_lookup__cpu_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, patches@linaro.org, Howard Spoelstra <hsp.cat7@gmail.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Feb 06, 2019 at 03:15:26 +0000, Richard Henderson wrote:
> > Does anybody know why tb_lookup__cpu_state() has that odd
> > double-underscore in the middle of its name?
> 
> I'm inclined to think typo...  Emilio?

It's not a typo -- it's there to separate "tb lookup" and
"cpu state" to avoid ambiguity when guessing what
the function does based on its name.

Other projects, such as the kernel, make extensive use of
double underscores for this purpose. In fact, I believe
I picked up the habit from reading kernel code.

		E.
