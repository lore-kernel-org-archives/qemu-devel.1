Received: from eggs.gnu.org ([2001:4830:134:3::10]:40762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ftIdk-0006ul-3f
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 16:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1ftIdd-0007Vs-5S
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 16:25:02 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1ftIda-0007Rr-SB
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 16:24:56 -0400
Date: Fri, 24 Aug 2018 16:24:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180824202448.GA28859@flamenco>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
	<1534870966-9287-46-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-tLjX-NXmScQruSXfu_AgAujhgQBYiaYhsFdXnf2Uc6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-tLjX-NXmScQruSXfu_AgAujhgQBYiaYhsFdXnf2Uc6Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 45/74] spapr: do not use CPU_FOREACH_REVERSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Aug 24, 2018 at 16:20:24 +0100, Peter Maydell wrote:
(snip)
> Hi -- Coverity points out in CID1395181 that this introduces
> a memory leak -- we allocate memory into the rev pointer
> with g_renew(), but we never free it before leaving the function.

Thanks for the heads up; fix forthcoming.

		Emilio
