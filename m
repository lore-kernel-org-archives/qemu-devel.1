Received: from eggs.gnu.org ([2001:4830:134:3::10]:58995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUCaA-00042C-FD
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUCa9-0001wT-I6
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:16:50 -0500
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:34150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUCa9-0001vc-At
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:16:49 -0500
Received: by mail-vk0-x22f.google.com with SMTP id r136so28983614vke.1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 05:16:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a8396c69-3bd3-9297-3cd1-253aafa9b695@redhat.com>
References: <1484328738-21149-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAFEAcA-s4To6BCgFzUG6Bs_rpeVupatXpHm45b=26QmLJAwy8A@mail.gmail.com>
	<CAKv+Gu-hAzng0ff4=r2JZF5p=nEhhv12-kwg7wz+m7Uj4w42DA@mail.gmail.com>
	<CAFEAcA8n5grNz+z1ZcNcX9Er9s=uXRPgV-b1-3tkrzWEv-=1Uw@mail.gmail.com>
	<CAKv+Gu_+O-_x-CwQdiTf4efWAMue6LdXK3Afo9YW8Xz+6BFyzw@mail.gmail.com>
	<20170117094950.5dqdpbk6u7p4yhms@kamzik.brq.redhat.com>
	<CAFEAcA-Cdyq-dQ0U79TSsjJWQ2TO0R11RCWzAemSRS_1M65meg@mail.gmail.com>
	<20170118161819.7f5526af@nial.brq.redhat.com>
	<9dcc7f51-1763-e3bf-6879-7955d9ad23de@redhat.com>
	<CAKv+Gu9_dFpjwf16WxZQN5CE+7v5zzuff3rxg3EwRgrrYCy+xA@mail.gmail.com>
	<a8396c69-3bd3-9297-3cd1-253aafa9b695@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 13:16:28 +0000
Message-ID: <CAFEAcA908KZKijLqY3Q_g99LAu2MgTEJ3=9NRP_Kd6_NyGa64g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt-acpi - reserve ECAM space
 as PNP0C02 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 18 January 2017 at 17:26, Laszlo Ersek <lersek@redhat.com> wrote:
> In brief, for one data point, I'd be fine if we didn't tie this change
> to machine types.

We seem to have arrived at a consensus that we don't need
to version-constrain this change, so I'm applying Ard's
patch to target-arm.next.

thanks
-- PMM
