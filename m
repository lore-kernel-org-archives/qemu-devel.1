Received: from eggs.gnu.org ([2001:4830:134:3::10]:44432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgACh-0004To-Hh
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fgACg-0001Dz-Fj
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:46:51 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:52697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fgACg-0001DL-2F
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 10:46:50 -0400
Received: by mail-it0-x241.google.com with SMTP id p4-v6so10086887itf.2
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 07:46:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1532010203-21331-1-git-send-email-thuth@redhat.com>
References: <1532010203-21331-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jul 2018 15:46:28 +0100
Message-ID: <CAFEAcA8vgqsZPCLsKCYzJCT+PXeKM-Pb9hcEDwNd4-R0vgT3tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/timer/mc146818rtc: Fix introspection
 problem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 19 July 2018 at 15:23, Thomas Huth <thuth@redhat.com> wrote:
> There is currently a funny problem with the "mc146818rtc" device:
> 1) Start QEMU like this:
>    qemu-system-ppc64 -M pseries -S
> 2) At the HMP monitor, enter "info qom-tree". Note that there is an
>    entry for "/rtc (spapr-rtc)".
> 3) Introspect the mc146818rtc device like this:
>    device_add mc146818rtc,help
> 4) Run "info qom-tree" again. The "/rtc" entry is gone now!
>
> The rtc_finalize() function of the mc146818rtc device has two bugs: First,
> it tries to remove a "rtc" property, while the rtc_realizefn() added a
> "rtc-time" property instead. And second, it should be done in an unrealize
> function, not in a finalize function, to avoid that this causes problems
> during introspection.

A device that adds a property to a machine is pretty weird...

thanks
-- PMM
