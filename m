Received: from eggs.gnu.org ([2001:4830:134:3::10]:44951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fD9Wz-0003YB-So
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1fD9Wv-0002DZ-Tn
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:11:53 -0400
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:33484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1fD9Wv-00028m-P8
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:11:49 -0400
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w3UE8Y9i023530
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:11:43 -0400
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id DE7D17E
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:11:43 -0400 (EDT)
Received: from sendprodmail02.cc.columbia.edu (sendprodmail02.cc.columbia.edu
	[128.59.72.14]) by hazelnut (Postfix) with ESMTP id C7F6880
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:11:43 -0400 (EDT)
Received: from mail-wm0-f69.google.com (mail-wm0-f69.google.com [74.125.82.69])
	by sendprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	w3UEBgxo050851
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:11:43 -0400
Received: by mail-wm0-f69.google.com with SMTP id 70so3092816wmb.2
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 07:11:43 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com.
	[74.125.82.44]) by smtp.gmail.com with ESMTPSA id
	q6-v6sm4480716edb.66.2018.04.30.07.11.40 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 30 Apr 2018 07:11:41 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id i3so14418434wmf.3
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 07:11:40 -0700 (PDT)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Mon, 30 Apr 2018 10:11:39 -0400
Message-ID: <CAHyh4xgMqsxCUOH-_p=DWVWpp0stxfwdfFo2s2cn1nmR2v5Siw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] How to check if Vt-d is capable of posted-interrupt?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>, KVM General <kvm@vger.kernel.org>

Hi,

I wonder how to check if Vt-d is capable of posted-interrupt? I'm
using Intel E5-2630 v3.

I was once told that APICv and posted-interrupt capability always come
together. But it seems like my cpu support APICv
(/sys/module/kvm_intel/parameters/enable_apicv is Y), but
posted-interrupt capability is only shipped with the next generation
of the cpu (E5-2600 v4, which is Broadwell).

What would be an easy way to check this?

Thanks,
Jintack
