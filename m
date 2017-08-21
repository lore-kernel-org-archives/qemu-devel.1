Received: from eggs.gnu.org ([2001:4830:134:3::10]:49556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1djnA5-00014c-Mg
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1djnA4-0000QJ-Rx
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:54:37 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1djnA4-0000PX-LW
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:54:36 -0400
Received: by mail-wr0-x22a.google.com with SMTP id f8so63710354wrf.3
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 06:54:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503316706.26016.11.camel@redhat.com>
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
	<CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
	<be880655-0c04-8369-01fc-76dd6241ca78@redhat.com>
	<1503316706.26016.11.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2017 14:54:14 +0100
Message-ID: <CAFEAcA9Lz=pBZxYqHk7kdaU_LsvE34+DJmTm_jHSFeKzoCM3xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 21 August 2017 at 12:58, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Related question (as the edk2 blobs are pretty big):  Do we want commit
> this to the qemu repo directly?   Or should we create a qemu-firmware
> repo for the precompiled blobs and hook it up as submodule?

Having all our precompiled blobs be in a submodule would
maybe be handy for properly keeping them separate from the
QEMU code -- would that be useful for downstream distro
packagers?

In any case this seems like a good opportunity to write down
exactly what our policy about ROM blobs is (eg where they
are, how we update them, requirement for source, whether
we allow source to be in a submodule not on qemu.org...)

thanks
-- PMM
