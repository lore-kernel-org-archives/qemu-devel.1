Received: from eggs.gnu.org ([2001:4830:134:3::10]:47842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e07ZX-0000fk-F7
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e07ZS-0002aG-HS
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:23 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:55685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1e07ZS-0002ZJ-Be
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 10:56:18 -0400
Received: by mail-io0-x234.google.com with SMTP id z187so13641049ioz.12
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 07:56:18 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Thu,  5 Oct 2017 10:55:55 -0400
Message-Id: <20171005145557.5746-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] ui/cocoa.m: enable guest to see
 control-alt key combinations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently if the user needs to send a control-alt key combination, he or she was either out of luck or had to rely on the monitor's sendkey command to do so. With this patch the user can now directly send control-alt key combinations. This is great for Windows guest that may need the control-alt-delete key combination. 

John Arbuckle (2):
  move ungrab to ctrl-alt-g
  send ctrl-alt key combinations to guest if not used by QEMU

 ui/cocoa.m | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

--
v2 changes:
- changed logic to use existing if case
 
2.13.5 (Apple Git-94)
