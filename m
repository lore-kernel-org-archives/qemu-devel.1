Received: from eggs.gnu.org ([2001:4830:134:3::10]:49065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fko8i-0005XG-Kr
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fko8h-0000DP-4Y
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:13:56 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:46688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fko8g-0000D9-Ui
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 06:13:55 -0400
Received: by mail-oi0-x22c.google.com with SMTP id y207-v6so33562293oie.13
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 03:13:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180801082244.GA11408@debian.sh.intel.com>
References: <20180720083644.1431-1-tiwei.bie@intel.com>
	<20180801082244.GA11408@debian.sh.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Aug 2018 11:13:34 +0100
Message-ID: <CAFEAcA86EkMRMosb55HAoKVYCN=-jA4tvC7JMJf68VsAYoPYug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vhost: check region type before casting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 1 August 2018 at 09:22, Tiwei Bie <tiwei.bie@intel.com> wrote:
> Ping..
>
> It seems that the final release for QEMU 3.0 will be
> out soon [1]. But this fix hasn't been merged yet.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg06004.html

:-(

You just missed rc3 (which we tagged yesterday), and I'm
not sure if this meets the barrier for causing us to put
out an rc4. It is a regression, but when does it happen?
The commit message isn't very clear whether this is a
corner case or not.

thanks
-- PMM
