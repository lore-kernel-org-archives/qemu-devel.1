Received: from eggs.gnu.org ([2001:4830:134:3::10]:46194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6zIk-00036q-Rl
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6zIf-0000bE-I7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:03:42 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6zIf-0000af-AL
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 10:03:37 -0400
Received: by mail-wr0-x244.google.com with SMTP id y7so8409658wrh.10
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 07:03:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 13 Apr 2018 15:03:32 +0100
Message-Id: <20180413140334.26622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/2] Softfloat Fixes for 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

The float_invalid patch now handles the Inf case as well and includes
the fix to round_to_uint_and_pack.

Alex Bennée (1):
  fpu/softfloat: raise float_invalid for NaN/Inf in
    round_to_int_and_pack

Emilio G. Cota (1):
  softfloat: fix {min,max}nummag for same-abs-value inputs

 fpu/softfloat.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.17.0
