Received: from eggs.gnu.org ([2001:4830:134:3::10]:34779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceiUF-0001MF-N1
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceiUE-00036F-Ik
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:22:11 -0500
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceiUE-00035U-CB
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:22:10 -0500
Received: by mail-wm0-x22a.google.com with SMTP id c85so14867656wmi.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 05:22:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170214185225.7994-1-ppandit@redhat.com>
References: <20170214185225.7994-1-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 13:21:48 +0000
Message-ID: <CAFEAcA9eh475V6H6sOoW0bLhOH_351dxAyP=WhCShqPF4jVF2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 0/4] sd: sdhci: correct transfer mode
 register usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Wjjzhang <wjjzhang@tencent.com>, Jiang Xin <jiangxin1@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 14 February 2017 at 18:52, P J P <ppandit@redhat.com> wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Hello,
>
> In SDHCI protocol, the 'Block Count Enable' bit of the Transfer Mode
> register is used to control 's->blkcnt' value. This bit is not relevant
> in single block transfers. Also, Transfer Mode register value could be
> set such that 's->blkcnt' would not see an update during multi block
> transfers. Thus leading to an infinite loop.
>
> This patch set attempts to correct 'Block Count Enable' bit usage.
>
> This series incorporates changes suggested in patch set v3:
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02376.html
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg02905.html

I've gone back through the mail archives for previous versions of
this series, and I think that we just need review for patch 4 now?

thanks
-- PMM
