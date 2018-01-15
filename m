Received: from eggs.gnu.org ([2001:4830:134:3::10]:52478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb3RW-0005I8-Ix
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:00:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb3RS-0000II-V6
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:00:46 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40794)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb3RS-0000Hx-Q8
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:00:42 -0500
Received: by mail-ot0-x241.google.com with SMTP id d10so10418696oti.7
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 04:00:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212143922.cl7wyhupqdopqcdj@kamzik.brq.redhat.com>
References: <1512745328-5109-1-git-send-email-peter.maydell@linaro.org>
	<1512745328-5109-2-git-send-email-peter.maydell@linaro.org>
	<20171212143922.cl7wyhupqdopqcdj@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 12:00:21 +0000
Message-ID: <CAFEAcA_SyTvkvrzi1c=wuO9O=e4nocnzw-wnuvr0TRZQkmnkaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/virt: Add virt-2.12 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Shannon Zhao <shannon.zhao@linaro.org>

On 12 December 2017 at 14:39, Andrew Jones <drjones@redhat.com> wrote:
> On Fri, Dec 08, 2017 at 03:02:06PM +0000, Peter Maydell wrote:
>> Add virt-2.12 machine type.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  include/hw/compat.h |  3 +++
>>  hw/arm/virt.c       | 19 +++++++++++++++++--
>>  2 files changed, 20 insertions(+), 2 deletions(-)
>
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks. The rest of this series has issues but I'm going
to apply this patch to target-arm.next (minus the compat.h
change which has already gone into master via another commit).

thanks
-- PMM
