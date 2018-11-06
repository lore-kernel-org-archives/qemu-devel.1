Received: from eggs.gnu.org ([2001:4830:134:3::10]:40380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gK7dE-0003NN-VH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 15:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1gK7OS-0001kn-Rb
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:52:09 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:33914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1gK7OQ-0001BV-PU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 14:52:08 -0500
Received: by mail-lj1-x230.google.com with SMTP id u6-v6so12625598ljd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 11:51:56 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
In-Reply-To: <f5712b07-05a1-650c-332a-a24462fed977@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Nov 2018 11:51:26 -0800
Message-ID: <CAKmqyKPWgwoswZZrazkQXLqdYk6konvN1fNMS8ss87U63M_EXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Tue, Nov 6, 2018 at 11:47 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 06/11/2018 19:43, Peter Maydell wrote:
> > hw/core/ptimer.c
>
> Not a device.
>
> > hw/i2c/bitbang_i2c.c
>
> TYPE_GPIO_I2C?
>
> > hw/ide/ahci.c
>
> Even though AHCIState is not a QOM object, all of its users are
> (TYPE_SYSBUS_AHCI is in this file, TYPE_ICH9_AHCI is in hw/ide/ich.c).

Should this list go on the wiki somewhere? Then we can cross off ones
as they are converted.

Alistair

>
> Paolo
>
