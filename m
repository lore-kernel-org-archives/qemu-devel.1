Received: from eggs.gnu.org ([209.51.188.92]:38589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1goCZJ-0005Eb-BA
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1goCZI-0004pQ-Fx
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:27:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43908
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1goCZI-0004jn-AS
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:27:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0SJNvnv126743
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:27:30 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qa7f7hfra-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:27:29 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 28 Jan 2019 19:27:25 -0000
References: <1546963310-17024-1-git-send-email-akrowiak@linux.ibm.com>
	<5a7e9130-30d1-84ad-0737-5023b718b99c@redhat.com>
	<54bc1f9c-e997-cb1b-77cb-0dce478fafdc@linux.ibm.com>
	<d4599c55-2d71-e1e9-ec7a-cffbc7d06abe@redhat.com>
	<20190109123037.7f51888f.cohuck@redhat.com>
	<fb665b3b-9bbf-e2bd-8618-b080d4c2453d@linux.ibm.com>
	<105c451b-6873-b7a9-1c3a-e3b8fe7d4af3@redhat.com>
	<20190109181302.2ac8b249@oc2783563651>
	<bbcfd6dd-38b8-5d98-ac4b-3b17d63983fe@redhat.com>
	<6e0d217f-3027-bff8-b9fd-13469e940c97@linux.ibm.com>
	<20190114151636.630d4b31.cohuck@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 28 Jan 2019 14:27:17 -0500
MIME-Version: 1.0
In-Reply-To: <20190114151636.630d4b31.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9fb4c4c5-8223-0c11-c5ba-170ff45e879f@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/vfio-ap: Implement hot plug/unplug
 of vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, jjherne@linux.ibm.com, peter.maydell@linaro.org, pasic@linux.vnet.ibm.com, fiuczy@linux.ibm.com, alex.williamson@redhat.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

On 1/14/19 9:16 AM, Cornelia Huck wrote:
> On Thu, 10 Jan 2019 11:22:48 -0500
> Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> 
>>>>> Can you extend this patch description a little bit, including what we
>>>>> discussed here?
>>>>
>>>> Maybe a short comment that explains why qdev_simple_device_unplug_cb()
>>>> is appropriate as well (i.e. hits that closing the mdev's fd is what
>>>> triggers the cleanup of the actual resources)? I personally go log
>>>> digging only once I get desperate.
>>>
>>> I go digging if I can't find a public document on how it works ;)
>>
>> Which reminds me, I will also need to update the docs/vfio-ap.txt
>> document.
> 
> So, I assume there will be a v2 with some documentation changes?

I'm sorry Connie, I got sidetracked with some other priorities and
missed this response. I will post a v2 with doc changes.

> 
