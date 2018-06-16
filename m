Received: from eggs.gnu.org ([2001:4830:134:3::10]:39128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kimrhh@gmail.com>) id 1fU6tD-0004bd-QX
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 04:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kimrhh@gmail.com>) id 1fU6tA-0000jf-PK
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 04:48:55 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:38404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kimrhh@gmail.com>) id 1fU6tA-0000i8-KS
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 04:48:52 -0400
Received: by mail-ua0-f170.google.com with SMTP id 59-v6so7912696uas.5
	for <qemu-devel@nongnu.org>; Sat, 16 Jun 2018 01:48:52 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Kim_H=C3=B8jgaard=2DHansen?= <kimrhh@exherbo.org>
Date: Sat, 16 Jun 2018 10:48:39 +0200
Message-ID: <CAGCfF7UjhWK-vJ75am+CncWTTesnwf2WyU9YrMVG+k=d7FtGfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Kernel requirement for membarriers feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

When the membarriers feature was introduced, the kernel requirement was set
to 4.14, however if my understanding of what is needed is correct that is
rather strict?

http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg02748.html

As far as i can tell the feature was introduced in 4.3 see:
https://elixir.bootlin.com/linux/v4.3.6/ident/MEMBARRIER_CMD_SHARED

If I patch out that requirement Qemu also seems to run just fine, with SMP
enabled (should hit the runtime check?) on a 4.9 LTS kernel.

Can someone provide insights into why the requirement is set to 4.14?

Br,
Kim
