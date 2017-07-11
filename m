Received: from eggs.gnu.org ([2001:4830:134:3::10]:49608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV2bB-0007oE-IE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dV2b8-0005B9-EQ
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:21:37 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dV2b8-0005AT-Aj
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:21:34 -0400
Received: by mail-qk0-x241.google.com with SMTP id v143so660008qkb.3
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 14:21:34 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 11 Jul 2017 11:21:21 -1000
Message-Id: <20170711212123.4368-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/2] target/i386: Implement all TBM instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, ricardo.ribalda@gmail.com

These are general purpose bit manipulation instructions akin
to the BMI1 and BMI2 instructions.  This is an AMD extension
and uses the XOP instruction prefix.

I am in the process of trying to run the gcc testsuite with -mtbm,
with and without the patchset, to see (1) if the new insns get used
and (2) that they run ok.

Please review.


r~


Richard Henderson (2):
  target/i386: Decode AMD XOP prefix
  target/i386: Implement all TBM instructions

 target/i386/cc_helper_template.h |  18 +++++
 target/i386/cpu.h                |   7 +-
 target/i386/cc_helper.c          |  28 ++++++-
 target/i386/cpu.c                |   3 +-
 target/i386/translate.c          | 163 +++++++++++++++++++++++++++++++++++----
 5 files changed, 199 insertions(+), 20 deletions(-)

-- 
2.9.4
