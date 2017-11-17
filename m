Received: from eggs.gnu.org ([2001:4830:134:3::10]:36119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFnLq-0001AN-8E
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eFnLp-000424-8h
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:35:02 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eFnLp-00041E-1V
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 15:35:01 -0500
Received: by mail-wm0-x241.google.com with SMTP id b189so8628014wmd.5
	for <qemu-devel@nongnu.org>; Fri, 17 Nov 2017 12:35:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bf4bedd9-0ef8-cff3-6153-531fba597237@redhat.com>
References: <20171116115926.16627-1-pbonzini@redhat.com>
	<20171116115926.16627-8-pbonzini@redhat.com>
	<CAFEAcA-06-VmH7Pvymo-o-HmiQ-uQ67Hs0KhWZfxswBxsfD2-g@mail.gmail.com>
	<bf4bedd9-0ef8-cff3-6153-531fba597237@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Nov 2017 20:34:39 +0000
Message-ID: <CAFEAcA9Rnd3gtrHb389e6fOEAae4aLhJnQWU-vKyzTM4o-riOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 07/11] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On 17 November 2017 at 20:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 17/11/2017 21:07, Peter Maydell wrote:
>> Hi. This commit breaks booting of Debian on aarch64 virt board.
>> (repro instructions for creating the image available at:
>> https://translatedcode.wordpress.com/2017/07/24/installing-debian-on-qemus-64-bit-arm-virt-board/)
>> The guest kernel never prints anything to the serial port.
>>
>> Reverting this commit fixes master for me, so I plan to do
>> that on Monday.
>
> Maybe you can also test moving the atomic_set inside the "if".  It does
> seem to be a genuine bugfix.

No, that doesn't help: guest still sits there like a lemon.

thanks
-- PMM
