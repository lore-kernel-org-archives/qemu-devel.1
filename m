Received: from eggs.gnu.org ([2001:4830:134:3::10]:60697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fJNcR-0006hA-LJ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fJNcO-0002ab-Jo
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:27:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53136
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fJNcO-0002Ze-DE
	for qemu-devel@nongnu.org; Thu, 17 May 2018 14:27:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4HIO2DS109695
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 14:27:11 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2j1d0ydj27-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 14:27:11 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 17 May 2018 19:27:09 +0100
References: <20180516132757.68558-1-pasic@linux.ibm.com>
	<20180517172628.61cf46ba.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 17 May 2018 20:27:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180517172628.61cf46ba.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <09546c53-ac8e-aa79-ceec-48d65c1c719f@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-ccw: clean up notify
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>, Richard Henderson <rth@twiddle.net>



On 05/17/2018 05:26 PM, Cornelia Huck wrote:
> On Wed, 16 May 2018 15:27:57 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> Coverity recently started complaining about virtio_ccw_notify().  Turns
>> out, there is a couple of things that can be cleaned up.  Let's clean!
> 
> Changes look good to me.
> 
> I wanted to come up with a better patch description, but failed (well,
> I did not try much.) So I'm inclined to merge this as-is.
> 

I also gave up on a good patch description real soon. The patch does not do
a single thing, but I don't think splitting it up would make things better.
So I was like: the changes are pretty straight-forward, and the commit message
should just hint refactoring.

Thanks!

Halil


>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Fixes: CID 1390619
>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>> ---
>>   hw/s390x/virtio-ccw.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
