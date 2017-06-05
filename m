Received: from eggs.gnu.org ([2001:4830:134:3::10]:38515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dI0ou-0007nD-FP
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dI0or-0000GH-CB
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:36847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dI0or-0000F9-11
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 18:49:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  5 Jun 2017 18:49:36 -0400
Message-Id: <1496702979-26132-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 0/3] tcg: allocate TB structs preceding
 translated code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, alex.bennee@linaro.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Pranith Kumar <bobby.prani@gmail.com>

v1: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg00780.html

Changes from v1:

- Define QEMU_CACHELINE_SIZE as suggested by Richard.
  We try to get the value from the machine running configure, but if we fail
  we use some reasonable defaults. In any case the value can be overriden
  from --extra-cflags at configure time, which is particularly useful when
  cross-compiling.

- Use QEMU_CACHELINE_SIZE where appropriate, namely in tests/.

- In the unlikely case that code_gen_buffer_size / avg block / 8 is 0, then
  set tbs_size to 64K instead of just 1K, as suggested by Richard.

This patchset applies on top of rth's tcg-next branch (pull-tcg-20170605 tag).

NB. Apologies if some emails sent to me bounced during the last couple of days;
my domain name (braap.org) was down.

Thanks,

		Emilio
