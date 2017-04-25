Received: from eggs.gnu.org ([2001:4830:134:3::10]:58550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2qxM-00039i-5t
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2qxH-0002Eq-RV
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:15:59 -0400
Received: from mail-io0-x236.google.com ([2607:f8b0:4001:c06::236]:36653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2qxH-0002Ee-Mb
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:15:55 -0400
Received: by mail-io0-x236.google.com with SMTP id p80so89129950iop.3
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:15:55 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BDF7343A-306F-4FB4-89C5-CD73197F4573@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:15:44 -0400
Subject: [Qemu-devel] [PATCH 0/9] Add PowerPC support to risu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Makes risu usable on a PowerPC Macintosh running Mac OS X.

John Arbuckle (9):
   Add ppc.risu file.
   Add risu_ppc.c file.
   Add risu_reginfo_ppc.c file.
   Add risu_reginfo_ppc.h file
   Add risugen_ppc.pm file.
   Add ppc support to configure
   Add verbose option.
   Add end of test message
   Add more descriptive comment for mismatch or end of test condition.

  configure          |   4 +-
  ppc.risu           | 527 +++++++++++++++++++++++++++++++++++++
  risu.c             |  14 +-
  risu_ppc.c         |  41 +++
  risu_reginfo_ppc.c | 273 ++++++++++++++++++++
  risu_reginfo_ppc.h |  32 +++
  risugen_ppc.pm     | 744 +++++++++++++++++++++++++++++++++++++++++++ 
++++++++++
  7 files changed, 1632 insertions(+), 3 deletions(-)
  create mode 100644 ppc.risu
  create mode 100644 risu_ppc.c
  create mode 100644 risu_reginfo_ppc.c
  create mode 100644 risu_reginfo_ppc.h
  create mode 100644 risugen_ppc.pm

-- 
2.10.2
