Received: from eggs.gnu.org ([2001:4830:134:3::10]:58958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cZLkk-0000Go-C5
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cZLkh-0007QB-8b
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:05:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cZLkh-0007Ps-2k
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:04:59 -0500
Message-Id: <20170202175332.346975248@redhat.com>
Date: Thu, 02 Feb 2017 15:53:32 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [Qemu-devel] [patch 0/2] qemu support for kvm cpu freq hypercalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

Add a new cpu flag to allow vCPUs to perform frequency change
hypercalls from userspace.

See the kernel patchseries for more details.
