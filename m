Received: from eggs.gnu.org ([209.51.188.92]:51526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0sUi-0001Im-A1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:39:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0sUg-0002FR-I1
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:39:20 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0sUc-0002C4-VG
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 13:39:15 -0500
Received: by mail-ot1-x343.google.com with SMTP id t7so5087208otk.8
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 10:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20190304101339.25970-1-eric.auger@redhat.com>
	<a90df8ae-503e-227a-2f4a-3bd61e4da99f@redhat.com>
In-Reply-To: <a90df8ae-503e-227a-2f4a-3bd61e4da99f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 18:38:56 +0000
Message-ID: <CAFEAcA8S4OytKYuieOsU+qxqZXhDQcnHrVeqL0G2mdnggR7gRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v12 00/10] ARM virt: Initial RAM expansion
 and extended memory map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 4 Mar 2019 at 17:12, Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Peter,
>
> On 3/4/19 11:13 AM, Eric Auger wrote:
> > This series aims to bump the 255GB RAM limit in machvirt and paves the
> > way to device memory addition.

> I collected all the R-b's I received from Igor and Richard and I removed
> the PCDIMM/NVDIMM integration. Please let me know if you have some
> remaining comments so that this series hopefully lands in the next release.

Thanks -- I've applied it to target-arm.next.

-- PMM
