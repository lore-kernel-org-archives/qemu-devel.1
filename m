Received: from eggs.gnu.org ([2001:4830:134:3::10]:32932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6twj-0005H4-Qn
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6twf-000846-Q3
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:52:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:39097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g6twf-000832-Ih
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:52:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id q8-v6so7851463wmq.4
	for <qemu-devel@nongnu.org>; Mon, 01 Oct 2018 01:52:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <CAFEAcA_gCh-uSbMMbtbH9DsOLgzHhUgMABBSnLOYy7avW7DXxg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a5cba9d8-1004-626e-b9c3-5e975f07ca54@amsat.org>
Date: Mon, 1 Oct 2018 10:52:46 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_gCh-uSbMMbtbH9DsOLgzHhUgMABBSnLOYy7avW7DXxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] finishing the transition away from SysBus init
 methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9/27/18 10:11 AM, Peter Maydell wrote:
> I had a look at how many devices are still using the SysBus init
> method (rather than the instance-init/realize pair), and it turns out
> to be only 41, which I think is reasonably tractable for doing some
> more conversions and completing this API transation.

Next would be convert qemu_register_reset() calls from hw/ to use
DeviceClass::reset().
