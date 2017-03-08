Received: from eggs.gnu.org ([2001:4830:134:3::10]:47208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wenwang@cs.umn.edu>) id 1clfqH-0006wv-5V
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wenwang@cs.umn.edu>) id 1clfqD-0002XA-5Z
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:57:41 -0500
Received: from mail.cs.umn.edu ([128.101.32.201]:35983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wenwang@cs.umn.edu>) id 1clfqD-0002WF-0S
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 12:57:37 -0500
Received: from localhost (enchanter.cs.umn.edu [160.94.22.228])
	by mail.cs.umn.edu (Postfix) with ESMTP id D54C240ADF5
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:18:31 -0600 (CST)
Received: from mail.cs.umn.edu ([128.101.32.201])
	by localhost (enchanter.cs.umn.edu [160.94.22.228]) (amavisd-new,
	port 10024) with ESMTP id yb5xLMN2hemv for <qemu-devel@nongnu.org>;
	Wed,  8 Mar 2017 11:18:31 -0600 (CST)
Received: from mail-it0-f49.google.com (mail-it0-f49.google.com
	[209.85.214.49])
	by mail.cs.umn.edu (Postfix) with ESMTPSA id 3762840ADEF
	for <qemu-devel@nongnu.org>; Wed,  8 Mar 2017 11:18:31 -0600 (CST)
Received: by mail-it0-f49.google.com with SMTP id m27so43057398iti.1
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 09:18:31 -0800 (PST)
MIME-Version: 1.0
From: Wenwen Wang <wenwang@cs.umn.edu>
Date: Wed, 8 Mar 2017 11:17:50 -0600
Message-ID: <CAAa=b7c4LFiBfNYWhoWPPmV00yRPjQ58RRgbKYV+ZPddL7RRPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Performance difference between QEMU 2.2.0 and 2.6.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com
Cc: Wenwen Wang <wenwang@cs.umn.edu>

Hello all,

I just found that there is a significant performance difference between
QEMU version 2.2.0 and 2.6.0.

Here are the execution times of the benchmark 458.sjeng from SPEC CINT2006
with test workload using user only emulation from ARM guest to x86-32 host:

qemu-2.2.0: 29 seconds
qemu-2.6.0: 38 seconds

I am sure that the evaluation environments are the same in the two
executions.

I also evaluated other benchmarks, it seems that they also have some
performance differences.

Could anyone tell me what this difference comes from or give me any hint?

Many thanks in advance!

Wenwen
