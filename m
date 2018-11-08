Received: from eggs.gnu.org ([2001:4830:134:3::10]:41516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKkhY-0005qd-5X
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKkhX-000702-7G
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:50:28 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKkhV-0006x3-DE
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 08:50:27 -0500
Received: by mail-oi1-x241.google.com with SMTP id x204-v6so1474542oia.0
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 05:50:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181107092721.6c01f09e@w520.home>
References: <20181106184212.29377-1-eric.auger@redhat.com>
	<20181107092721.6c01f09e@w520.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 13:49:55 +0000
Message-ID: <CAFEAcA_da2B6xQOF8CdZPvNb2WiBOdiUAZ+3h5-=ntNRL0EDLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 for-3.1] hw/arm/sysbus-fdt: Only call
 match_fn callback if the type matches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 7 November 2018 at 16:27, Alex Williamson <alex.williamson@redhat.com> wrote:
> On Tue,  6 Nov 2018 19:42:12 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Commit af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with DT
>> compatible value) introduced a match_fn callback which gets called
>> for each registered combo to check whether a sysbus device can be
>> dynamically instantiated. However the callback gets called even if
>> the device type does not match the binding combo typename field.
>> This causes an assert when passing "-device ramfb" to the qemu
>> command line as vfio_platform_match() gets called on a non
>> vfio-platform device.
>>
>> To fix this regression, let's change the add_fdt_node() logic so
>> that we first check the type and if the match_fn callback is defined,
>> then we also call it.
>>
>> Binding combos only requesting a type check do not define the
>> match_fn callback.
>>
>> Fixes: af7d64ede0b9 (hw/arm/sysbus-fdt: Allow device matching with
>> DT compatible value)
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>
> The commit this fixes went through the vfio tree, but since the fix
> itself only lives in arm code, I'll leave it to arm maintainers to
> shepherd this fix and offer:
>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

Applied to target-arm.next, thanks.

-- PMM
