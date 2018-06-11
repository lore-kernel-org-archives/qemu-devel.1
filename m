Received: from eggs.gnu.org ([2001:4830:134:3::10]:35769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSMZS-0006G4-8O
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:09:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSMZR-00043n-4B
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:09:18 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:37361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSMZQ-00043P-Va
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:09:17 -0400
Received: by mail-ot0-x242.google.com with SMTP id 101-v6so23661118oth.4
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:09:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5B1E33A4.7070509@huawei.com>
References: <1527736557-11084-1-git-send-email-zhaoshenglong@huawei.com>
	<1527736557-11084-2-git-send-email-zhaoshenglong@huawei.com>
	<e7bb1cbd-7fad-5bd2-641c-885f0f473680@redhat.com>
	<5B1E33A4.7070509@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 14:08:56 +0100
Message-ID: <CAFEAcA_ZuWkEi1e4G8Kaaw4K0ROTwJnBtghCHsMaTJ3LRXJbDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 1/2] arm_gicv3_kvm:
 kvm_dist_get/put_priority: skip the registers banked by GICR_IPRIORITYR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Auger Eric <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-stable <qemu-stable@nongnu.org>

On 11 June 2018 at 09:32, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> Hi Peter,
>
> Looks like we missed picking up this patch. I didn't include this in v6
> since you and Eric both reviewed it.
>
> Could you please pick it up?

Oops; added to target-arm.next. (I generally forget entirely about vN
of a patchset as soon as vN+1 appears on the list, so better not to
drop patches from a set unless I've specifically said I've put
them in target-arm.next or they're on the list as their own patchset.)

thanks
-- PMM
