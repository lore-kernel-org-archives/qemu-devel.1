Received: from eggs.gnu.org ([2001:4830:134:3::10]:40571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJiMc-0002LO-91
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:04:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJiMb-0006R0-Eo
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:04:02 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:43388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJiMb-0006Qh-8b
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:04:01 -0500
Received: by mail-oi0-x22a.google.com with SMTP id f69so222405oig.10
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 08:04:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511883692-11511-3-git-send-email-eric.auger@redhat.com>
References: <1511883692-11511-1-git-send-email-eric.auger@redhat.com>
	<1511883692-11511-3-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 16:03:39 +0000
Message-ID: <CAFEAcA9Tj_y2FzDktjPpP3OGQTYmsy8LD7MhxaXxORx1Y_oGcg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 2/4] hw/intc/arm_gicv3_its: Implement a
 minimalist reset
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

On 28 November 2017 at 15:41, Eric Auger <eric.auger@redhat.com> wrote:
> At the moment the ITS is not properly reset and this causes
> various bugs on save/restore. We implement a minimalist reset
> through individual register writes but for kernel versions
> before v4.15 this fails voiding the vITS cache. We cannot
> claim we have a comprehensive reset (hence the error message)
> but that's better than nothing.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
