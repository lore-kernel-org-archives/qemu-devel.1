Received: from eggs.gnu.org ([209.51.188.92]:49445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw6St-0008Bq-PN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw6St-0003a6-2g
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:33:43 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:36989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw6Ss-0003XA-MY
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 09:33:43 -0500
Received: by mail-ot1-x335.google.com with SMTP id b3so34450340otp.4
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 06:33:39 -0800 (PST)
MIME-Version: 1.0
References: <20190128181047.20781-1-peter.maydell@linaro.org>
	<20190128181047.20781-10-peter.maydell@linaro.org>
	<CAFEAcA8tinUgkBxmUe0-WNcaYStu0=6HsXwejQdOZ=L8ZSygXA@mail.gmail.com>
	<20190219142345.GA22806@quinoa.localdomain>
In-Reply-To: <20190219142345.GA22806@quinoa.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 14:33:27 +0000
Message-ID: <CAFEAcA8UeSUn4+NtbCVy_6UAbspJnzr6_tAe+V=hnywDRgfd4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 09/26] target/arm: Don't clear supported PMU
 events when initializing PMCEID1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, 19 Feb 2019 at 14:23, Aaron Lindsay OS
<aaron@os.amperecomputing.com> wrote:
> I registered for a Coverity account and am awaiting approval for adding
> me to the QEMU project so I can test this myself (let me know if this
> isn't the right way to go about this).
>
> Would you prefer I wait until I'm able to test that this is resolved
> myself, or just submit a patch and have you test it?

You should just submit a patch. Coverity runs only on the
git master, so until your patch is in master it won't get
retested. Having an account with the coverity scan website
is useful mostly for looking at reports in more detail,
or for those enthusiastic to actively go triaging and
fixing things.

thanks
-- PMM
