Received: from eggs.gnu.org ([2001:4830:134:3::10]:35141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g9xwt-0007ap-4A
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1g9xwq-0005Un-D0
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:45:43 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60197)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1g9xwq-0005TU-3v
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:45:40 -0400
References: <20181009184017.15675-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <fd52a068-17f8-5436-1d87-dfe40cd23fe9@vivier.eu>
Date: Tue, 9 Oct 2018 21:45:25 +0200
MIME-Version: 1.0
In-Reply-To: <20181009184017.15675-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user/sparc/signal.c: Remove
 unnecessary comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Riku Voipio <riku.voipio@iki.fi>

Le 09/10/2018 à 20:40, Peter Maydell a écrit :
> Remove a comment suggesting that we need to call tb_flush()
> after writing the SPARC signal frame trampoline insns.
> This isn't necessary in QEMU, because (even if the guest
> architecture requires explicit icache maintenance) we
> ensure that memory writes result in invalidation of
> translated code from that memory.

By curiosity, where/how is it done?

Thanks,
Laurent
