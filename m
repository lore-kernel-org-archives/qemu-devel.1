Received: from eggs.gnu.org ([2001:4830:134:3::10]:49700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pizhi0616@gmail.com>) id 1dXN6F-00060v-PZ
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pizhi0616@gmail.com>) id 1dXN6F-0001hV-1K
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:39:19 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pizhi0616@gmail.com>) id 1dXN6E-0001gg-Pd
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 03:39:18 -0400
Received: by mail-wr0-x234.google.com with SMTP id a10so16381443wrd.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 00:39:17 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?55qu5pm6?= <pizhi0616@gmail.com>
Date: Tue, 18 Jul 2017 15:39:15 +0800
Message-ID: <CAC0nwATQ-YKmYHyvOQeEmA8u=BvVrC8q20=Ogmr+TFaWRiRUfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] ask a question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

hi qemu-devel=EF=BC=8CI want to know why should add the migration blockers =
to
prevent live migration in peer mode=EF=BC=8Cif I drop the patch=EF=BC=8CWha=
t other
disadvantages will it bring=EF=BC=9F

Looking forward to your reply=E3=80=82

thanks=EF=BC=81
pizhi


commit 38e0735eb76a1479917ef3501a208d4f70998494
Author: Anthony Liguori <aliguori@us.ibm.com>
Date:   Mon Nov 14 15:09:44 2011 -0600

    ivshmem: use migration blockers to prevent live migration in peer mode
(v2)

    Now when you try to migrate with ivshmem, you get a proper QMP error:

    (qemu) migrate tcp:localhost:1025
    Migration is disabled when using feature 'peer mode' in device 'ivshmem=
'
    (qemu)

    Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>
