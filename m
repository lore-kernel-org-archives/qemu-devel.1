Received: from eggs.gnu.org ([2001:4830:134:3::10]:58388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cEdOt-0002yG-IM
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cEdOq-0007z5-HD
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:40:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cEdOq-0007yf-Bk
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:40:48 -0500
Message-ID: <1481121643.11413.14.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 07 Dec 2016 15:40:43 +0100
In-Reply-To: <58462160.7020107@intel.com>
References: <1476739332-4911-1-git-send-email-kwankhede@nvidia.com>
	<580DB32F.8040806@intel.com> <1480959854.28320.21.camel@redhat.com>
	<58462160.7020107@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v9 00/12] Add Mediated device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jike Song <jike.song@intel.com>
Cc: Kirti Wankhede <kwankhede@nvidia.com>, alex.williamson@redhat.com, cjia@nvidia.com, pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, kevin.tian@intel.com, bjsdjshi@linux.vnet.ibm.com, linux-kernel@vger.kernel.org

  Hi,

> Will update a topic/gvt-next-kvmgt-2016-12-06 today, sorry for the
> inconvenience :)

Thanks, that brings us one step forward.

Linux guest can see the device (in lspci).  Trying to load i915.ko leads
to kernel oopses on both guest and host though.  So I guess the guest
driver can't handle the device.

I've tried RHEL-7.3, kernel 3.10.0-514.el7.x86_64.  The drivers/gpu/drm/
subsystem is roughly at upstream kernel v4.6 level.  Is that too old?
IIRC some vgpu guest patches have been merged in v4.2 timeframe, so I
kind-of expected this to work ...

I'll go try the kvmgt branch in the guest next.

What is the upstream merge status btw?  As far I know the bulk of the
gvt code is scheduled for 4.10.  What about the gvt/mdev plumbing?  Will
that land in 4.10 too or is that planned for 4.11?

thanks,
  Gerd
