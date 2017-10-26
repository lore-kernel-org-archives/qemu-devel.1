Received: from eggs.gnu.org ([2001:4830:134:3::10]:59449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7lE2-0005wZ-7a
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7lE1-0001VU-DY
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:41:46 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:57037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7lE1-0001V0-5a
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 12:41:45 -0400
Received: by mail-wr0-x241.google.com with SMTP id r79so3764342wrb.13
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 09:41:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHmME9qSJSPjANce_cWN6nm=qJsncfczgk7PoPa0xkOHmZjLUA@mail.gmail.com>
References: <20171023122719.17199-1-Jason@zx2c4.com>
	<CAFEAcA_PM5Fjx2Pk58h75p9vaZwFcusQdXuwy9tbDtc=EaoOJg@mail.gmail.com>
	<10e16ca3-175b-9f34-65e7-031b883b7201@amsat.org>
	<CAHmME9qtBiuAEnkCeuMd7EdeZveTVa4UOf+AQhMCFye0SYJY=Q@mail.gmail.com>
	<20171026133445.kemzfgvpbmtcogsl@kamzik.brq.redhat.com>
	<CAHmME9oyBvAV8FF9QMHyF46n8Ct6KZqThQVih2ipQmivD94Cag@mail.gmail.com>
	<CAFEAcA8O6YyS1tSzaydckFpsqpb8HXgW5PJe-VTWud_5YGdW5A@mail.gmail.com>
	<CAHmME9pE79krWx-zD=VGiScT4c=4TZ1wVxYFiF3m+8wsx9Fqeg@mail.gmail.com>
	<CAFEAcA9XoeXDCQCmRBehntWSo0WGRBsaMDmC8QCqgU1K8jAF_A@mail.gmail.com>
	<CAHmME9qSJSPjANce_cWN6nm=qJsncfczgk7PoPa0xkOHmZjLUA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2017 17:41:23 +0100
Message-ID: <CAFEAcA-bKPNwJpcny=1azScO8bzHsi0Ou+m3rYPq-=v52Gf26g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/arm/virt: support 4 serial
 ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Jones <drjones@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2017 at 17:36, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> On Thu, Oct 26, 2017 at 6:34 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> Reordering it would break existing users of the trustzone uart,
>> whose command lines would stop working.
>
> I thought this was the reason for all of those virt26, virt28,etc
> types -- people who want stability code the revision into their
> scripts. Everybody else then gets the latest.

Those are primarily about migration compatibility -- you should
be able to live migrate a guest from QEMU 2.6's virt-2.6 machine to
QEMU 2.7's virt-2.6 machine. That's a stricter requirement than
the compatibility we want to keep for non-versioned machines,
where generally we don't want to break command lines but are OK
to make changes if they don't break those existing uses.

Command lines get baked into all sorts of scripts and so they're
effectively part of QEMU's "ABI". People don't like it when we
break their previously working flows :-)

thanks
-- PMM
