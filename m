Received: from eggs.gnu.org ([2001:4830:134:3::10]:50293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ssujith@avinetworks.com>) id 1d13qa-000261-Ow
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:37:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ssujith@avinetworks.com>) id 1d13qZ-00013Y-5h
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:37:36 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:36730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ssujith@avinetworks.com>)
	id 1d13qY-0000zH-VX
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 00:37:35 -0400
Received: by mail-io0-x22f.google.com with SMTP id o22so57029967iod.3
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 21:37:34 -0700 (PDT)
MIME-Version: 1.0
From: Sujith Sankar <ssujith@avinetworks.com>
Date: Thu, 20 Apr 2017 10:07:33 +0530
Message-ID: <CADuF=xUDDOoMeVvPdH3BeqOnG+RONgwyzP5aj1kDeoYL97BtOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] vhost-net - virtio - multiqueue - rx queue selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi folks,

I have a question regarding the algorithm used to select rx queue of
the VM in the case of multiqueue virtio-net on KVM.

Given a 4-tuple, how can we calculate the index of the receive queue
that virtio-net is going pick for that flow?  From some of the email
threads in some of the relevant forums, it seems RSS is not used.  But
documentations/threads do not talk about how a queue is picked.

Could you please help me with this?

Thanks,
-Sujith
