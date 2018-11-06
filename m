Received: from eggs.gnu.org ([2001:4830:134:3::10]:33023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK7JJ-0002AR-Ru
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK7JJ-00056n-3Q
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:46:49 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:33214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK7JI-0004qa-16
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:46:48 -0500
Received: by mail-wm1-x330.google.com with SMTP id f19-v6so9746970wmb.0
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 11:46:40 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
Date: Tue, 6 Nov 2018 20:46:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 06/11/2018 19:43, Peter Maydell wrote:
> hw/core/ptimer.c

Not a device.

> hw/i2c/bitbang_i2c.c

TYPE_GPIO_I2C?

> hw/ide/ahci.c

Even though AHCIState is not a QOM object, all of its users are
(TYPE_SYSBUS_AHCI is in this file, TYPE_ICH9_AHCI is in hw/ide/ich.c).

Paolo
