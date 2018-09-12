Received: from eggs.gnu.org ([2001:4830:134:3::10]:52892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fzu1I-00004q-MC
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 21:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fzu1H-0007Xp-UT
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 21:32:40 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a]:38857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1fzu1H-0007Rx-MQ
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 21:32:39 -0400
Received: by mail-ua1-x92a.google.com with SMTP id o11-v6so264127uak.5
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 18:32:27 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Wed, 12 Sep 2018 09:32:26 +0800
Message-ID: <CAB3eZfv6QFAABhzxCKjVY_36j9th_3sbcbzaOQTGkm0mhJ-BoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] What kind of situation to use internal or external
 snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

as title, I know there're two snapshots in qemu, but I don't know when to
use them well.

What I know is internal snapshot will save the info of L1 and L2 table in
the end of image but external snapshot won't because external snapshot
create new file to save cow data.

So when to use internal snapshot or external snapshot?

thanks to everyone.
