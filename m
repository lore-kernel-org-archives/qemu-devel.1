Received: from eggs.gnu.org ([2001:4830:134:3::10]:34050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIF5R-0004kH-BE
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:36:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIF5Q-0003tJ-LM
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:36:13 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:40275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIF5Q-0003sg-FS
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 09:36:12 -0500
Received: by mail-ot0-x236.google.com with SMTP id g104so18947430otg.7
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 06:36:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <dd80f8f3-26da-5893-fa4b-cfa31790394d@redhat.com>
References: <1511533107-5315-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_K4f=mmuoEbyuFCHP2dor5p2UPyedteELQoxPYFzAcEg@mail.gmail.com>
	<dd80f8f3-26da-5893-fa4b-cfa31790394d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 14:35:51 +0000
Message-ID: <CAFEAcA8mqRsOYPVOu=tPqDuXyHauKpoF3AQ-bQgiqv5514o+Xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/4] ITS Reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com

On 24 November 2017 at 14:32, Auger Eric <eric.auger@redhat.com> wrote:
> On 24/11/17 15:20, Peter Maydell wrote:
>> Thanks. My remaining question is: how important it is to
>> put some of this into 2.11? We're getting quite close to
>> the release now so I'm getting gradually more reluctant
>> to put in changes.
>
> I fully understand.
>
> Anyway clean and comprehensive reset modality would require v4.15 + full
> QEMU series (otherwise you get the scary error message even if full
> reset can be achieved by individual register writes).
>
> This means the migration of guests while they are booting will not be
> functional in 2.11. However it should not abort QEMU as it did before,
> with a kernel >= v4.14.

...so overall, what is your recommendation for what we should
or should not put into 2.11 ?

thanks
-- PMM
