Received: from eggs.gnu.org ([2001:4830:134:3::10]:49846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cFlP2-0000zR-Ch
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 12:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cFlOz-00038g-9o
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 12:25:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cFlOz-00038M-5I
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 12:25:37 -0500
Message-Id: <20161210172148.361793326@redhat.com>
Date: Sat, 10 Dec 2016 15:21:48 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [Qemu-devel] [qemu patch V4 0/2] improve kvmclock difference on
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

See individual patches for details. This patchset depends on kernels
"[PATCH] kvm: kvmclock: let KVM_GET_CLOCK return whether the master
clock is in use" from Paolo.
