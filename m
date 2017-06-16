Received: from eggs.gnu.org ([2001:4830:134:3::10]:60783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLxRU-0004YS-Ep
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:02:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dLxRR-0002i3-D3
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:02:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dLxRR-0002ho-2H
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:02:01 -0400
Date: Fri, 16 Jun 2017 16:01:59 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170616200159.GA27617@flamenco>
References: <20170614140209.29847-1-alex.bennee@linaro.org>
	<20170614140209.29847-4-alex.bennee@linaro.org>
	<09a35585-d876-6c9e-7045-8cda418455e0@twiddle.net>
	<a1a0b43c-b074-a1a4-dc26-717964121b1a@redhat.com>
	<f32b9b12-73b4-e803-6425-271b48858a8b@twiddle.net>
	<be99bef9-eeb2-6816-e0ca-979780a48a06@redhat.com>
	<9daac065-1738-f872-0267-94cffa96ab6d@twiddle.net>
	<87zidamlrf.fsf@linaro.org>
	<4da39e8f-a0ad-8e16-2275-597746c1c2a2@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4da39e8f-a0ad-8e16-2275-597746c1c2a2@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v1 3/3] tcg-runtime: short-circuit
 lookup_tb_ptr on IRQs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Wed, Jun 14, 2017 at 12:43:00 -0700, Richard Henderson wrote:
> On 06/14/2017 12:07 PM, Alex Bennée wrote:
> >If your rolling a series for all these can you also pick up Thomas
> >Huth's fix for --accel?
> 
> Will do.

Just a heads up since I see the patch is in your tcg-next branch:

Paolo included this patch in a recent pull request ("Misc patches
for 2017-06-15"), although the pull has yet to happen.
  https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03682.html

		E.
