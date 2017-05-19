Received: from eggs.gnu.org ([2001:4830:134:3::10]:55582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dBhyg-0007JC-GN
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dBhyd-0008Ev-FI
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:29:58 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dBhyd-0008Ei-85
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:29:55 -0400
Received: by mail-wr0-x236.google.com with SMTP id z52so17466775wrc.2
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:29:54 -0700 (PDT)
References: <591DC93D.2060707@ispras.ru>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <591DC93D.2060707@ispras.ru>
Date: Fri, 19 May 2017 14:29:53 +0100
Message-ID: <87vaox2cvi.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] EL2\EL3 support for Aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergey Smolov <smolov@ispras.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Sergey Smolov <smolov@ispras.ru> writes:

> Hello, List!
>
> Could you tell me, what is the current state for EL2\EL3 (Aarch64)?
> Whether they are fully supported, or not?
> Am I need to use any command line options to enable them for Aarch64
> assembler programs simulation?

Sure you can use both. To enable EL2 support:

  qemu-system-aarch64 ${QEMU_OPTS} \
    -machine gic-version=3 \
    -machine virtualization=true

To boot in secure mode you'll need to use -bios and boot a secure
firmware (like OPTEE for example).

>
> Thanks in advance!


--
Alex Bennée
