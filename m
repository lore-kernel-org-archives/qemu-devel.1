Received: from eggs.gnu.org ([2001:4830:134:3::10]:55939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1djtgk-0002fN-B6
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1djtgh-00019Q-5Z
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:52:46 -0400
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:36189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1djtgh-00018s-0w
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 16:52:43 -0400
Received: by mail-it0-x22e.google.com with SMTP id 77so36658387itj.1
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 13:52:41 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 21 Aug 2017 16:52:24 -0400
Message-Id: <20170821205225.3401-2-programmingkidx@gmail.com>
In-Reply-To: <20170821205225.3401-1-programmingkidx@gmail.com>
References: <20170821205225.3401-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] ui/cocoa.m: enable guest to see
 control-alt key combinations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org qemu-devel peter . maydell @ linaro . org" <qemu-devel@nongnu.org>
Cc: John Arbuckle <programmingkidx@gmail.com>

Currently if the user needs to send a control-alt key combination, he or she was either out of luck or had to rely on the monitor's sendkey command to do so. With this patch the user can now directly send control-alt key combinations. This is great for Windows guest that may need the control-alt-delete key combination. 

John Arbuckle (2):
  move ungrab to ctrl-alt-g
  send ctrl-alt key combinations to guest if not used by QEMU

 ui/cocoa.m | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.11.0 (Apple Git-81)
