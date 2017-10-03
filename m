Received: from eggs.gnu.org ([2001:4830:134:3::10]:42784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <y_hebbal@esi.dz>) id 1dzJPJ-0001VY-0S
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <y_hebbal@esi.dz>) id 1dzJPI-0007za-3y
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:22:29 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:47210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <y_hebbal@esi.dz>) id 1dzJPH-0007sa-Ur
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:22:28 -0400
Received: by mail-io0-x234.google.com with SMTP id m201so1730887iom.4
	for <qemu-devel@nongnu.org>; Tue, 03 Oct 2017 02:22:26 -0700 (PDT)
MIME-Version: 1.0
From: HEBBAL Yacine <y_hebbal@esi.dz>
Date: Tue, 3 Oct 2017 11:22:24 +0200
Message-ID: <CACEoar4cvTTY+m+J00aNPx6XjOxXmWMi1fXYsNmkB4SU4Dm3+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [Question] Where Qemu kvm_run structure is
 synchronized with the one of KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi All,
I added a field to "kvm_run" data structure in both Qemu and KVM to create
a communication interface for a VM security monitoring application in order
to avoid heavy modifications in the hypervisor.
The problem I'm facing is that when this field is updated in KVM after a VM
exit, I don't see the written value in "kvm_run" at Qemu function
"kvm_arch_handle_exit".
My question is how "kvm_run" is synchronized between Qemu and KVM ?
Thank you in advance for your answers

Yacine
