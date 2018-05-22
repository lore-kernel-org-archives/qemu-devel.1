Received: from eggs.gnu.org ([2001:4830:134:3::10]:48306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL3Me-0005zE-Ps
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL3Md-00041g-P8
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:13:52 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL3Md-00041K-Ji
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:13:51 -0400
Received: by mail-oi0-x241.google.com with SMTP id 11-v6so15541962ois.8
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 02:13:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5AC97568.2040502@huawei.com>
References: <1521530809-11780-1-git-send-email-zhaoshenglong@huawei.com>
	<1521530809-11780-3-git-send-email-zhaoshenglong@huawei.com>
	<CAFEAcA96qV_f7i_36Yzb-QV7W9SRHKfJpg=rvv3tia2X-Xi7QQ@mail.gmail.com>
	<5AB0F254.3050503@huawei.com>
	<CAFEAcA-Ct3qa0OFZ4U+9RH68SQJgmkxJKKS5e+if_MuL2pSu3A@mail.gmail.com>
	<5AB21130.2020309@huawei.com>
	<CAFEAcA8yr+KJFwBSksMP-VjNbsSd190VCzB4wGwOCoaX2ScDiA@mail.gmail.com>
	<CAFEAcA_r=S=YWAuZue1zZnFdtFYK2wU7NnaCcGThZU_u33qD4g@mail.gmail.com>
	<CAFEAcA_JYyHj6NGJahGPQ9p9XQz6rkmhWMfheW96DzkciModDA@mail.gmail.com>
	<CAFEAcA_GwG-80oNHHb1wcJxkzS5YcbH335JHBo48_ksFmgRB7A@mail.gmail.com>
	<5AC97568.2040502@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 10:13:30 +0100
Message-ID: <CAFEAcA8M4-2sAr84kA-1m-0ydw_Xy27A6qK4BEwEzRTdCNahgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 2/2] arm_gicv3_kvm:
 kvm_dist_get/put: skip the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

On 8 April 2018 at 02:50, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
> On 2018/4/6 17:36, Peter Maydell wrote:
>> On reflection, I think I'd aim for 2.13 for this, since:
>>  * it's not a regression
>>  * it doesn't actually affect any of our boards, because
>>    none of them define enough interrupt lines that they
>>    would actually be using the top 32 that we fail to migrate
>>  * getting the migration compat right is a bit tricky and
>>    will benefit from having the time for careful review and testing
>>
>> Let me know if I'm wrong with any of those assumptions.
>
> Yes, it's no need to merge this for 2.12. I'll respin this patch later.

Looking at another GIC related patch this morning reminded me
about this one. Shannon, are you planning to respin this now we've
reopened for 2.13 development?

thanks
-- PMM
