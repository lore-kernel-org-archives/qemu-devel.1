Received: from eggs.gnu.org ([2001:4830:134:3::10]:56039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roy@probir.info>) id 1favdP-0008LZ-3A
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 00:12:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roy@probir.info>) id 1favdM-0003NT-0C
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 00:12:47 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:46893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roy@probir.info>) id 1favdL-0003Mh-Qv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 00:12:43 -0400
Received: by mail-oi0-x236.google.com with SMTP id y207-v6so14213254oie.13
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 21:12:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <edee4a56-e75e-f3cb-8423-2f891be1ff3f@oracle.com>
References: <CA++5wji+jjiTcBT+Uhd4VL2U70vmRFnvacbRqhnxWX3M=f7svA@mail.gmail.com>
	<edee4a56-e75e-f3cb-8423-2f891be1ff3f@oracle.com>
From: Probir Roy <roy@probir.info>
Date: Thu, 5 Jul 2018 00:12:42 -0400
Message-ID: <CA++5wjjCMY0Si0HWw4Y5DEswOsQ5MnaoE_6y2xUXcG=y-9FwBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-discuss] IRQ per CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-discuss@nongnu.org, qemu-devel@nongnu.org

> Does 'per CPU basis' indicates irq per cpu, or irq per device queue?

IRQ per CPU core, meaning that IRQ will be raised at and served by
that CPU. Does IRQ per queue mean the same thing?
