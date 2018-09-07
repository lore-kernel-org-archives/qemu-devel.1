Received: from eggs.gnu.org ([2001:4830:134:3::10]:48284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyNsZ-0007B5-8c
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyNsV-000756-P5
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:01:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fyNsV-000747-Hq
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:01:19 -0400
Date: Fri, 7 Sep 2018 17:01:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180907165909-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535706305-118115-5-git-send-email-peng.hao2@zte.com.cn>
	<1535706305-118115-4-git-send-email-peng.hao2@zte.com.cn>
	<1535706305-118115-3-git-send-email-peng.hao2@zte.com.cn>
	<1535706305-118115-2-git-send-email-peng.hao2@zte.com.cn>
Subject: Re: [Qemu-devel] [PATCH V5 1/4] target-i386: introduce
 coalesced_pio kvm header update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: pbonzini@redhat.com, rkrcmar@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Fri, Aug 31, 2018 at 05:05:02PM +0800, Peng Hao wrote:
> add coalesced_pio's struct and KVM_CAP_COALESCED_PIO header.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>

Despite what the subject says, this is a kvm patch
not a target-i386 one. In fact none of these are.

And it does not add a header.

Please change subjects so correct people review your patches.
E.g. this one should be

kvm: add coalesced_pio support

Needs to be rebased too.

-- 
MST
