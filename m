Received: from eggs.gnu.org ([2001:4830:134:3::10]:33560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1d03as-0001Ar-0z
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 06:09:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhunxun@gmail.com>) id 1d03ar-0004Fm-Ab
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 06:09:13 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:33601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhunxun@gmail.com>) id 1d03ar-0004FI-4q
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 06:09:13 -0400
Received: by mail-wr0-x233.google.com with SMTP id l28so80776139wre.0
	for <qemu-devel@nongnu.org>; Mon, 17 Apr 2017 03:09:12 -0700 (PDT)
MIME-Version: 1.0
From: "jack.chen" <zhunxun@gmail.com>
Date: Mon, 17 Apr 2017 18:09:11 +0800
Message-ID: <CADUDsAo4-QypkwSR9p8ABpBRqtvCO886fec2BGdq1JtgCgt-6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu memory manage question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu <qemu-devel@nongnu.org>

hello,I have some questions about memory allocation in qemu for
virtual machine.I found when configure_accelerator function was called
,memory slots  were registered to KVM,but at that time address_space
have not been initialized and ram have not been allocated,it is really
confused me,Thanks a lot!!
