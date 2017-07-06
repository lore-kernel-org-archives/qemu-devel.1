Received: from eggs.gnu.org ([2001:4830:134:3::10]:42198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTA5N-0001lB-3e
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTA5M-0002C6-7A
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:57:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dTA5M-0002Bb-04
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 12:57:00 -0400
References: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
	<20170302214746.GA4711@redhat.com>
	<9950C259-FD65-4286-84D0-89FA00420E86@nutanix.com>
	<20170706164014-mutt-send-email-mst@kernel.org>
	<757B1E6A-A74C-47E2-A239-893F40922DD2@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30b1f1cb-f959-7711-96c2-5d5c138135e1@redhat.com>
Date: Thu, 6 Jul 2017 18:56:47 +0200
MIME-Version: 1.0
In-Reply-To: <757B1E6A-A74C-47E2-A239-893F40922DD2@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Harris, James R" <james.r.harris@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Felipe Franciosi <felipe@nutanix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>, "yuanhan.liu@linux.intel.com" <yuanhan.liu@linux.intel.com>



On 06/07/2017 18:54, Harris, James R wrote:
> Hi Michael,
> 
> Yes - we (SPDK team at Intel) have this on our TODO list, in addition
> to a polled mode virtio-scsi driver (akin to the DPDK virtio-net driver that
> can be used in the guest).

Can you also look at virtio-blk poll-mode drivers and vhost-user-blk
(vhost-user-blk would be really easy to write, the sample server being
much more work than the QEMU code)?

Paolo
