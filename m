Received: from eggs.gnu.org ([2001:4830:134:3::10]:53301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb5oP-0005uQ-Fo
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:28:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb5oO-0008Fi-Pd
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:28:01 -0500
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb5oO-0008FH-HF
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 08:28:00 -0500
Received: by mail-wm0-x233.google.com with SMTP id v77so154670352wmv.0
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 05:28:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
References: <1486174642-14883-1-git-send-email-joserz@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 13:27:38 +0000
Message-ID: <CAFEAcA_5rukvW1QtGQbLKeLcPsTVWC_SDNJ5-mfO1HnrPhFHoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH Risu 0/7] Risu PPC improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

On 4 February 2017 at 02:17, Jose Ricardo Ziviani
<joserz@linux.vnet.ibm.com> wrote:
> This patchset contains some fixes and improvements for ppc64le.
>
> Jose Ricardo Ziviani (7):
>   risu_ppc64le: improve xsrqpi[x] and xsrqpxp instructions
>   risu_ppc64le: fix 32-bit mov immediate
>   risu_ppc64le: implement sign extend for small neg constants
>   risu_ppc64le: implement FP random data for test improvement
>   risu_ppc64le: stop loading data to register 1 and 13
>   risu_ppc64le: remove fancy shell character cont from messages
>   risu_ppc64le: fix minor code style in assembly test code
>
>  ppc64.risu             |  9 ++++++---
>  risu_reginfo_ppc64le.c |  6 +++---
>  risugen_ppc64.pm       | 48 +++++++++++++++++++++++++++++++++++++++++++-----
>  test_ppc64le.s         | 20 +++++++++-----------
>  4 files changed, 61 insertions(+), 22 deletions(-)

Applied to risu master, thanks.

Regarding the FP random data, we should split out the
write_random_fpreg_var() from the ARM risugen code so
it can be used by any architecture. That produces a
more useful distribution of FP values for testing than a
simple evenly distributed random number does.

thanks
-- PMM
