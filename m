Received: from eggs.gnu.org ([2001:4830:134:3::10]:48370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1fv3gM-0004cc-CV
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkrcmar@redhat.com>) id 1fv3gL-0007td-Nd
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:51:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkrcmar@redhat.com>) id 1fv3gL-0007tG-IN
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 12:51:01 -0400
Date: Wed, 29 Aug 2018 18:50:54 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Message-ID: <20180829165053.GA19438@flask>
References: <1535199590-68475-1-git-send-email-peng.hao2@zte.com.cn>
	<1535199590-68475-2-git-send-email-peng.hao2@zte.com.cn>
	<20180828145815.GJ5675@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828145815.GJ5675@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH V4 1/4] target-i386: introduce
 coalesced_pio kvm header update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peng Hao <peng.hao2@zte.com.cn>, pbonzini@redhat.com, mst@redhat.com, kvm@vger.kernel.org, qemu-devel@nongnu.org, zhong.weidong@zte.com.cn

2018-08-28 11:58-0300, Eduardo Habkost:
> On Sat, Aug 25, 2018 at 08:19:47PM +0800, Peng Hao wrote:
> > add coalesced_pio's struct and KVM_CAP_COALESCED_PIO header.
> > 
> > Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> 
> What's the status of the corresponding KVM header patch?

I got a minor request to improve compatibility and although the series
has missed the kernel merge window, we can reserve the capability number
within a week.
