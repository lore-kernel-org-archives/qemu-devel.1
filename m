Received: from eggs.gnu.org ([2001:4830:134:3::10]:36978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eIDY0-0006df-T7
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:57:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eIDXx-00022E-Ot
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:57:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eIDXx-00021Y-Ix
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 07:57:33 -0500
Date: Fri, 24 Nov 2017 13:57:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171124135729.60ceff1e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Windows 10 guest hang during 'info mem'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

I've stumbled on WS2016 hang when trying to list memory map in QEMU.

Steps to reproduce:
  qemu-system-x86_64 -monitor stdio -enable-kvm -m 1G ws2016x64.img
 wait till guest boots and execute in monitor 
  (qemu) info mem

qemu will hang while printing mappings, consuming 100% cpu and not
responding to ^C.

I've also tried with old (2.8) and current qemu master and today's
upstream kernel where it also doesn't work but WS2012R2x64 guest
works just fine.

PS:
CCing KVM list as the issue happens only when KVM is enabled.
