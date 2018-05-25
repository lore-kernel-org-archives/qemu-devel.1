Received: from eggs.gnu.org ([2001:4830:134:3::10]:38486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <y-goto@jp.fujitsu.com>) id 1fM4se-0001Ej-LB
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <y-goto@jp.fujitsu.com>) id 1fM4sb-0006oU-IV
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:03:08 -0400
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:35373)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <y-goto@jp.fujitsu.com>)
	id 1fM4sb-0006mr-2v
	for qemu-devel@nongnu.org; Fri, 25 May 2018 01:03:05 -0400
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com
	[10.134.21.209])
	by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 53F6CAC018B
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 14:02:56 +0900 (JST)
Date: Fri, 25 May 2018 14:02:30 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
In-Reply-To: <CAPcyv4h3RHymfKXxebBf+4DJs7vyJyhOVOuhDUJtchBnGOFrDw@mail.gmail.com>
References: <20180524161922.EC59.E1E9C6FF@jp.fujitsu.com>
	<CAPcyv4h3RHymfKXxebBf+4DJs7vyJyhOVOuhDUJtchBnGOFrDw@mail.gmail.com>
Message-Id: <20180525140226.04D7.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Questions about vNVDIMM on qemu/KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, NVDIMM-ML <linux-nvdimm@lists.01.org>


> >
> > But ,I would like understand one more thing.
> > In the following mail, it seems that e820 bus will be used for fake DAX.
> >
> > https://lists.01.org/pipermail/linux-nvdimm/2018-January/013926.html
> >
> > Could you tell me what is relationship between "fake DAX" in this mail
> > and Guest DAX?
> > Why e820 is necessary for this case?
> >
> 
> It was proposed as a starting template for writing a new nvdimm bus
> driver. All we need is a way to communicate both the address range and
> the flush interface. This could be done with a new SPA Range GUID with
> the NFIT, or a custom virtio-pci device that registers a special
> nvdimm region with this property. My preference is whichever approach
> minimizes the code duplication, because the pmem driver should be
> re-used as much as possible.

Ok, I see.
Thank you very much for your explanation.

Bye,
---
Yasunori Goto
