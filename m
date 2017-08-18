Received: from eggs.gnu.org ([2001:4830:134:3::10]:59488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1die8f-0000Un-Ht
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1die8a-0006Bc-Kj
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:04:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1die8a-0006BN-EJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:04:20 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-2-david@redhat.com>
	<69dfd14d-ace7-9413-509f-a43ccdccc6ef@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5578f62d-52ca-55ab-de6e-d9c72fabb6e8@redhat.com>
Date: Fri, 18 Aug 2017 12:04:14 +0200
MIME-Version: 1.0
In-Reply-To: <69dfd14d-ace7-9413-509f-a43ccdccc6ef@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 01/10] target/s390x: move
 cc_name() to cc_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 18.08.2017 11:59, David Hildenbrand wrote:
> On 17.08.2017 11:22, David Hildenbrand wrote:
>> While at it, move the translations into the function.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  target/s390x/cc_helper.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  target/s390x/cpu.h       | 48 +-----------------------------------------------
>>  2 files changed, 49 insertions(+), 47 deletions(-)
[...]
> Just compiled with --disable-tcg
> 
> s390_cpu_dump_state() needs cc_name. I suggest moving it to helper.c
> instead. Opinions?

Sounds fine to me, too.

 Thomas
