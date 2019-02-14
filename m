Received: from eggs.gnu.org ([209.51.188.92]:34186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guL4O-0002i1-7E
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guKv9-0002n9-Ms
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:35:36 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35080)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guKv9-0002m9-Gj
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 12:35:35 -0500
Received: by mail-ot1-x342.google.com with SMTP id z19so11921889otm.2
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 09:35:35 -0800 (PST)
MIME-Version: 1.0
References: <20190205173306.20483-1-eric.auger@redhat.com>
In-Reply-To: <20190205173306.20483-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 17:35:23 +0000
Message-ID: <CAFEAcA9QHxm7ACYBnKibfderjfgg+9p+xHZZB4QmMHk26BqTuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 00/18] ARM virt: Initial RAM expansion
 and PCDIMM/NVDIMM support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
> This series aims to bump the 255GB RAM limit in machvirt and to
> support device memory in general, and especially PCDIMM/NVDIMM.

> Functionally, the series is split into 3 parts:
> 1) bump of the initial RAM limit [1 - 10] and change in
>    the memory map
> 2) Support of PC-DIMM [11 - 14]
> 3) Support of NV-DIMM [15 - 18]
>
> 1) can be upstreamed before 2 and 2 can be upstreamed before 3.

Hi Eric; sorry I haven't reviewed this series earlier. I think
that 1-10 are pretty near to ready to go in; maybe the easiest
path is to do a respin of just those with the review issues fixed?

I'm a long way from being expert in the PC-DIMM/NV-DIMM stuff, so
I'm going to be reliant on other people to review those parts.

I don't know if your series needs anything from linux-headers
which isn't already in QEMU master after the update to match
5.0rc1 -- if not you could drop the header-sync patch.

thanks
-- PMM
