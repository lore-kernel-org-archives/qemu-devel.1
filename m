Received: from eggs.gnu.org ([2001:4830:134:3::10]:46070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4u0-0000fi-9E
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1er4ty-00072Q-9A
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:24 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1er4ty-0006zg-39
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 11:48:22 -0500
Received: by mail-pf0-x241.google.com with SMTP id j20so1224463pfi.1
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 08:48:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 28 Feb 2018 08:48:12 -0800
Message-Id: <20180228164816.24110-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RISU 0/3] ARM additions for v8.1-simd and v8.3-compnum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

I've rebased these onto master.  There don't seem to be any
consistent examples of how extensions are to be named in this
new group-enabled world, but it's my opinion that the bike
shed should be green.

Since fp16 support is not yet present on the AArch32 side,
I have disabled generation of those instructions here.


r~


Richard Henderson (3):
  Add aa64 sqrdml[as]h
  Add aa64 fcadd + fcmla
  Add arm and thumb vqrdml[as]h, vcadd, vcmla

 aarch64.risu | 37 +++++++++++++++++++++++++++++++++++++
 arm.risu     | 25 +++++++++++++++++++++++++
 thumb.risu   | 25 +++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

-- 
2.14.3
