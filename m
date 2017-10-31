Received: from eggs.gnu.org ([2001:4830:134:3::10]:42606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9YXh-0006Zi-U2
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9YXd-0007rM-Cs
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:33:29 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:56004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9YXd-0007r1-5K
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:33:25 -0400
Received: by mail-wm0-x234.google.com with SMTP id y83so23949477wmc.4
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 08:33:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509455489-14101-1-git-send-email-peter.maydell@linaro.org>
References: <1509455489-14101-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 15:33:03 +0000
Message-ID: <CAFEAcA96o6S35SsC_FNjSwN84eMaEP+3U34+2b18bUdrSbyz1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

On 31 October 2017 at 13:11, Peter Maydell <peter.maydell@linaro.org> wrote:
> Just small stuff. I expect/hope to get the "report attributes
> in PAR register" fix from Andrew in, but will either send another
> pull or just apply it as a single patch once it's been reviewed.
> (I think we can call it a bugfix anyway, since it fixes booting
> of Windows on ARM.)
>
> thanks
> -- PMM
>
>
> The following changes since commit abf6e752e55b2f5afb48303429dea2db7c3a62de:
>
>   Merge remote-tracking branch 'remotes/borntraeger/tags/s390x-20171030' into staging (2017-10-30 13:02:45 +0000)
>
> are available in the git repository at:
>
>   git://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20171031
>
> for you to fetch changes up to 168df2dea701bbf3118bdfea7794369dfa694d3d:
>
>   hw/pci-host/gpex: Improve INTX to gsi routing error checking (2017-10-31 11:50:52 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * fix instruction-length bit in syndrome for WFI/WFE traps
>  * xlnx-zcu102: Specify the max number of CPUs
>  * msf2: Remove dead code reported by Coverity
>  * msf2: Wire up SYSRESETREQ in SoC for system reset
>  * hw/pci-host/gpex: Improve INTX to gsi routing error checking
>


Applied, thanks.

-- PMM
