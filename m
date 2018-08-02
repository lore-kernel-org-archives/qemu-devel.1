Received: from eggs.gnu.org ([2001:4830:134:3::10]:46825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fl9gF-00028B-P7
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:14:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fl9gA-0004hD-RI
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:13:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fl9gA-0004ga-M6
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 05:13:54 -0400
Date: Thu, 2 Aug 2018 12:13:50 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180802121332-mutt-send-email-mst@kernel.org>
References: <20180720083644.1431-1-tiwei.bie@intel.com>
	<20180801082244.GA11408@debian.sh.intel.com>
	<CAFEAcA86EkMRMosb55HAoKVYCN=-jA4tvC7JMJf68VsAYoPYug@mail.gmail.com>
	<20180802005709-mutt-send-email-mst@kernel.org>
	<CAFEAcA_T3qPXtWPd8TyQ3wx=geH4q3Bvn-S9cCLVWLVxhq7V5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_T3qPXtWPd8TyQ3wx=geH4q3Bvn-S9cCLVWLVxhq7V5Q@mail.gmail.com>
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

On Thu, Aug 02, 2018 at 09:51:10AM +0100, Peter Maydell wrote:
> On 1 August 2018 at 22:58, Michael S. Tsirkin <mst@redhat.com> wrote:
> > There's also Igor's fix for memory hotplug.
> > Pretty small fixes for sure, and I'd like to have them in if possible,
> > but if I'm the only one maybe we can put it in stable ...
> 
> Can you make sure that's listed on the release planning page:
> https://wiki.qemu.org/Planning/3.0#Not_yet_fixed_in_any_rc
> 
> We have a handful of maybe-we-should-put-these in bugs,
> so I'll make a call one way or the other on whether to do
> an rc4 depending on what we've got...
> 
> thanks
> -- PMM

Done. There's one regression and one non-regression.

-- 
MST
