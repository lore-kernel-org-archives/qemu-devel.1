Received: from eggs.gnu.org ([2001:4830:134:3::10]:43941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fddpn-0000Qr-BV
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fddpm-0005mq-F7
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:48:47 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fddpm-0005mM-7g
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:48:46 -0400
Received: by mail-oi0-x241.google.com with SMTP id v8-v6so56670565oie.5
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 08:48:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531409463-3843-1-git-send-email-thuth@redhat.com>
References: <1531409463-3843-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 16:48:24 +0100
Message-ID: <CAFEAcA_PehgESP845QOiVOO2Ov1wd2r0MLLtN17wsRVwB-wgHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 0/5] Fix crashes with introspection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 12 July 2018 at 16:30, Thomas Huth <thuth@redhat.com> wrote:
> As discovered recently, you can crash QEMU with a lot of devices
> that do not get the reference counting of child objects right.
> You just have to run 'device-list-properties' and call 'info qtree'
> afterwards.
> This patch series fixes a bunch of these problems in the ARM code.
> I did not fix all problems yet, since it is quite time consuming
> and I first want to get some feedback whether this is the right
> way to go or not.
>
> Thomas Huth (5):
>   qom/object: Add a new function object_initialize_as_child()
>   hw/core/sysbus: Add a function for creating and attaching an object
>   hw/arm/bcm2836: Fix crash with device_add bcm2837 on unsupported
>     machines
>   hw/arm/armv7: Fix crash when introspecting the "iotkit" device
>   hw/cpu/a15mpcore: Fix introspection problem with the a15mpcore_priv
>     device

Seems good to me. I'm cc'ing Igor since he had some opinions when
I sent a previous (and rather more ad-hoc) attempt at reducing
the boilerplate around creating and parenting sysbus objects:
http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04493.html

thanks
-- PMM
