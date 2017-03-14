Received: from eggs.gnu.org ([2001:4830:134:3::10]:60914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnnwC-0001if-PS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnnwB-0001U7-Uk
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:00:36 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnnwB-0001TG-P8
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:00:35 -0400
Received: by mail-wm0-x236.google.com with SMTP id v186so66181549wmd.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 08:00:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489478550-19431-1-git-send-email-jasowang@redhat.com>
References: <1489478550-19431-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Mar 2017 16:00:14 +0100
Message-ID: <CAFEAcA-z8v-kucAe1mz2e+=pzRtqe9poCPkB=K=d0ySLfow+dA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 March 2017 at 09:02, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit 5bac3c39c82e149515c10643acafd1d292433775:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2017-03-13 15:08:01 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to adb560f7fc92903f52071086a46422be1e3f4640:
>
>   hw/net: implement MIB counters in mcf_fec driver (2017-03-14 15:39:55 +0800)
>
> ----------------------------------------------------------------
> - fix e100e memory regions leaks during cleanup
> - fix fec MIB counters
> - fix COLO trace print
> ----------------------------------------------------------------
> Greg Ungerer (1):
>       hw/net: implement MIB counters in mcf_fec driver
>
> Paolo Bonzini (1):
>       e1000e: correctly tear down MSI-X memory regions
>
> Zhang Chen (1):
>       COLO-compare: Fix trace_event print bug
>
>  hw/net/e1000e.c    |   2 +-
>  hw/net/mcf_fec.c   | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/colo-compare.c |  33 +++++++++++----
>  3 files changed, 141 insertions(+), 9 deletions(-)

Applied, thanks.

-- PMM
