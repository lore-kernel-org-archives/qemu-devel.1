Received: from eggs.gnu.org ([2001:4830:134:3::10]:39174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fkz8l-0004s7-Jq
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 17:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fkz8i-00082m-H0
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 17:58:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fkz8i-0007yp-Bh
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 17:58:40 -0400
Date: Thu, 2 Aug 2018 00:58:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180802005709-mutt-send-email-mst@kernel.org>
References: <20180720083644.1431-1-tiwei.bie@intel.com>
	<20180801082244.GA11408@debian.sh.intel.com>
	<CAFEAcA86EkMRMosb55HAoKVYCN=-jA4tvC7JMJf68VsAYoPYug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA86EkMRMosb55HAoKVYCN=-jA4tvC7JMJf68VsAYoPYug@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] vhost: check region type before casting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Tiwei Bie <tiwei.bie@intel.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Aug 01, 2018 at 11:13:34AM +0100, Peter Maydell wrote:
> On 1 August 2018 at 09:22, Tiwei Bie <tiwei.bie@intel.com> wrote:
> > Ping..
> >
> > It seems that the final release for QEMU 3.0 will be
> > out soon [1]. But this fix hasn't been merged yet.
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg06004.html
> 
> :-(
> 
> You just missed rc3 (which we tagged yesterday), and I'm
> not sure if this meets the barrier for causing us to put
> out an rc4. It is a regression, but when does it happen?
> The commit message isn't very clear whether this is a
> corner case or not.
> 
> thanks
> -- PMM

There's also Igor's fix for memory hotplug.
Pretty small fixes for sure, and I'd like to have them in if possible,
but if I'm the only one maybe we can put it in stable ...

I have collected these two in my tree meanwhile. Let me know.

-- 
MST
