Received: from eggs.gnu.org ([2001:4830:134:3::10]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZKEq-0003kx-RK
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZKEq-00075l-2E
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:28:00 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:34767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZKEp-00075P-U8
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 11:27:59 -0500
Received: by mail-ua0-x236.google.com with SMTP id 35so15085058uak.1
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 08:27:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8ACTcbJOdXnkfM=okG_WCOuqdF6MPv4jxCTq-4y_4e3Q@mail.gmail.com>
References: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
	<128aeca5-099c-e82b-5cc7-314c899231de@redhat.com>
	<CAKv+Gu8ACTcbJOdXnkfM=okG_WCOuqdF6MPv4jxCTq-4y_4e3Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Feb 2017 16:27:39 +0000
Message-ID: <CAFEAcA9OVuT-w177UdcyNJRKOMs5Rb8tT18m1zWgg=+7z=oihA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] KVM/QEMU on Raspberry Pi 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Pekka Enberg <penberg@iki.fi>, KVM devel mailing list <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2 February 2017 at 15:52, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> How is this supposed to work? RPI3 does not have a GIC at all, but a
> proprietary interrupt controller that is not supported by KVM

The idea is that (with the relevant not-yet-in-master patchsets)
you can fall back to "use a userspace interrupt controller model".
The performance will probably not be great.

thanks
-- PMM
