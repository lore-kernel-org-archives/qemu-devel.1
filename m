Received: from eggs.gnu.org ([2001:4830:134:3::10]:40259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f81qT-0004We-Ni
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:58:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f81qS-0008Dr-WD
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:58:49 -0400
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:43030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f81qS-0008DJ-R6
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:58:48 -0400
Received: by mail-ot0-x22a.google.com with SMTP id d9-v6so16845500oth.10
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 03:58:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416091941.7n24dd3qjyuqh4h6@kamzik.brq.redhat.com>
References: <1522160122-10744-1-git-send-email-eric.auger@redhat.com>
	<1522160122-10744-9-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_O3QK0t5DHfnAFEOHv_yyxvL9HZX+0geHs0ibVVwTbNQ@mail.gmail.com>
	<57b01152-1179-9735-eb6a-a9dbfc933a6c@redhat.com>
	<CAFEAcA-wT8vERbkjq_HoROi1ymPauAe+y3oc16zoCJXsHKqBoQ@mail.gmail.com>
	<94299045-3027-517c-d634-4613f78de163@redhat.com>
	<20180416091941.7n24dd3qjyuqh4h6@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 11:58:27 +0100
Message-ID: <CAFEAcA9dVuki+ZL7d6_LecZX03hrW3PxOdcpUZ8WkcDwKw1-cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 8/8] hw/arm/virt: Allow up to 512 vcpus along
 with KVM VGICv3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Wei Huang <wei@redhat.com>, Christoffer Dall <cdall@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Eric Auger <eric.auger.pro@gmail.com>

On 16 April 2018 at 10:19, Andrew Jones <drjones@redhat.com> wrote:
> This is the cleaner choice, but I wasn't opposed to the max-vcpus
> query getting double-duty though. While the backporting argument is
> a good point, I'm not sure we've ever really cared about what
> issues backporters have had to endure when they cherry-pick features
> before.

Well, mostly I didn't like the entangling of two different
features, so we look for the presence of one by checking
for the other. That's confusing going forward as well as
awkward for backporting. Plus if we have a difficulty with
detection of new kernel features like this we're probably going
to run into it again in the future, so we might as well sort
it out now...

thanks
-- PMM
