Received: from eggs.gnu.org ([2001:4830:134:3::10]:37879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ctlaltlaltc@gmail.com>) id 1f9Yg0-0007l9-VJ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:14:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ctlaltlaltc@gmail.com>) id 1f9Yfx-0000cE-S5
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:14:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ctlaltlaltc@gmail.com>)
	id 1f9Yfx-0000bi-M0
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:14:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id y69so4506219pfb.5
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 09:14:17 -0700 (PDT)
Received: from lijunpengdembp (li991-244.members.linode.com. [45.33.41.244])
	by smtp.gmail.com with ESMTPSA id
	t80sm9244720pgb.36.2018.04.20.09.14.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 20 Apr 2018 09:14:16 -0700 (PDT)
From: Junpeng.Li <ctlaltlaltc@gmail.com>
Date: Sat, 21 Apr 2018 00:14:13 +0800
Message-ID: <m2efj9q2i2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] qemu-io read do not dump buffer when in quiet mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org


Hi, everyone. I found a question or maybe a bug during use qemu-io to read
a range file and take the params -vq to dump buffer and do not show
I/O statistics. I use the params -vq what i want is just dump buffer
but do not show I/O statistics, but as the result show it is not.

Like below command, it do not dump buffer to standard output.

qemu-io -r -c "read -vq 0 1024" /tmp/test.qcow2

I saw the source code, when has qflag value it just goto out and do
not dump buffer when qflag and vflag has value at the same time.

    if (qflag) {
        goto out;
    }

    if (vflag) {
        dump_buffer(buf, offset, qiov.size);
    }

quiet mode here, it mean do not show I/O statistics or mean complete quiet?

--
BestRegard,
JPL
