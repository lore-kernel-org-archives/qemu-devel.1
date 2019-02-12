Received: from eggs.gnu.org ([209.51.188.92]:46626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtSoH-0004DO-1c
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtSoF-0005wl-23
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:52 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtSoE-0005oP-Oy
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:48:50 -0500
Received: by mail-pl1-x643.google.com with SMTP id f90so897568plb.10
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 23:48:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 23:48:38 -0800
Message-Id: <20190212074840.13542-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/2] linux-user: Fix AT_PLATFORM for arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-arm@nongnu.org

With 5 minutes more thought I would have checked the values
that the 64-bit kernel supplies for arm32 in compat mode.
In the process I noticed that we don't get the right string
for arm64 in big-endian mode.


r~


Richard Henderson (2):
  linux-user: Add ELF_PLATFORM for arm
  linux-user: Fix ELF_PLATFORM for aarch64_be-linux-user

 linux-user/elfload.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

-- 
2.17.2
