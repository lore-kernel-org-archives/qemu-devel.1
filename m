Received: from eggs.gnu.org ([2001:4830:134:3::10]:51173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2c4X-0003qD-M9
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2c4W-0007ri-7r
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:54:41 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:56199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2c4V-0007rM-Ug
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 07:54:40 -0400
Received: by mail-wm0-x231.google.com with SMTP id u138so12692380wmu.4
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 04:54:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506524205-20763-2-git-send-email-eric.auger@redhat.com>
References: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
	<1506524205-20763-2-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 12:54:18 +0100
Message-ID: <CAFEAcA9P51hn60vYErotTBc9m4REq=fgfp0ZN18mFtoLLbS9ZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 1/3] hw/intc/arm_gicv3_its: Don't abort on
 table save/restore
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

On 27 September 2017 at 15:56, Eric Auger <eric.auger@redhat.com> wrote:
> The ITS is not properly reset at the moment. It is possible the
> GITS_BASER<n>.valid is set and the in-kernel ITS caches are not
> empty (list of devices, collections, LPIs) while data structures
> in guest RAM are invalid/inconsistent.
>
> For instance, this happens after a guest shutdown -r now or a
> system reset, if we save the state before the guest re-writes
> the ITS registers or map devices, the table save ioctl may
> produce a QEMU abort.
>
> Until there is a proper reset implemented, let's unplug the
> consistency error checking.
>
> The reset issue will be fixed in subsequent patches.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: wanghaibin <wanghaibin.wang@huawei.com>

When in particular does this cause an abort -- when we're
trying to save the state in these edge cases, or when we're
trying to restore it? What does the kernel do -- is it just
rejecting the attempt, or might it actually have done bad
things to guest memory ?

thanks
-- PMM
