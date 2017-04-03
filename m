Received: from eggs.gnu.org ([2001:4830:134:3::10]:38813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv2Bp-0001RS-VS
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:38:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv2Bp-0001w4-4t
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:38:38 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv2Bo-0001vF-Un
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 09:38:37 -0400
Received: by mail-wm0-x229.google.com with SMTP id y22so25952199wmh.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 06:38:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403133416.GB1910@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
	<CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
	<20170403133416.GB1910@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 14:38:15 +0100
Message-ID: <CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC 13/19] unimplemented-device: Remove
 user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 3 April 2017 at 14:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> Wouldn't it be better to just not add that, rather than
>> add it and then delete it?
>
> The device was already user-creatable

It doesn't seem to be:

 ./build/x86/arm-softmmu/qemu-system-arm -M virt -device
unimplemented-device,size=1024,name=foo
qemu-system-arm: Device unimplemented-device can not be dynamically instantiated

thanks
-- PMM
