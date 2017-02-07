Received: from eggs.gnu.org ([2001:4830:134:3::10]:49211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb3jc-00085h-Ua
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb3jc-0002n6-8A
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:14:56 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:36290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb3jc-0002mP-2A
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 06:14:56 -0500
Received: by mail-wm0-x231.google.com with SMTP id c85so156025187wmi.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 03:14:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7c016bdc97ed45dc2eb5002db98efcee26c4d8bf.1486437689.git.sam.bobroff@au1.ibm.com>
References: <7c016bdc97ed45dc2eb5002db98efcee26c4d8bf.1486437689.git.sam.bobroff@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 11:14:32 +0000
Message-ID: <CAFEAcA9yV=O=qj9iRcWs1GECL5rY6S=qfq2pxwHrfgD5MDj2eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/1] target-ppc,
 tcg: fix usermode segfault with pthread_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <laurent@vivier.eu>, =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>, QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2017 at 03:21, Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
> Programs run under qemu-ppc64 on an x86_64 host currently segfault
> if they use pthread_create() due to the adjustment made to the NIP in
> commit bd6fefe71cec5a0c7d2be4ac96307f25db56abf9.
>
> This patch changes cpu_loop() to set the NIP back to the
> pre-incremented value before calling do_syscall(), which causes the
> correct address to be used for the new thread and corrects the fault.
>
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
