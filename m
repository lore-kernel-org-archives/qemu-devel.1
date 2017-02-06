Received: from eggs.gnu.org ([2001:4830:134:3::10]:53795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1caa7J-0003a3-18
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 22:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1caa7F-0007Yx-Uj
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 22:37:25 -0500
Received: from szxga02-in.huawei.com ([119.145.14.65]:27201)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1caa7F-0007XU-JQ
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 22:37:21 -0500
Message-ID: <5897EF52.5030709@huawei.com>
Date: Mon, 6 Feb 2017 11:36:50 +0800
From: Gonglei <arei.gonglei@huawei.com>
MIME-Version: 1.0
References: <1486146260-8092-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486146260-8092-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ui/vnc: Drop unused vnc_has_job() and
 vnc_jobs_clear()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, patches@linaro.org



On 2017/2/4 2:24, Peter Maydell wrote:
> The functions vnc_has_job() and vnc_jobs_clear() are
> never used; remove them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> 
> I last had a go at this five years ago:
> http://patchwork.ozlabs.org/patch/192335/
> 
> Since then vnc_stop_worker_thread() got removed anyway in
> commit 09526058d, but the vnc_jobs_clear() function that
> it was the only caller of got left behind.
> 
> vnc_has_job() has never been used by anybody, and it's
> impossible to use in a non-racy way, so drop it too.
> 
>  ui/vnc-jobs.h |  2 --
>  ui/vnc-jobs.c | 23 -----------------------
>  2 files changed, 25 deletions(-)

Reviewed-by: Gonglei <arei.gonglei@huawei.com>
