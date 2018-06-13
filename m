Received: from eggs.gnu.org ([2001:4830:134:3::10]:44622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akalita@cs.stonybrook.edu>) id 1fSv51-0004tm-7S
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akalita@cs.stonybrook.edu>) id 1fSv50-0007yB-Fm
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:00:11 -0400
Received: from mail-lf0-x234.google.com ([2a00:1450:4010:c07::234]:41815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <akalita@cs.stonybrook.edu>)
	id 1fSv50-0007xa-4C
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 22:00:10 -0400
Received: by mail-lf0-x234.google.com with SMTP id d24-v6so1368516lfa.8
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 19:00:09 -0700 (PDT)
MIME-Version: 1.0
From: Arnabjyoti Kalita <akalita@cs.stonybrook.edu>
Date: Tue, 12 Jun 2018 22:00:07 -0400
Message-ID: <CAJGDS+G_c5O=xtngCa5ZjG3jU1yJPBq3fV6TV4fq_CgKRs+yVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Confusion regarding VMEntry events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello all,

I am working on developing a "modified" record-replay mechanism for
recording and replaying disk and network events along with VMEntry events.
I have managed to identify the "correct" points where I am going to record
the disk and the network events. But I am not quite sure at which point in
the source code do I call the "VMEntry record" handler.

I am assuming that the VMEntry usually happens just before the ioctl
"KVM_RUN" is called. Specifically the below lines of code :-

function : kvm_cpu_exec()
.....
.....
// record(VMENTRY)       -- calling VMENTRY record and replay handler
run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);

Is this the correct point where a VMEntry command is "logically" executed
by the host CPU ? Are there other places in the KVM code where VMEntries
can happen as well ?  Please help me out regarding these questions.

Thank you.

Regards,
Arnab
