Received: from eggs.gnu.org ([2001:4830:134:3::10]:35440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1ftxwo-00072h-LF
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 12:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1ftxwn-0002c2-Kz
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 12:31:30 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:37038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <chrisfriedt@gmail.com>)
	id 1ftxwn-0002b3-BR
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 12:31:29 -0400
Received: by mail-oi0-x22e.google.com with SMTP id p84-v6so23330309oic.4
	for <qemu-devel@nongnu.org>; Sun, 26 Aug 2018 09:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-R8iAkeHXFPHazY2Tmr+Yh=WrG4yKx=LVm7rRLBnxKseA@mail.gmail.com>
	<CAFEAcA_y2-N_aaG4W4rQABsTe=B++pSMp53_kKay0_MjGT4WpA@mail.gmail.com>
	<CAF4BF-RzCr_hx6iAPR3pQ_eAChue38eTE646EOou6XE6FkNSVQ@mail.gmail.com>
	<CAF4BF-Tb74eNHuNMXNXJZAXq4UQ=mG3BOd4Dnswe+WY89q1Miw@mail.gmail.com>
	<CAF4BF-RcXN8OQxc8vEu=mAucNOUe8MDC95toQ6NXnYbopsqREA@mail.gmail.com>
In-Reply-To: <CAF4BF-RcXN8OQxc8vEu=mAucNOUe8MDC95toQ6NXnYbopsqREA@mail.gmail.com>
From: Christopher Friedt <chrisfriedt@gmail.com>
Date: Sun, 26 Aug 2018 12:31:16 -0400
Message-ID: <CAF4BF-S1b69ErGdmA4AOkAQJapPby-uv7z4tUscqqdOXgvJqJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix ARM v7m gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

In the end it was just incorrect alignment for my vector table
