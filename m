Received: from eggs.gnu.org ([2001:4830:134:3::10]:38440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eA2dV-0002C7-2g
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 19:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eA2dU-0005zf-4L
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 19:41:29 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:48577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eA2dT-0005z1-T6
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 19:41:28 -0400
Received: by mail-wr0-x244.google.com with SMTP id 15so3378329wrb.5
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 16:41:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fb931086-a889-7e76-5c1e-ec393d681044@linux.vnet.ibm.com>
References: <20171101193126.19730-1-danielhb@linux.vnet.ibm.com>
	<CAFEAcA9TD+imsuD+0zmZ5FGH7cVCw5+ZiKdPS1uBjqj=ujKiQw@mail.gmail.com>
	<fb931086-a889-7e76-5c1e-ec393d681044@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Nov 2017 23:41:06 +0000
Message-ID: <CAFEAcA_kwTC0B=CmanSPnjFXpgB2HgO_k5+iLQ+HcrsN9TRX8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] configure: do CC check before verifying
 host CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 1 November 2017 at 19:46, Daniel Henrique Barboza
<danielhb@linux.vnet.ibm.com> wrote:
> On 11/01/2017 05:41 PM, Peter Maydell wrote:
>> I think that currently we try to make "--help" work
>> even if you don't have a working C compiler. Does this
>> break that?
>
> Just checked, configure --help isn't broken with this change:

Did you test with gcc uninstalled again? It's hard to see
how it could work -- if the compile test fails we'll call
error_exit, which (as the name suggests) exits. Your patch
moves the compiler check from after we handle --help to
before it...

thanks
-- PMM
