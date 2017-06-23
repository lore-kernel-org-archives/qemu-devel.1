Received: from eggs.gnu.org ([2001:4830:134:3::10]:59921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dOPlO-0003lk-LA
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dOPlK-0006dr-Lp
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:40:46 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:34053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dOPlK-0006db-BV
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 10:40:42 -0400
Received: by mail-wr0-x231.google.com with SMTP id 77so68680614wrb.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 07:40:42 -0700 (PDT)
References: <CAGKXQydF6Y6xpfHGb3neVC-x72o+FEnvHBis87A3JbWRAmoGYA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAGKXQydF6Y6xpfHGb3neVC-x72o+FEnvHBis87A3JbWRAmoGYA@mail.gmail.com>
Date: Fri, 23 Jun 2017 15:41:26 +0100
Message-ID: <87tw36sr55.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] TARGET_PAGE_BITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ali saeedi <ali.saeedi56@gmail.com>
Cc: qemu-devel@nongnu.org


ali saeedi <ali.saeedi56@gmail.com> writes:

> Hello
> What does TARGET_PAGE_BITS mean in qemu code?

It's the page size of the target. e.g.

  TARGET_PAGE_BITS 12

  1 << 12 = 4096 = 4k pages


> thanks a lot


--
Alex Bennée
