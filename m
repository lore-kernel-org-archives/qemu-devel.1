Received: from eggs.gnu.org ([2001:4830:134:3::10]:45604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gUFaS-0002nt-VY
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jl4312@columbia.edu>) id 1gUFZS-0003Pj-7G
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:37:24 -0500
Received: from outprodmail02.cc.columbia.edu ([128.59.72.51]:39410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jl4312@columbia.edu>) id 1gUFZS-0003LU-3p
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 13:37:22 -0500
Received: from hazelnut (hazelnut.cc.columbia.edu [128.59.213.250])
	by outprodmail02.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	wB4IalD8032944
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 13:37:16 -0500
Received: from hazelnut (localhost.localdomain [127.0.0.1])
	by hazelnut (Postfix) with ESMTP id 6A5926D
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 13:37:16 -0500 (EST)
Received: from sendprodmail01.cc.columbia.edu (sendprodmail01.cc.columbia.edu
	[128.59.72.13]) by hazelnut (Postfix) with ESMTP id 4DCA17E
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 13:37:16 -0500 (EST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
	[209.85.208.71])
	by sendprodmail01.cc.columbia.edu (8.14.4/8.14.4) with ESMTP id
	wB4IbFCS020459
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 4 Dec 2018 13:37:16 -0500
Received: by mail-ed1-f71.google.com with SMTP id x15so8662714edd.2
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:37:15 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com.
	[209.85.128.46]) by smtp.gmail.com with ESMTPSA id
	h51sm5382513edh.17.2018.12.04.10.37.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Dec 2018 10:37:13 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id r11-v6so10644487wmb.2
	for <qemu-devel@nongnu.org>; Tue, 04 Dec 2018 10:37:12 -0800 (PST)
MIME-Version: 1.0
From: Jintack Lim <jintack@cs.columbia.edu>
Date: Tue, 4 Dec 2018 13:37:02 -0500
Message-ID: <CAHyh4xgZhGnEvkD5RiUazZ9Eq_jzr4=bXHfwBvCBkbOLN2UyKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Logging dirty pages from vhost-net in-kernel with
 vIOMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Devel Mailing List <qemu-devel@nongnu.org>
Cc: Jason Wang <jasowang@redhat.com>, "\\ Michael S . Tsirkin \\" <mst@redhat.com>

Hi,

I'm wondering how the current implementation works when logging dirty
pages during migration from vhost-net (in kernel) when used vIOMMU.

I understand how vhost-net logs GPAs when not using vIOMMU. But when
we use vhost with vIOMMU, then shouldn't vhost-net need to log the
translated address (GPA) instead of the address written in the
descriptor (IOVA) ? The current implementation looks like vhost-net
just logs IOVA without translation in vhost_get_vq_desc() in
drivers/vhost/net.c. It seems like QEMU doesn't do any further
translation of the dirty log when syncing.

I might be missing something. Could somebody shed some light on this?

Thanks,
Jintack
