Received: from eggs.gnu.org ([2001:4830:134:3::10]:60574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff41m-00081K-G4
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:59:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ff41l-0005Im-O5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:59:02 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:34339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ff41l-0005Ic-Hp
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 09:59:01 -0400
Received: by mail-oi0-x244.google.com with SMTP id 13-v6so74947027ois.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 06:59:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7ea6a810-1216-b45d-3c25-9d843769b051@redhat.com>
References: <1531415537-26037-1-git-send-email-thuth@redhat.com>
	<CAFEAcA9_TrSTrcHBGS1mAd0-w2VSQ0AP3z=EPM_U3dTF3k_R1w@mail.gmail.com>
	<7ea6a810-1216-b45d-3c25-9d843769b051@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 14:58:40 +0100
Message-ID: <CAFEAcA9pOeqbPNOMUHNtv=H=hUwpDWC4Ohx-aHJy=_P=s9cbCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm2836: Mark the bcm2836 / bcm2837
 devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 16 July 2018 at 14:44, Thomas Huth <thuth@redhat.com> wrote:
> On 16.07.2018 15:39, Peter Maydell wrote:
>> On 12 July 2018 at 18:12, Thomas Huth <thuth@redhat.com> wrote:
>>> These devices are currently causing some problems when a user is trying
>>> to hot-plug or introspect them during runtime. Since these devices can
>>> not be instantiated by the user at all (they need to be wired up in code
>>> instead), we should mark them with user_creatable = false anyway, then we
>>> avoid at least the crashes with the hot-plugging. The introspection problem
>>> will be handled by a separate patch.
>>
>> I thought we'd changed things so all sysbus devices defaulted
>> to not-user-createable? Am I confusing that with something else?
>> (The set of user-creatable sysbus devices must be very small...)
>
> You remember it right, but TYPE_BCM283X is not a sysbus device, it is
> declared with ".parent = TYPE_DEVICE" instead.

So it is. (Which sort of makes sense I suppose, though we're not
entirely consistent about whether SoC containers are sysbus or
plain device.)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

and I'll apply this to target-arm.next for 3.0.

thanks
-- PMM
