Received: from eggs.gnu.org ([2001:4830:134:3::10]:52139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOP0W-0007Qc-WF
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:56:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOP0W-0004DL-AI
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:56:53 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:41611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOP0V-0004BS-Rf
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:56:52 -0400
Received: by mail-ot0-x241.google.com with SMTP id t1-v6so25611530oth.8
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 07:56:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOMwq8-H+iZ1L996G4jdky__zstwFo6x0qTucqLRstuXhs1CEA@mail.gmail.com>
References: <1527736557-11084-1-git-send-email-zhaoshenglong@huawei.com>
	<1527736557-11084-3-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA-qWkhueUUnZ1RmhRuhHLstGpwmameHgsOM7UautJVxpw@mail.gmail.com>
	<CAOMwq8-H+iZ1L996G4jdky__zstwFo6x0qTucqLRstuXhs1CEA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:56:30 +0100
Message-ID: <CAFEAcA-R6N3Umg6=TzQrwoCw8VAL7VT7NTzLN4TnKoPBP4jRBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] arm_gicv3_kvm: kvm_dist_get/put:
 skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <shannon.zhaosl@gmail.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 31 May 2018 at 15:36, Shannon Zhao <shannon.zhaosl@gmail.com> wrote:
>
>
> 2018-05-31 21:50 GMT+08:00 Peter Maydell <peter.maydell@linaro.org>:
>> Shouldn't we be adding the same thing to clroffset that we add to offset ?
>>
>> Yeah, right. It should like this
>
>   clroffset += (GIC_INTERNAL * 1) / 8;
>
> I don't remember why I didn't write this way. Anyway, Could you please fix
> this when you apply this patch or I send a new version?

It's probably easiest if you resend; you have Eric's comment
typos to fix too.

thanks
-- PMM
