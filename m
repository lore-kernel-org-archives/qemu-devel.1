Received: from eggs.gnu.org ([2001:4830:134:3::10]:46144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv2ek-0002GS-15
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cv2ei-000682-Vo
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:08:29 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cv2ei-00067m-O0
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:08:28 -0400
Received: by mail-wr0-x231.google.com with SMTP id w43so170650025wrb.0
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 07:08:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170403135445.GD1910@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-14-ehabkost@redhat.com>
	<CAFEAcA9bRwneynDYg6Lgowe21=rh8+miSZhqzmW81VLWrxafhQ@mail.gmail.com>
	<20170403133416.GB1910@thinpad.lan.raisama.net>
	<CAFEAcA-9r=Qktj1Oa6kvCPQrQ4XpPcxb2L4xNcPSfHeB9Ogt6A@mail.gmail.com>
	<20170403135445.GD1910@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Apr 2017 15:08:06 +0100
Message-ID: <CAFEAcA-+imjX_kfxPo6Vue-bX8HZo8ZV8s7XmyTNj7_GTd4Lrg@mail.gmail.com>
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

On 3 April 2017 at 14:54, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Mon, Apr 03, 2017 at 02:38:15PM +0100, Peter Maydell wrote:
>> On 3 April 2017 at 14:34, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> >> Wouldn't it be better to just not add that, rather than
>> >> add it and then delete it?
>> >
>> > The device was already user-creatable
>>
>> It doesn't seem to be:
>>
>>  ./build/x86/arm-softmmu/qemu-system-arm -M virt -device
>> unimplemented-device,size=1024,name=foo
>> qemu-system-arm: Device unimplemented-device can not be dynamically instantiated
>
> This restriction is implemented by the "virt" machine, not by the
> device type itself.
>
> This, on the other hand, currently works:
>   $ qemu-system-x86_64 -M q35 -device unimplemented-device,size=1024,name=foo

That's a bug in the q35 machine or the handling of -device
on non-platform-bus systems, though, isn't it? The default
for all sysbus devices has always been "you can't use
-device with this", there's never been a requirement to
mark them as such separately (because it would require
touching the files for a huge number of devices for no
particularly good reason when you can default the whole
set of devices subclassing SysBusDevice).

thanks
-- PMM
