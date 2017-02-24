Received: from eggs.gnu.org ([2001:4830:134:3::10]:47473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chIjt-0005Kg-Oj
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:29:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chIjq-0004Gl-JD
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:29:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1chIjq-0004GO-DU
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:28:58 -0500
References: <148794791903.177.12506775196291811914@0e2666bad730>
	<38f8bb7a-63e6-d718-2f2f-9530bc659040@suse.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <446a10db-d790-d7b4-bff7-2de4b82a7063@redhat.com>
Date: Fri, 24 Feb 2017 17:28:54 +0100
MIME-Version: 1.0
In-Reply-To: <38f8bb7a-63e6-d718-2f2f-9530bc659040@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-s390x: Implement stfl and stfle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Marek <mmarek@suse.com>, qemu-devel@nongnu.org
Cc: ebischoff@suse.com, mbenes@suse.cz, famz@redhat.com, agraf@suse.de, rth@twiddle.net

Am 24.02.2017 um 16:22 schrieb Michal Marek:
> On 2017-02-24 15:51, no-reply@patchew.org wrote:
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
> [...]
>> === OUTPUT BEGIN ===
>> Checking PATCH 1/1: target-s390x: Implement stfl and stfle...
>> ERROR: braces {} are necessary for all arms of this statement
>> #108: FILE: target/s390x/misc_helper.c:522:
>> +    if (need <= len)
>> [...]
>> +    else
>> [...]
> 
> I was not aware of this coding style requirement. I will wait if I get
> more feedback from humans and resubmit.
> 

Yes, QEMU (in contrast to the kernel) always requires {} for
if/else/for/while....

-- 
Thanks,

David
