Received: from eggs.gnu.org ([2001:4830:134:3::10]:35689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMB9N-0004at-K9
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMB9J-00077A-I9
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:12:33 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMB9J-00075N-Cz
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:12:29 -0500
Received: by mail-ot0-x243.google.com with SMTP id o23so17529923otd.1
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 03:12:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171205052501.13414-1-david@gibson.dropbear.id.au>
References: <20171205052501.13414-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Dec 2017 11:12:08 +0000
Message-ID: <CAFEAcA94gYou8UEgUMt4DwT7AxKbBj0mC9360UHqgZtGJ4Ss-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] ppc-for-2.11 queue 20171205
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 5 December 2017 at 05:25, David Gibson <david@gibson.dropbear.id.au> wrote:
> The following changes since commit 2a4c7e839101a52f7bf9ba4dd64e466518565352:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-12-04 17:19:04 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-2.11-20171205
>
> for you to fetch changes up to 044897ef4a22af89aecb8df509477beba0a2e0ce:
>
>   target/ppc: Fix system lockups caused by interrupt_request state corruption (2017-12-05 12:28:42 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2017-12-05
>
> Alas, this is yet another fix for ppc that I think it's worth
> squeezing into 2.11.  It's a really ugly fix for some pretty ugly
> code, but it does seem to address a real problem.  It's also a problem
> that's appeared relatively recently, since it was either created by,
> or made much easier to trigger by, by the merge of MTTCG.
>
> ----------------------------------------------------------------
> Richard Purdie (1):
>       target/ppc: Fix system lockups caused by interrupt_request state corruption
>
>  target/ppc/excp_helper.c |  7 +++----
>  target/ppc/helper_regs.h | 17 +++++++++++++++--
>  2 files changed, 18 insertions(+), 6 deletions(-)

Applied, thanks.

-- PMM
