Received: from eggs.gnu.org ([2001:4830:134:3::10]:53694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lindsay.mathieson@gmail.com>) id 1f3CAy-0008Bh-7s
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lindsay.mathieson@gmail.com>) id 1f3CAx-0006Nf-GE
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 23:00:00 -0400
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235]:45585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lindsay.mathieson@gmail.com>)
	id 1f3CAx-0006Mw-Bz
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:59:59 -0400
Received: by mail-qt0-x235.google.com with SMTP id f8so17711117qtg.12
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 19:59:59 -0700 (PDT)
MIME-Version: 1.0
From: Lindsay Mathieson <lindsay.mathieson@gmail.com>
Date: Tue, 3 Apr 2018 12:59:57 +1000
Message-ID: <CAEMkAmGoPm8p0MKumctDPodaD4PCUYi4X=ovs+kMO9xTKGkLeQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Loadable block drivers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi all, was looking at developing a block driver for qemu - have examined
the drivers at:

  https://github.com/qemu/qemu/tree/master/block

And it seems straightforward enough.

One thing that is unclear - all the drivers appear to be compiled directly
into qemu. Is there no way to load them dynamically as .so modules?

Thanks,

-- 
Lindsay
