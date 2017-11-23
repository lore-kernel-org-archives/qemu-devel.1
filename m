Received: from eggs.gnu.org ([2001:4830:134:3::10]:46962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHust-0003Hw-S2
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:01:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHuss-0004p8-Pu
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:01:55 -0500
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:37673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHuss-0004nc-Hi
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 12:01:54 -0500
Received: by mail-ot0-x22b.google.com with SMTP id s4so16783441ote.4
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 09:01:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1bede1e5-cc11-dca6-9f0b-ef16b9031d7a@redhat.com>
References: <1511448975-28326-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8T4cShPYONdo8hiaZKvd+zq9Uo1o5awU3rA03uu8Vsiw@mail.gmail.com>
	<1bede1e5-cc11-dca6-9f0b-ef16b9031d7a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 17:01:32 +0000
Message-ID: <CAFEAcA_ZUGR+t2T3cvVo2OkyOccVjtRW+YTN-5KXaw+rFRiRqg@mail.gmail.com>
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
To: Auger Eric <eric.auger@redhat.com>
Cc: Wei Huang <wei@redhat.com>, Andrew Jones <drjones@redhat.com>, Vijay Kilari <vijay.kilari@gmail.com>, Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, wu.wubin@huawei.com, wanghaibin.wang@huawei.com, Christoffer Dall <christoffer.dall@linaro.org>, eric.auger.pro@gmail.com, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 23 November 2017 at 16:05, Auger Eric <eric.auger@redhat.com> wrote:
> When using update-linux-headers.sh I get suspicious errors at the end:
> grep: /tmp/tmp.A5NjLtHOij/include/asm/kvm_virtio.h: No such file or
> directory
> sed: can't read /tmp/tmp.A5NjLtHOij/include/asm/kvm_virtio.h: No such
> file or directory
>
> and include/standard-headers/asm-s390/virtio-ccw.h deleted
>
> I would prefer having s390 people checking and testing that.

I think the kvm_virtio.h problem should be fixed by
http://patchwork.ozlabs.org/patch/838230/
which removes it from the set of headers the script imports.

Cornelia/Christian -- any idea about the virtio-ccw.h issue ?

thanks
-- PMM
