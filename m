Received: from eggs.gnu.org ([2001:4830:134:3::10]:38634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0jZy-0002BZ-Sc
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 04:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1g0jZy-00083E-0W
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 04:35:54 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935]:41731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1g0jZx-00081u-K3
	for qemu-devel@nongnu.org; Fri, 14 Sep 2018 04:35:53 -0400
Received: by mail-ua1-x935.google.com with SMTP id h1-v6so6685073uao.8
	for <qemu-devel@nongnu.org>; Fri, 14 Sep 2018 01:35:53 -0700 (PDT)
MIME-Version: 1.0
From: lampahome <pahome.chen@mirlab.org>
Date: Fri, 14 Sep 2018 16:35:52 +0800
Message-ID: <CAB3eZftpYi6Am7RSRKz-JW-tA0Wrre+XdKkxP0AiBB90wq6fag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Different type of qcow2_get_cluster_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

The function qcow2_get_cluster_type() is in /block/qcow2.h
It will return the flage based on the entry.

There're some flags confused me.
What's difference between QCOW2_CLUSTER_ZERO_ALLOC &
QCOW2_CLUSTER_ZERO_PLAIN
in there?
