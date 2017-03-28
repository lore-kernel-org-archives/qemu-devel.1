Received: from eggs.gnu.org ([2001:4830:134:3::10]:60711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKs-0004DD-WB
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKo-0005tg-Fn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:59 -0400
Received: from [59.151.112.132] (port=31432 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKo-0005tV-2i
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:54 -0400
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490260163-6157-3-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161228.73f7ac0f@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58DA6985.80805@cn.fujitsu.com>
Date: Tue, 28 Mar 2017 21:47:49 +0800
MIME-Version: 1.0
In-Reply-To: <20170324161228.73f7ac0f@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] vfio pci: new function to init AER
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, mst@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>



On 03/25/2017 06:12 AM, Alex Williamson wrote:
> On Thu, 23 Mar 2017 17:09:22 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
> This is not a sufficiently trivial patch to leave the commit log empty.
> 
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---

>> +    pcie_cap_deverr_init(pdev);
> 
> This assumes we've set exp_cap, perhaps the code should validate this
> to avoid corner case configurations where the PCIe cap has been dropped
> yet AER is still present.  I'm not sure if it's possible, but I'd
> rather test than segfault.
> 
>> +    return pcie_aer_init(pdev, cap_ver, pos, size, errp);
> 
> 
> I think here too, users may have existing configurations that could
> break by suddenly imposing a new topology requirement.
> 

Not quite follow, test what for pcie_aer_init()?

-- 
Sincerely,
Cao jin
