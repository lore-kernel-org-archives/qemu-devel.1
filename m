Received: from eggs.gnu.org ([2001:4830:134:3::10]:40365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHtHn-0005JQ-4n
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHtHm-0004SM-1V
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:19:31 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHtHl-0004Rb-ST
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:19:29 -0500
Received: by mail-oi0-x242.google.com with SMTP id l138so13354040oib.7
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 07:19:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511448975-28326-1-git-send-email-eric.auger@redhat.com>
References: <1511448975-28326-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 15:19:08 +0000
Message-ID: <CAFEAcA8T4cShPYONdo8hiaZKvd+zq9Uo1o5awU3rA03uu8Vsiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v3 0/4] vITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com

On 23 November 2017 at 14:56, Eric Auger <eric.auger@redhat.com> wrote:
> At the moment the ITS is not properly reset. On System reset or
> reboot, previous ITS register values and caches are left
> unchanged. Some of the registers might point to some guest RAM
> tables which are not valid anymore. This leads to state
> inconsistencies that are detected by the kernel save/restore
> code. And eventually this may cause qemu abort.
>
> This series adds vITS reset modality:
> - the 2 first patches bring a minimalist reset through individual
>   register writes. However, with kernel versions < 4.15, this reset
>   is not complete (vITS caches are not voided).
> - With kernel versions >= 4.15 we can rely on a new ITS KVM device
>   reset IOTCL. The last 2 patches introduce the full reset.
>
> Patches 1-2 have all kernel dependencies resolved.
> Patches 3-4' dependencies were pulled for v4.15-rc0 but as the tag is
> not set, the kernel header update still is partial.

We don't need the change to be tagged for us to sync with the
kernel headers: if it's in mainline that's good enough.

thanks
-- PMM
