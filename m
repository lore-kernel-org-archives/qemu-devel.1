Received: from eggs.gnu.org ([2001:4830:134:3::10]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTAEq-0006YD-B7
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dTAEp-0002rh-9e
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:06:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dTAEp-0002r9-2h
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:06:47 -0400
References: <1488479153-21203-1-git-send-email-felipe@nutanix.com>
	<20170302214746.GA4711@redhat.com>
	<9950C259-FD65-4286-84D0-89FA00420E86@nutanix.com>
	<20170706164014-mutt-send-email-mst@kernel.org>
	<757B1E6A-A74C-47E2-A239-893F40922DD2@intel.com>
	<30b1f1cb-f959-7711-96c2-5d5c138135e1@redhat.com>
	<7813DE88-EB6D-4330-AC69-27E7051C4000@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9e20053-c45f-8bd4-a4d6-71f9150ffba0@redhat.com>
Date: Thu, 6 Jul 2017 19:06:35 +0200
MIME-Version: 1.0
In-Reply-To: <7813DE88-EB6D-4330-AC69-27E7051C4000@intel.com>
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
To: "Harris, James R" <james.r.harris@intel.com>, "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>



On 06/07/2017 19:03, Harris, James R wrote:
> 
> vhost-user-blk:
> 
> We have an initial implementation in our SPDK QEMU repo.  Changpeng Liu (added)
> will be sending this to the QEMU mailing list shortly.  If you are interested in viewing it
> before it hits the mailing list, you can take a look at the patch here:
> 
> https://github.com/spdk/qemu/commit/db2fcb0f5002c3d195e756eab07bd976ccf6e7c8

Nice.  But please provide some sample server too, it's a prerequisite
for committing it into QEMU.  Even a simple file backend is enough.

You can use the contrib/libvhost-user infrastructure already used by the
vhost-user-scsi sample.

Paolo
