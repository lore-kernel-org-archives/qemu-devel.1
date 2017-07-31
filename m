Received: from eggs.gnu.org ([2001:4830:134:3::10]:49898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcGca-0003CT-6r
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dcGcX-0004xS-5e
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:44:56 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36043)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1dcGcX-0004x3-0R
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 15:44:53 -0400
Received: by mail-io0-x242.google.com with SMTP id j32so9590iod.3
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 12:44:52 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon, 31 Jul 2017 15:44:35 -0400
Message-Id: <20170731194437.4077-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v3 0/2] Add more function keys support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, eblake@redhat.com, berrange@redhat.com
Cc: John Arbuckle <programmingkidx@gmail.com>

QEMU can only handle up to function key F15. These patches extend QEMU to F24. 

John Arbuckle (2):
  Add more function keys to QEMU
  Add more function keys to cocoa.m

 qapi-schema.json  | 16 +++++++++++++++-
 ui/cocoa.m        |  5 +++++
 ui/input-keymap.c | 12 ++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.11.0 (Apple Git-81)
