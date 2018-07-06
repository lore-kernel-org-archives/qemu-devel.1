Received: from eggs.gnu.org ([2001:4830:134:3::10]:45110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbRWM-0001v3-PC
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:15:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbRWL-0002Td-9J
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:15:38 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39376)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbRWK-0002TD-PR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:15:37 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so23720877oib.6
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 07:15:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180705222622.17139-1-jusual@mail.ru>
References: <20180705222622.17139-1-jusual@mail.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 15:15:15 +0100
Message-ID: <CAFEAcA91Cng7EGEvi38SWjQN5juCRKO9pU2C_HjLANazbcRvTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Forbid unprivileged mode
 for M Baseline
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>

On 5 July 2018 at 23:26, Julia Suvorova <jusual@mail.ru> wrote:
> MSR handling is the only place where CONTROL.nPRIV is modified.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
> v2:
>     * Add the check in the CONTROL_NS case
>
>  target/arm/helper.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

As we're now in freeze for the QEMU 3.0 release, I've added this
patch to a branch I'm keeping with arm-related patches intended
to go into 3.1. You can find it at
https://git.linaro.org/people/peter.maydell/qemu-arm.git target-arm.for-3.1
but note that it will be rebased in future so be careful
if you base anything on it. (You might find it easier to just
ignore it ;-))

thanks
-- PMM
