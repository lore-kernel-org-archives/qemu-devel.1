Received: from eggs.gnu.org ([2001:4830:134:3::10]:45032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cl16z-0008Hu-Fc
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 17:28:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cl16u-0004HI-Ev
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 17:28:13 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60096
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cl16u-0004Gq-81
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 17:28:08 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26MOEAb060839
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 17:28:06 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 291ddf03k3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 17:28:05 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 6 Mar 2017 22:28:04 -0000
References: <20170302130422.81380-1-pasic@linux.vnet.ibm.com>
	<20170302154935.7b8ec875.cornelia.huck@de.ibm.com>
	<b12c69aa-67ee-ffbc-cd89-716c24889167@redhat.com>
	<9a67d492-5bda-4b2a-0732-4034176d0d28@linux.vnet.ibm.com>
	<7b6ff676-bf57-d9ab-def7-fe894f821f03@redhat.com>
	<42da742f-a4fa-b592-904e-5e6f07bfe990@linux.vnet.ibm.com>
	<baababfc-04b0-ad71-3065-381bf8dd1e0d@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 6 Mar 2017 23:27:57 +0100
MIME-Version: 1.0
In-Reply-To: <baababfc-04b0-ad71-3065-381bf8dd1e0d@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <ed58ed3b-4c61-854c-0864-e7422ca68ca6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-blk: fix race on guest notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org



On 03/06/2017 03:55 PM, Paolo Bonzini wrote:
> 
> On 03/03/2017 20:43, Halil Pasic wrote:
>> Uh, this is complicated. I'm not out of questions, but I fear taking to
>> much of your precious time. I will ask again nevertheless, but please
>> just cut the conversation with -EBUSY if it gets to expensive.
> It's the opposite!  I need other people to look at it, understand it and
> poke holes at my own reasoning.
> 

Thanks for the explanation. I intend to send out a v2 (with
the typo fixed) tomorrow.

Regards,
Halil
