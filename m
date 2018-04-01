Received: from eggs.gnu.org ([2001:4830:134:3::10]:45278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alexaltea123@gmail.com>) id 1f2f1M-00014d-S7
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 11:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alexaltea123@gmail.com>) id 1f2f1J-0003le-P3
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 11:35:52 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:50772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alexaltea123@gmail.com>)
	id 1f2f1J-0003jf-9Y
	for qemu-devel@nongnu.org; Sun, 01 Apr 2018 11:35:49 -0400
Received: by mail-wm0-x22a.google.com with SMTP id t67so1964919wmt.0
	for <qemu-devel@nongnu.org>; Sun, 01 Apr 2018 08:35:48 -0700 (PDT)
From: "Alexandro Sanchez Bach" <alexaltea123@gmail.com>
Date: Sun, 1 Apr 2018 17:35:44 +0200
Message-ID: <000001d3c9cf$19f0a190$4dd1e4b0$@gmail.com>
MIME-Version: 1.0
Content-Language: en-us
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] Debugging on HAXM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 'Anthony Liguori' <aliguori@us.ibm.com>, 'Glauber Costa' <gcosta@redhat.com>

Hello,

 

A bit of context: I'm working on a QEMU fork adding support for PlayStation
4 hardware. It's still in development and debugging kernel drivers has
become everyday work. While TCG supports debugging, it cannot handle various
extensions like AVX/AVX2 that are extensively used by the guest applications
and performance has become quite a problem. This system is closed source and
wasn't built with kernel debugging support, so debugging it "from the
outside" is the only possibility and hence why debugging on accelerators
(specially HAXM/WHPX) has become absolutely necessary for my project.

 

I've noticed that `gdb_breakpoint_insert` only considers KVM so far. My
question is: Has anyone planned adding debugging support to HAXM? Or is
anyone actively working on QEMU's HAXM frontend at all? If not, I would like
to work on it myself. Are there any guidelines or things I should take into
consideration to work on this accelerator (pinging Anthony and Glauber)?
Would it be more reasonable to add debugging support to HAXM [1] directly
instead of trying to use the existing APIs from QEMU to achieve the same
thing  (I was thinking in patching memory, e.g. with `hlt` instructions, to
trigger VM exits)?

 

Just want to hear your thoughts on the matter. :-)

 

Cheers,

Alexandro Sanchez

 

[1] https://github.com/intel/haxm/

 
