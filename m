Received: from eggs.gnu.org ([2001:4830:134:3::10]:59428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gERjZ-0006ty-1J
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 00:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gERjU-0001mI-Sb
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 00:22:28 -0400
Received: from outprodmail01.cc.columbia.edu ([128.59.72.39]:44362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1gERjT-0001g1-Oc
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 00:22:23 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w9M4K6nT036546
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 00:22:16 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 5C8A86D
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 00:22:16 -0400 (EDT)
Received: from sendprodmail04.cc.columbia.edu (sendprodmail04.cc.columbia.edu
	[128.59.72.16]) by hazelnut (Postfix) with ESMTP id E209E6D
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 00:22:15 -0400 (EDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
	[209.85.208.69])
	by sendprodmail04.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w9M4MFvY058208
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Oct 2018 00:22:15 -0400
Received: by mail-ed1-f69.google.com with SMTP id w42-v6so23904850edd.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 21:22:15 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com.
	[209.85.128.48]) by smtp.gmail.com with ESMTPSA id
	38-v6sm13194820edz.33.2018.10.21.21.22.11 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 21 Oct 2018 21:22:11 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id o17-v6so8060631wmh.0
	for <qemu-devel@nongnu.org>; Sun, 21 Oct 2018 21:22:11 -0700 (PDT)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Mon, 22 Oct 2018 00:22:02 -0400
Message-ID: <CAHyh4xiVxNOxwWeKDw2ccAURx3zRMTd+nVLD=oav6ShqCBdjXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Virtual IOMMU is working for Windows VM?
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

I wonder if vIOMMU is working for Windows VM?

I tried it with v2.11.0, but it didn't seem to work. I assume that seaBIOS
sets IOMMU on by default as is the case when I launched a Linux VM. But I
might be missing something. Can somebody shed some light on it?

Thanks,
Jintack
