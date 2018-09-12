Received: from eggs.gnu.org ([2001:4830:134:3::10]:36411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fzzi5-0004gZ-1x
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1fzzgk-0002ff-03
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:35:50 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934]:34762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1fzzgj-0002fK-PF
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 03:35:49 -0400
Received: by mail-ua1-x934.google.com with SMTP id r15-v6so924257uao.1
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 00:35:49 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Wed, 12 Sep 2018 15:35:48 +0800
Message-ID: <CAB3eZfvRJRR1k0X1MQivPMcLRNZR07yv1ZxBiDAkF3qOryK0UQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Can I convert backing file to internal snapshot?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

I have two qcow2 A & B, and A is backing file of B.

Can I convert both A&B to one image and containing data of both?

ex:
one new image will contain data of A and B. When I check it by qemu-img
info, I can see one snapshot in the new image.

thanks
