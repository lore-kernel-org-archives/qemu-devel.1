Received: from eggs.gnu.org ([2001:4830:134:3::10]:57913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akalita@cs.stonybrook.edu>) id 1dnd3T-0004tz-RK
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 23:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akalita@cs.stonybrook.edu>) id 1dnd3T-0005Xg-0o
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 23:55:39 -0400
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:34512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <akalita@cs.stonybrook.edu>)
	id 1dnd3S-0005TY-Qr
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 23:55:38 -0400
Received: by mail-ua0-x22a.google.com with SMTP id l11so4263756uaf.1
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 20:55:36 -0700 (PDT)
MIME-Version: 1.0
From: Arnabjyoti Kalita <akalita@cs.stonybrook.edu>
Date: Thu, 31 Aug 2017 23:55:34 -0400
Message-ID: <CAJGDS+EKh2Vg5v+xPdafQ3zfNVSsEAd2rz3C5qHByG_7JhVeAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] QEMU is looping when I load a VM snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello,

I am repeatedly facing an issue while loading a saved snapshot into QEMU.

I will detail the steps which I follow when I take a snapshot:

1. I start QEMU with *-enable-kvm* option. I then run a workload(a program
from Spec2006) on QEMU.
2. Immediately after I start running the workload, I open the QEMU monitor
and using "SAVEVM" command I save the QEMU state when the program just
started to execute.
3. Once the QEMU state is saved, I allow the program to complete. I will
then quit QEMU.
4. Finally, I will load this snapshot back while starting QEMU - using the
same CPU and machine configurations. This time I do not apply the *-enable-kvm
*option, when loading the snapshot back.
5. I have added print statements to see the value of "PC" in the function --
      cpu_get_tb_cpu_state()
6. I see that the PC value does not change and keeps looping around two or
three values every time.
7. Hence the program which was paused(upon saving) does not complete
execution upon loading.

Why would this happen ? I am looking for any inputs on how I could
understand and tackle this problem.

Thanks and Regards,
Arnab
