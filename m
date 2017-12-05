Received: from eggs.gnu.org ([2001:4830:134:3::10]:59868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMG4s-0006Zc-0m
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eMG4n-00065R-1j
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:28:13 -0500
References: <20171204140150.20483-1-david@redhat.com>
	<20171204140150.20483-8-david@redhat.com>
	<20171205161424.0e51ce1b.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <679b9177-c947-4150-e126-0320be2d1761@redhat.com>
Date: Tue, 5 Dec 2017 17:28:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171205161424.0e51ce1b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 7/9] s390x/tcg: implement
 extract-CPU-time facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On 05.12.2017 16:14, Cornelia Huck wrote:
> On Mon,  4 Dec 2017 15:01:48 +0100
> David Hildenbrand <david@redhat.com> wrote:
> 
>> It only provies the EXTRACT CPU TIME instruction. We can reuse the stpt
> 
> s/provies/provides/
> 
>> helper, which calculates the CPU timer value.
>>
>> As the instruction is not priviledged, but we don't have a CPU timer
> 
> s/priviledged/privileged/

Didn't checkpatch once check for possible spelling mistakes? (or only in
the kernel)? Thanks :)

> 
>> value in case of linux user, we simply fake the CPU timer to be 0.
> 
> There's probably nothing else we could do.

We could also setup and use a CPU timer, but I don't want to go down
that path right now :)

-- 

Thanks,

David / dhildenb
