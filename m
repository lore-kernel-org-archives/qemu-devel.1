Received: from eggs.gnu.org ([2001:4830:134:3::10]:34105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fq7Cd-0004lM-Vt
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:35:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fq7Cd-0003Uj-79
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:35:55 -0400
Received: from mail-vk0-x22c.google.com ([2607:f8b0:400c:c05::22c]:38969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1fq7Cc-0003Td-LW
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 21:35:55 -0400
Received: by mail-vk0-x22c.google.com with SMTP id e139-v6so617472vkf.6
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 18:35:53 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Thu, 16 Aug 2018 09:35:52 +0800
Message-ID: <CAB3eZfsv+JDr+C=BaKEmZvW9meTwNub2HfwXO5DX7mf+BJqO0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How do you do when write more than 16TB data to qcow2
 on ext4?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

We all know there's a file size limit 16TB in ext4 and other fs has their
limit,too.

If I create an qcow2 20TB on ext4 and write to it more than 16TB. Data more
than 16TB can't be written to qcow2.

So, is there any better ways to solve this situation?

What I thought is to create new qcow2 called qcow2-new and setup the
backing file be the previous qcow2.
