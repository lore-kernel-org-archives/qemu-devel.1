Received: from eggs.gnu.org ([2001:4830:134:3::10]:41106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejRZe-0000FG-Pr
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:23:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejRZb-0002tv-MU
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:23:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejRZb-0002tf-Hk
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:23:47 -0500
References: <20180125040328.22867-1-tiwei.bie@intel.com>
	<20180125040328.22867-7-tiwei.bie@intel.com>
	<2e83b7fa-8cec-4c13-003f-f753a13fbfe2@redhat.com>
	<20180206044005.louuil5etk6vsy4z@debian-xvivbkq.sh.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7ff477b-11eb-720b-c389-1b75348f3a89@redhat.com>
Date: Wed, 7 Feb 2018 16:23:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180206044005.louuil5etk6vsy4z@debian-xvivbkq.sh.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v1 6/6] vhost-user: add VFIO
 based accelerators support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, stefanha@redhat.com, cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com

On 06/02/2018 05:40, Tiwei Bie wrote:
> In our case, the accelerator for
> each VM is a PCI VF device and the PCI card has vswitch
> logic (the VFs are the ports of switch to connect VMs).

Ok, this makes a lot more sense now. :)

Paolo

> So the card is a vswitch accelerator which will be shared
> between multiple VMs.
