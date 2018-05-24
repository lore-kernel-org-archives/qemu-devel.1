Received: from eggs.gnu.org ([2001:4830:134:3::10]:48324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLkHP-0002EI-MQ
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1fLkHK-0003Dv-0J
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:03:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:56195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1fLkHJ-0003D1-Oy
	for qemu-devel@nongnu.org; Thu, 24 May 2018 03:03:13 -0400
Date: Thu, 24 May 2018 15:03:28 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180524070328.GA15430@debian>
References: <20180412151232.17506-1-tiwei.bie@intel.com>
	<20180412151232.17506-3-tiwei.bie@intel.com>
	<20180523163116-mutt-send-email-mst@kernel.org>
	<20180523183444-mutt-send-email-mst@kernel.org>
	<20180523184001-mutt-send-email-mst@kernel.org>
	<20180523232101.GB15604@debian> <20180524022440.GA20792@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524022440.GA20792@debian>
Subject: Re: [Qemu-devel] [PATCH v3 2/6] vhost-user: introduce shared
 vhost-user state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On Thu, May 24, 2018 at 10:24:40AM +0800, Tiwei Bie wrote:
[...]
> > > +
> > >      qemu_purge_queued_packets(nc);
> > >  }
> > >  
> > > @@ -341,7 +342,6 @@ err:
> > >      if (user) {
> > >          vhost_user_cleanup(user);
> > >          g_free(user);
> > > -        s->vhost_user = NULL;
> 
> I don't get why cannot zero it in this case.

Hmm.. Please just ignore above comment.
Thanks for catching this bug!

Best regards,
Tiwei Bie
