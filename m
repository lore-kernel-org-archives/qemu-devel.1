Received: from eggs.gnu.org ([2001:4830:134:3::10]:51836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEDgF-0001H3-BD
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEDgD-0006o0-86
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:49:51 -0400
Received: from mail-oi0-x22e.google.com ([2607:f8b0:4003:c06::22e]:37658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEDgD-0006nW-2k
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:49:49 -0400
Received: by mail-oi0-x22e.google.com with SMTP id w123-v6so6960540oia.4
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 05:49:48 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 13:49:27 +0100
Message-ID: <CAFEAcA87nQZLG493hSPb__zwKHVMsSNaS_qhY2EPghzTvJ9fwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] does a device model need to call
 qemu_chr_fe_accept_input() in its reset method?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

Hi; I noticed that one of our UART models, hw/char/cadence_uart.c,
calls qemu_chr_fe_accept_input() in its reset method. This sort
of makes sense, since device reset is a state transition from
"I'm in a state where I've previously said I can't accept input"
to "I'm in a state where I can accept input". However, it looks
like none of the other UARTs do this.

Is this a bug in our other UARTs, or does the chardev framework
guarantee to forget about 'nope' responses from the fd_can_read
callback on system reset?

thanks
-- PMM
