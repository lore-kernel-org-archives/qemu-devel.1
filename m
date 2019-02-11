Received: from eggs.gnu.org ([209.51.188.92]:38093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gtFWi-0000AO-Tz
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:37:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gtFWh-0005Cj-PZ
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:37:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33662
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gtFWg-0004rL-NE
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:37:50 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1BHYBHi086056
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 12:37:30 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qkcq5bdef-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 12:37:29 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Mon, 11 Feb 2019 17:37:29 -0000
References: <20190130132212.7376-1-cohuck@redhat.com>
	<20190206150016.6fdfaf8f.cohuck@redhat.com>
	<1981d9bc-e950-62ef-d2d2-66a17771c8f4@linux.ibm.com>
	<20190211171354.40be0856.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 11 Feb 2019 12:37:23 -0500
MIME-Version: 1.0
In-Reply-To: <20190211171354.40be0856.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <75c1f24b-204d-d464-8466-8453f7a0f89c@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] vfio-ccw: support hsch/csch (kernel
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 02/11/2019 11:13 AM, Cornelia Huck wrote:
> On Fri, 8 Feb 2019 16:19:58 -0500
> Eric Farman <farman@linux.ibm.com> wrote:
>>
>> FWIW, I've been running with both series for the last week or two, along
>> with some host kernel traces to prove things got executed the way I
>> thought, and it's seemed to be working well.  So that makes me
>> optimistic for the later patches.
> 
> That's good news, thanks for testing. Do you have a special test load
> that you run in the guest that you can share?
> 

Not really.  Lately it's just fio, run via some ancient scripts which 
randomize the input parameters and distill the output data.  If I get 
some time to make it less hack-y it might be worth sharing, but right 
now there's more things commented out than actual script.  :)

  - Eric
