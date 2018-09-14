Received: from eggs.gnu.org ([2001:4830:134:3::10]:49348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1g0hge-0002wn-0X
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1g0hga-0002NY-FQ
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:34:38 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1g0hgW-0002Cr-Nl
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 02:34:34 -0400
Received: by mail-wr1-x444.google.com with SMTP id a108-v6so9090188wrc.13
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 23:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <1536163920-2443-1-git-send-email-zhangckid@gmail.com>
In-Reply-To: <1536163920-2443-1-git-send-email-zhangckid@gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 14 Sep 2018 14:32:48 +0800
Message-ID: <CAK3tnvK6T8fxdAmtFuB9o7Gc8oyFYuDEsCn_mv-+V7uyf3cQFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docs/block-replication.txt: Add more
 detail about replication_do_checkpoint_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi All,

No news update?
Ping...

Thanks
Zhang Chen

On Thu, Sep 6, 2018 at 12:12 AM Zhang Chen <zhangckid@gmail.com> wrote:

> Add more detail description for COLO checkpoint use case.
> Suggested by Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  docs/block-replication.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/docs/block-replication.txt b/docs/block-replication.txt
> index 6bde6737fb..b6c5e94764 100644
> --- a/docs/block-replication.txt
> +++ b/docs/block-replication.txt
> @@ -131,9 +131,10 @@ a. replication_start_all()
>     thread.
>  b. replication_do_checkpoint_all()
>     This interface is called after all VM state is transferred to
> -   Secondary QEMU. The Disk buffer will be dropped in this interface.
> -   The caller must hold the I/O mutex lock if it is in
> migration/checkpoint
> -   thread.
> +   secondary node, and in primary node this interface no need to
> +   called after synchronizing all the states. The Disk buffer will be
> dropped
> +   in this interface. The caller must hold the I/O mutex lock if it is
> +   in migration/checkpoint thread.
>  c. replication_get_error_all()
>     This interface is called to check if error happened in replication.
>     The caller must hold the I/O mutex lock if it is in
> migration/checkpoint
> --
> 2.17.GIT
>
>
