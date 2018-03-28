Received: from eggs.gnu.org ([2001:4830:134:3::10]:40443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f1340-0006kM-8w
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f133x-0007ac-82
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:51:56 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:35103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f133x-0007aD-3O
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 00:51:53 -0400
Received: by mail-oi0-x235.google.com with SMTP id z8-v6so1048854oix.2
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 21:51:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Mar 2018 12:51:39 +0800
Message-Id: <20180328045140.16462-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-2.12 0/1] tcg mul[us]h fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, peter.maydell@linaro.org

This is material for stable as well.


r~


The following changes since commit fa3704d87720d7049d483ff669b9e2ff991e7658:

  Update version for v2.12.0-rc1 release (2018-03-27 22:04:23 +0100)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20180328

for you to fetch changes up to f2f1dde75160cac6ede330f3db50dc817d01a2d6:

  tcg: Mark muluh_i64 and mulsh_i64 as 64-bit ops (2018-03-28 12:45:16 +0800)

----------------------------------------------------------------
Fix muluh_i64 and mulsh_i64 flags

----------------------------------------------------------------
Richard Henderson (1):
      tcg: Mark muluh_i64 and mulsh_i64 as 64-bit ops

 tcg/tcg-opc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
