Received: from eggs.gnu.org ([2001:4830:134:3::10]:49581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cIxLs-0002qb-D3
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 07:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlipchuk@redhat.com>) id 1cIxLo-0006nU-HA
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 07:47:36 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:37513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlipchuk@redhat.com>) id 1cIxLo-0006n8-C7
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 07:47:32 -0500
Received: by mail-it0-f49.google.com with SMTP id y23so80943265itc.0
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 04:47:30 -0800 (PST)
MIME-Version: 1.0
From: Maor Lipchuk <mlipchuk@redhat.com>
Date: Mon, 19 Dec 2016 14:47:29 +0200
Message-ID: <CAJ1JNOepVarVZZeVKaUN+5TTRFz-BKU+WcEu5koUR_W2YrFADA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] Is qemu-img amend an atomic operation?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi All,

Does amend considered as an atomic operation or should we mark a volume as
ILLEGAL once the amend operation fails?

also, if I call amend, but downgrade the QCOW volume compatibility level
from 1.1 to 0.10, is that atomic as well (or not, based on the answer on
the previous question)?

Regards,
Maor
