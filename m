Received: from eggs.gnu.org ([2001:4830:134:3::10]:54862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fJNEJ-0002NN-37
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fJNEE-00049P-4T
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:02:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49680
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fJNED-00048T-T7
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:02:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4HHwlL7057381
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 14:02:12 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j1dy8sucr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 14:02:11 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 17 May 2018 19:02:10 +0100
References: <20180510000712.6472-1-pasic@linux.ibm.com>
	<20180510000712.6472-2-pasic@linux.ibm.com>
	<20180514141808.78efe5c0.cohuck@redhat.com>
	<ea3c977e-de5c-ed68-fc8d-448efca1d463@linux.ibm.com>
	<20180514154515.056b605f.cohuck@redhat.com>
	<2b5d39df-ae97-5fe3-7a1a-658eff5db038@linux.ibm.com>
	<20180514180409.5eed7d79.cohuck@redhat.com>
	<a5e60306-891d-5d9b-5ae2-0b10224aea93@linux.ibm.com>
	<20180517162106.6ca8d632.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 17 May 2018 20:02:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180517162106.6ca8d632.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <695e2d58-b2c2-8bde-5e80-50309aa69453@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/2] vfio-ccw: add force
 unlimited prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Pierre Morel <pmorel@linux.ibm.com>



On 05/17/2018 04:21 PM, Cornelia Huck wrote:
>> How about force-orb-pfch or force-orb-pbit (PoP name) for the property
>> and with underscores for the variable. My idea was (starting from your
>> force_pfch) to spell out that we are fiddling with that orb bit.
> force-orb-pfch looks reasonable to me.
> 
>> Can I/do I have to document the property somewhere? Telling the whole
>> story with the name is going to be difficult.
> The description member would require that you define your own property
> type IIUC, which I think would be overkill. So I'd add a comment in the
> source code.
> 

I'm afraid you misunderstood me. I was thinking manual type documentation.
AFAIK the property would provide what was called online help if my memory
does not fail me (I mean in-application help like -h or context-sensitive
help) only. That is, it ain't used to generate a portion of the manual.

Anyway, I agree, for this particular property we can live with only people
that are not afraid of examining the code having enough info to use it.

I will prepare a v2 tomorrow based the proceedings of the
discussion here.

Thank you very much for your patience.

Regards,
Halil  
