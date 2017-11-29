Received: from eggs.gnu.org ([2001:4830:134:3::10]:38850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eK3WU-0000Vb-7D
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eK3WT-0000Mt-FF
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:39:38 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:43509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eK3WT-0000Mi-9n
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:39:37 -0500
Received: by mail-oi0-x235.google.com with SMTP id f69so2504559oig.10
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 06:39:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511883692-11511-1-git-send-email-eric.auger@redhat.com>
References: <1511883692-11511-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Nov 2017 14:39:16 +0000
Message-ID: <CAFEAcA-Mr548a7uu5-hxHMOEC9OenTPMRX35fxG_vYZtw2naqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/4] vITS Reset
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
> Tested with 4.11, 4.14 and 4.15 host kernels.

Applied v6 to target-arm.next for 2.12; thanks.

-- PMM
