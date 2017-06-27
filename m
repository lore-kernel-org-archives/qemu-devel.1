Received: from eggs.gnu.org ([2001:4830:134:3::10]:56370)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPqKU-0001kO-OS
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPqKP-0001GR-Ps
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:14:54 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:53283 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPqKP-0001Dk-HO
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:14:49 -0400
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
	<1498566850-7934-5-git-send-email-pl@kamp.de>
	<8dd6223f-5e14-ae0a-ba84-b94d2d64e09d@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <177e6c55-7959-f949-1cfd-bd2dd1bf7d16@kamp.de>
Date: Tue, 27 Jun 2017 15:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <8dd6223f-5e14-ae0a-ba84-b94d2d64e09d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] block/qcow2: add zlib-fast compression
 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com

Am 27.06.2017 um 14:53 schrieb Eric Blake:
> On 06/27/2017 07:34 AM, Peter Lieven wrote:
>> this adds support for optimized zlib settings which almost
> Start sentences with a capital.
>
>> tripples the compression speed while maintaining about
> s/tripples/triples/
>
>> the same compressed size.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   block/qcow2-cluster.c |  3 ++-
>>   block/qcow2.c         | 11 +++++++++--
>>   block/qcow2.h         |  1 +
>>   qemu-img.texi         |  1 +
>>   4 files changed, 13 insertions(+), 3 deletions(-)
>>
>> +++ b/block/qcow2.h
>> @@ -173,6 +173,7 @@ typedef struct Qcow2UnknownHeaderExtension {
>>   enum {
>>       QCOW2_COMPRESSION_ZLIB          = 0xC0318301,
>>       QCOW2_COMPRESSION_LZO           = 0xC0318302,
>> +    QCOW2_COMPRESSION_ZLIB_FAST     = 0xC0318303,
> Back to my comments on 1/4 - we MUST first get the qcow2 specification
> right, rather than adding undocumented headers in the code.  And I still
> think you only need one variable-length header extension for covering
> all possible algorithms, rather than one header per algorithm.  Let's
> get the spec right first, before worrying about the code implementing
> the spec.
>

Okay, I think someone came up with the idea to have an optional
header per algorithm, but you are right one header with an optional
parameter payload will also do.

I will split the spec change to a separate patch in V2 to make it easier
to respin.

Thanks,
Peter
