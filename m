Received: from eggs.gnu.org ([2001:4830:134:3::10]:42279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fl9KW-0004rQ-MX
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 04:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fl9KV-0001Ud-Ky
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 04:51:32 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fl9KV-0001U9-F6
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 04:51:31 -0400
Received: by mail-oi0-x243.google.com with SMTP id 13-v6so2632232ois.1
	for <qemu-devel@nongnu.org>; Thu, 02 Aug 2018 01:51:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180802005709-mutt-send-email-mst@kernel.org>
References: <20180720083644.1431-1-tiwei.bie@intel.com>
	<20180801082244.GA11408@debian.sh.intel.com>
	<CAFEAcA86EkMRMosb55HAoKVYCN=-jA4tvC7JMJf68VsAYoPYug@mail.gmail.com>
	<20180802005709-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Aug 2018 09:51:10 +0100
Message-ID: <CAFEAcA_T3qPXtWPd8TyQ3wx=geH4q3Bvn-S9cCLVWLVxhq7V5Q@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 1 August 2018 at 22:58, Michael S. Tsirkin <mst@redhat.com> wrote:
> There's also Igor's fix for memory hotplug.
> Pretty small fixes for sure, and I'd like to have them in if possible,
> but if I'm the only one maybe we can put it in stable ...

Can you make sure that's listed on the release planning page:
https://wiki.qemu.org/Planning/3.0#Not_yet_fixed_in_any_rc

We have a handful of maybe-we-should-put-these in bugs,
so I'll make a call one way or the other on whether to do
an rc4 depending on what we've got...

thanks
-- PMM
