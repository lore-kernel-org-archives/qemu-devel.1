Received: from eggs.gnu.org ([2001:4830:134:3::10]:52085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb4f0-00073t-6g
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:51:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fb4ey-00084P-Kq
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:51:02 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fb4ey-00083F-FO
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:51:00 -0400
Received: by mail-oi0-x243.google.com with SMTP id d189-v6so16975862oib.6
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 06:51:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <94f26745-00a2-eb8d-f6d9-d9ad4829214e@redhat.com>
References: <1530775623-32399-1-git-send-email-eric.auger@redhat.com>
	<CAFEAcA8YkDgJgr5Mgv4PgpmhQDpr+61hfaxmpnQWGXocEawxdg@mail.gmail.com>
	<94f26745-00a2-eb8d-f6d9-d9ad4829214e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jul 2018 14:50:39 +0100
Message-ID: <CAFEAcA_nPNaEAOcYFQQ1Vxw1E9B4WuZitj1AQSMCQ4qvqZMcMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 3.0] hw/arm/smmu-common: Fix devfn
 computation in smmu_iommu_mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger.pro@gmail.com>

On 5 July 2018 at 14:30, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 07/05/2018 02:56 PM, Peter Maydell wrote:
>> Is there a reason I missed why we don't just define the struct
>> to have
>>   SMMUDevice *pbdev[SMMU_PCI_DEVFN_MAX];
>
> I don't see any reason either. This code is inherited from
> hw/i386.intel_iommu.c vtd_find_add_as() which does the same allocation
> and I cannot find any reason out there either. This is not a
> justification though ;-)
>
> Can I fix it in 3.1 or do you want me to fix it for 3.0?

3.1 is fine.

thanks
-- PMM
