Received: from eggs.gnu.org ([2001:4830:134:3::10]:44908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6asI-0007LN-9T
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6asD-0007PU-Ot
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:46 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6asD-0007OB-Gz
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:58:41 -0400
Received: by mail-wm0-x244.google.com with SMTP id x82so9122120wmg.1
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 04:58:41 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 12 Apr 2018 12:58:36 +0100
Message-Id: <20180412115838.10208-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/2] Softfloat Fixes for 2.12
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

I'd hope to include fixes for our longstanding fcvt bugs but I ran out
of time. The fixes in this series are purely regression fixes from the
softfloat re-factor. On the plus side I have a very good test case of
fcvt now ;-)

Only my patch is not reviewed.

Alex Bennée (1):
  fpu/softfloat: raise float_invalid for NaN in float_to_int

Emilio G. Cota (1):
  softfloat: fix {min,max}nummag for same-abs-value inputs

 fpu/softfloat.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.17.0
