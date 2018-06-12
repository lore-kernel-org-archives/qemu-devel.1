Received: from eggs.gnu.org ([2001:4830:134:3::10]:32954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fShm0-0007Tf-3T
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fShlv-0004QI-8l
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:47:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60506 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fShlv-0004Pn-3M
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:47:35 -0400
Date: Tue, 12 Jun 2018 14:47:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180612143554-mutt-send-email-mst@kernel.org>
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
	<fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
	<20180605152344-mutt-send-email-mst@kernel.org>
	<CADGSJ21Qf6KpLzr+og5DOFjMPqu69n6dWRLvvj1FGAR5kVRNew@mail.gmail.com>
	<20180606002650-mutt-send-email-mst@kernel.org>
	<CADGSJ21AMp02vV+qxa+DuyvAUCCsXUFwV7wjzQ1Vy1jKV=n1HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADGSJ21AMp02vV+qxa+DuyvAUCCsXUFwV7wjzQ1Vy1jKV=n1HA@mail.gmail.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH] qemu: Introduce
 VIRTIO_NET_F_STANDBY feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Siwei Liu <loseweigh@gmail.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On Tue, Jun 05, 2018 at 03:09:26PM -0700, Siwei Liu wrote:
> The thing is cloud service provider might prefer sticking to the same
> level of service agreement (SLA) of keeping VF over migration,

That requirement is trivially satisfied by just a single VF :) If your
SLA does not require live migration, you should do just that.

-- 
MST
