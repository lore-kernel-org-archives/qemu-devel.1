Received: from eggs.gnu.org ([2001:4830:134:3::10]:35766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dnkOg-0006GT-5s
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:46:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dnkOd-0003K7-2I
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:46:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dnkOc-0003JQ-Q2
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 07:45:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v81Bi9he047635
	for <qemu-devel@nongnu.org>; Fri, 1 Sep 2017 07:45:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cq4c220m8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 07:45:57 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 1 Sep 2017 12:45:54 +0100
References: <1503734014-239116-1-git-send-email-longpeng2@huawei.com>
	<59A8AE20.1080409@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 1 Sep 2017 13:45:45 +0200
MIME-Version: 1.0
In-Reply-To: <59A8AE20.1080409@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7f0b8eb2-9e5c-7507-191d-1aab17c6ff0f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v19 0/2] virtio-crypto: virtio crypto
 device specification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, luonengjun@huawei.com, mst@redhat.com, cohuck@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, mike.caraman@nxp.com, agraf@suse.de, jasowang@redhat.com, nmorey@kalray.eu, vincent.jardin@6wind.com, arei.gonglei@hotmail.com, wangxinxin.wang@huawei.com



On 09/01/2017 02:47 AM, Longpeng (Mike) wrote:
> Ping...
> 
> Stefan, Halil, do you have any suggestion ?
> 

Hi Longpeng,

I've ran trough your patch, and it reads much better that
what I recall v18 used to read like. Because it's been a while
since v18 doing a conscious review on this will take a considerable
amount of time (my memories of the issues identified back then
are very sketchy/vague now). It's on my todo list, but it ain't the
only item there.

Btw. I like to have a reference implementation at hand when reviewing
a spec. What is the status of the (reference) implementation (I mean
the new stuff like stateless/mux)? I think it would be nice to provide
this info in the cover letter (e.g. next time, should we need another
iteration).

Regards,
Halil
