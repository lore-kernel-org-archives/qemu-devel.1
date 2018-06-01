Received: from eggs.gnu.org ([2001:4830:134:3::10]:55404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fOb22-0001FD-Qk
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fOb1x-0005o6-ME
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:47:14 -0400
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:46262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fOb1x-0005W7-I8
	for qemu-devel@nongnu.org; Thu, 31 May 2018 23:47:09 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w513i8YN013272
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 23:47:03 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 908DF88
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 23:47:03 -0400 (EDT)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id 1E8138F
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 23:47:02 -0400 (EDT)
Received: from mail-wr0-f199.google.com (mail-wr0-f199.google.com
	[209.85.128.199])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w513l1Ss064699
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 23:47:01 -0400
Received: by mail-wr0-f199.google.com with SMTP id l6-v6so17952724wrn.17
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 20:47:01 -0700 (PDT)
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com.
	[209.85.128.180]) by smtp.gmail.com with ESMTPSA id
	f11-v6sm13196345ede.45.2018.05.31.20.46.59
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 31 May 2018 20:46:59 -0700 (PDT)
Received: by mail-wr0-f180.google.com with SMTP id j1-v6so34894993wrm.1
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 20:46:59 -0700 (PDT)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Thu, 31 May 2018 23:46:58 -0400
Message-ID: <CAHyh4xhckUtH=gfa5K+KVehz27hVznUg7UX-Ca-AcjCvtiAhHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] vIOMMU Posted-interrupt implementation - atomic
 operation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>

Hi,

I'm implementing Posted-interrupt functionality in vIOMMU. According
to Vt-d spec 5.2.3, IOMMU performs a coherent atomic read-modify-write
operation of the posted-interrupt descriptor. I wonder how can we
achieve this considering the guest can modify the same
posted-interrupt descriptor anytime. Is there any existing mechanism
that I can use in QEMU?

Thanks,
Jintack
