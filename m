Received: from eggs.gnu.org ([209.51.188.92]:36733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <icarus19971031@gmail.com>) id 1hFDpX-0003sg-KX
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <icarus19971031@gmail.com>) id 1hFDpW-0000Hc-Kv
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:16:07 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:34178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <icarus19971031@gmail.com>)
	id 1hFDpW-0000G7-7f
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 04:16:06 -0400
Received: by mail-wr1-x433.google.com with SMTP id p10so14904671wrq.1
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 01:16:05 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5a6L5bu25p2w?= <icarus19971031@gmail.com>
Date: Sat, 13 Apr 2019 16:15:52 +0800
Message-ID: <CA+7cjLHg8+X0GDGLbk=Dvo=Hjo_LpECa-bPzMO-higpnKoo8LA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to use QEMU's "cpu_physical_memory_" functions?
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

I have started a project which requires the host to continuously write to
VM's memory. VM reads its memory and performs some operations.
I've found in this thread
<https://lists.gnu.org/archive/html/qemu-devel/2014-11/msg03166.html> that
I can use QEMU's "cpu_physical_memory_" functions. And I have found their
definitions in "include/exec/cpu-common.h" in the source code of QEMU.
However, in the package distributed by the distro (Arch Linux), I cannot
find the corresponding headers. So I just want to know how can I use these
functions.
