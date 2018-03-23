Received: from eggs.gnu.org ([2001:4830:134:3::10]:45135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezRSt-0002S6-NQ
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ezRSq-0006sZ-JO
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:30:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ezRSq-0006sD-A5
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:30:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2NITo7f055456
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 14:30:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gw6af1gfm-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 14:30:53 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Mar 2018 18:30:48 -0000
References: <20180323140821.28957-1-peterx@redhat.com>
	<17b3708c-3787-c08d-e960-c6df21114689@redhat.com>
	<ff6a3e78-56dd-aa7b-da36-4d0a79634079@redhat.com>
	<758e314f-10d3-d335-9f20-7ee7cf714320@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Mar 2018 19:30:42 +0100
MIME-Version: 1.0
In-Reply-To: <758e314f-10d3-d335-9f20-7ee7cf714320@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <eae83d50-e36c-ba0b-0cdb-d1744c1d0620@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] Turn OOB off for 2.12-rc1,
 revert OOB tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>



On 03/23/2018 06:17 PM, Eric Blake wrote:
> On 03/23/2018 10:53 AM, Eric Blake wrote:
> 
>> Actually, we should revert things in reverse order of the original commits, so that we aren't introducing yet more temporary breakage.
>>
>> Since you reverted:
>>
>> $ git describe 3fd2457 d003f7a 91ad450 0213031 --match=v\*
>> v2.11.0-2595-g3fd2457d18e
>> v2.11.0-2598-gd003f7a8f9c
>> v2.11.0-2597-g91ad45061af
>> v2.11.0-2585-g02130314d8c
>>
>> where the higher the middle number represents the further distance from 2.11 (aka newer patch), this series should be applied in the order:
>>
>> 2/4 (revert the newest patch first)
>> 3/4
>> 1/4
>> 4/4
> 
> Even that didn't work - 'make check' fails with either 1/4 or 4/4 applied in isolation, so I'm squashing them into a single patch.

Yes, "qmp: introduce QMPCapability" added an assert, that was fixed by a later on patch. So
the original series was not bisectable. Anyway with Peters 4 patches all applied things are fine
for me.
