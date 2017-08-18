Received: from eggs.gnu.org ([2001:4830:134:3::10]:46347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dil4Z-0005Og-3k
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dil4W-0006Hl-08
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:28:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dil4V-0006Hd-Q6
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:28:35 -0400
References: <20170818114353.13455-1-david@redhat.com>
	<20170818114353.13455-9-david@redhat.com>
	<dc191b37-68f4-dc69-dfce-7a64437ba74d@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7ff28ad9-d2be-6bab-09a8-cbc3bd6ed003@redhat.com>
Date: Fri, 18 Aug 2017 19:28:31 +0200
MIME-Version: 1.0
In-Reply-To: <dc191b37-68f4-dc69-dfce-7a64437ba74d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 08/18] target/s390x: move
 gtod_*() declarations to s390-virtio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 18.08.2017 18:11, Thomas Huth wrote:
> Suggesting to add a patch description like: "The functions are not used
> in target/s390x/ so a header in hw/s390x/ is a better place" ?

Sure, I will include that, thanks!

> 
> On 18.08.2017 13:43, David Hildenbrand wrote:
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/s390-virtio.h | 2 ++
>>  target/s390x/cpu.h     | 3 ---
>>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> Anyway:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


-- 

Thanks,

David
