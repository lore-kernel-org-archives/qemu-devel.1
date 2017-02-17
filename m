Received: from eggs.gnu.org ([2001:4830:134:3::10]:60673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceiIq-0006Wt-H6
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceiIo-0007XI-Uk
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:10:24 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:34527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceiIo-0007WT-ON
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:10:22 -0500
Received: by mail-wm0-x229.google.com with SMTP id 196so9530564wmm.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 05:10:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1702151024310.11222@wniryva>
References: <20170214185225.7994-1-ppandit@redhat.com>
	<20170214185225.7994-3-ppandit@redhat.com>
	<CAKmqyKPWncbASv=VD1YAzKokEHxdOVse+G41XNmv5LUwy-kfUQ@mail.gmail.com>
	<alpine.LFD.2.20.1702151024310.11222@wniryva>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 13:10:01 +0000
Message-ID: <CAFEAcA9B4s0_7yBCG3Jraym_NABWZhk6JQ10sb95waQgN-YCuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 2/4] sd: sdhci: check transfer mode
 register in multi block transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>

On 15 February 2017 at 04:58, P J P <ppandit@redhat.com> wrote:
>   Hello Alistair,
>
> +-- On Tue, 14 Feb 2017, Alistair Francis wrote --+
> | On Tue, Feb 14, 2017 at 10:52 AM, P J P <ppandit@redhat.com> wrote:
> | > From: Prasad J Pandit <pjp@fedoraproject.org>
> | >
> | > In the SDHCI protocol, the transfer mode register value
> | > is used during multi block transfer to check if block count
> | > register is enabled and should be updated. Transfer mode
> | > register could be set such that, block count register would
> | > not be updated, thus leading to an infinite loop. Add check
> | > to avoid it.
> | >
> | > Reported-by: Wjjzhang <wjjzhang@tencent.com>
> | > Reported-by: Jiang Xin <jiangxin1@huawei.com>
> | > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> |
> | Didn't I already review this?
>
> Yes, you did. I resent it owing to thread
>
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02898.html

Alistair's point is that when you resend a patchset where
some patches have got reviews/acks and those patches haven't
changed significantly, you should include the Reviewed-by:
or Acked-by: tags in the commit messages on the resent patches,
so that people know they don't need to reexamine those patches.

thanks
-- PMM
