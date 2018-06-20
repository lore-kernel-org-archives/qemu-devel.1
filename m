Received: from eggs.gnu.org ([2001:4830:134:3::10]:38328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdkh-0005KG-1c
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:06:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVdkg-0004OC-4n
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:06:27 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34073)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVdkf-0004Np-VN
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:06:26 -0400
Received: by mail-oi0-x241.google.com with SMTP id i205-v6so3134313oib.1
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:06:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7fc96a3d-f1e2-7ab4-a46d-3d3482cc5e71@redhat.com>
References: <1529072910-16156-1-git-send-email-eric.auger@redhat.com>
	<1529072910-16156-2-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-wS9oy1JSgpwrCZie9GQaKLOf2wQxZOUtaLfw+HGP_GA@mail.gmail.com>
	<7fc96a3d-f1e2-7ab4-a46d-3d3482cc5e71@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 15:06:04 +0100
Message-ID: <CAFEAcA_s+LY-WS20HEi5xSkMRoA313To55kqeiX+GWW2qXq+XQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 01/11] linux-headers: Update to 4.18-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Christoffer Dall <christoffer.dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Laszlo Ersek <lersek@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>

On 20 June 2018 at 15:03, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
> On 06/20/2018 03:57 PM, Peter Maydell wrote:
>> On 15 June 2018 at 15:28, Eric Auger <eric.auger@redhat.com> wrote:
>>> commit b357bf6023a948cf6a9472f07a1b0caac0e4f8e8
>>> Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> What's 4.18-rc0? The upstream kernel doesn't have a tag by that
>> name and looking at the Makefile the last thing before 4.18-rc1
>> was 4.17.
>>
>> Still, since it is a commit on mainline I guess we're fine?
> Yes it is post 4.17 and before 4.18-rc1. I didn't know how to call that.

I've tweaked the commit message to read:
> linux-headers: Update to kernel mainline commit b357bf602
>
> Update our kernel headers to mainline commit
> b357bf6023a948cf6a9472f07a1b0caac0e4f8e8
> ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")

thanks
-- PMM
