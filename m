Received: from eggs.gnu.org ([2001:4830:134:3::10]:48803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dTAJe-0000WM-TC
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dTAJb-00068u-MA
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:11:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dTAJb-00068B-DS
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:11:43 -0400
Date: Thu, 6 Jul 2017 13:11:35 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <67124212.47615869.1499361095640.JavaMail.zimbra@redhat.com>
In-Reply-To: <7813DE88-EB6D-4330-AC69-27E7051C4000@intel.com>
References: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
	<20170302214746.GA4711@redhat.com>
	<9950C259-FD65-4286-84D0-89FA00420E86@nutanix.com>
	<20170706164014-mutt-send-email-mst@kernel.org>
	<757B1E6A-A74C-47E2-A239-893F40922DD2@intel.com>
	<30b1f1cb-f959-7711-96c2-5d5c138135e1@redhat.com>
	<7813DE88-EB6D-4330-AC69-27E7051C4000@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/4] Introduce vhost-user-scsi and
 sample application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James R Harris <james.r.harris@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Changpeng Liu <changpeng.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

Hi

----- Original Message -----
> 
> > On Jul 6, 2017, at 9:56 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > 
> > 
> > 
> > On 06/07/2017 18:54, Harris, James R wrote:
> >> Hi Michael,
> >> 
> >> Yes - we (SPDK team at Intel) have this on our TODO list, in addition
> >> to a polled mode virtio-scsi driver (akin to the DPDK virtio-net driver
> >> that
> >> can be used in the guest).
> > 
> > Can you also look at virtio-blk poll-mode drivers and vhost-user-blk
> > (vhost-user-blk would be really easy to write, the sample server being
> > much more work than the QEMU code)?
> > 
> > Paolo
> 
> Hi Paolo,
> 
> vhost-user-blk:
> 
> We have an initial implementation in our SPDK QEMU repo.  Changpeng Liu
> (added)
> will be sending this to the QEMU mailing list shortly.  If you are interested
> in viewing it
> before it hits the mailing list, you can take a look at the patch here:
> 
> https://github.com/spdk/qemu/commit/db2fcb0f5002c3d195e756eab07bd976ccf6e7c8

Great! I also just started looking into this, I'll take a look at your implementation. Do you also have a "server"/slave side, or plan to share one?

(fwiw, I have vhost-user-input & gpu in this branch https://github.com/elmarco/qemu/commits/vhost-user - I just rebased/fixed it, as it was 1y old already - there are a few changes I'd like to make now)

> 
> virtio-blk poll-mode driver:
> 
> Yes - this is part of our plan as well - once we have virtio-scsi in place,
> adding virtio-blk
> will be relatively straightforward.
> 
> Thanks,
> 
> -Jim
> 
> 
