Received: from eggs.gnu.org ([2001:4830:134:3::10]:59648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fkou9-0005qE-8H
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fkou6-0004aJ-3a
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:02:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:13449)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fkou5-0004Xw-Q1
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:02:54 -0400
Date: Wed, 1 Aug 2018 19:02:20 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180801110220.GA29675@debian>
References: <20180720083644.1431-1-tiwei.bie@intel.com>
	<20180801082244.GA11408@debian.sh.intel.com>
	<CAFEAcA86EkMRMosb55HAoKVYCN=-jA4tvC7JMJf68VsAYoPYug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

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
> out an rc4.

This is just a very simple fix. I'm not sure whether
an rc4 is really needed.

> It is a regression, but when does it happen?
> The commit message isn't very clear whether this is a
> corner case or not.

It always happens when I try to use vIOMMU in vhost, as
long as qom-cast-debug isn't disabled during ./configure.

Thanks,
Tiwei
