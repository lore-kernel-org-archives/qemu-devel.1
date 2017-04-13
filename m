Received: from eggs.gnu.org ([2001:4830:134:3::10]:57533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1cycRb-0003xi-Nk
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 06:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vase@selfip.ru>) id 1cycRY-00060E-Ls
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 06:57:43 -0400
Received: from mail-lf0-x232.google.com ([2a00:1450:4010:c07::232]:34158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vase@selfip.ru>) id 1cycRY-0005yl-Aq
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 06:57:40 -0400
Received: by mail-lf0-x232.google.com with SMTP id t144so27761542lff.1
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 03:57:39 -0700 (PDT)
MIME-Version: 1.0
Sender: vase@selfip.ru
From: Vasiliy Tolstov <v.tolstov@selfip.ru>
Date: Thu, 13 Apr 2017 13:57:17 +0300
Message-ID: <CACaajQtOS+=G4yHfymqFJiCZBtMfR=qUbfVi6n5quTRtffULjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] qemu and own disk driver writing questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi! If i want to develop some sort of qemu network block driver to own
storage. I can write qemu driver or tcmu / scst userspace driver and
attach to qemu block device (i'm use linux)
So in theory what path have minimal overhead in case of memory copy
and performance?
Where i can find some info how qemu works with data that needs to be
written or readed from block device passed to vm?
Thanks.

-- 
Vasiliy Tolstov,
e-mail: v.tolstov@selfip.ru
