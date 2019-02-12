Received: from eggs.gnu.org ([209.51.188.92]:42801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtXHF-0005FD-7E
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:35:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtXEU-0006K6-8b
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 07:32:15 -0500
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-7-git-send-email-jjherne@linux.ibm.com>
	<20190204114801.2699c9a0.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <62dd4d03-a37f-b90b-29dd-7c2dd295cb3d@redhat.com>
Date: Tue, 12 Feb 2019 13:32:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190204114801.2699c9a0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 06/15] s390-bios: Clean up
 cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, alifm@linux.ibm.com, qemu-devel@nongnu.org

On 2019-02-04 11:48, Cornelia Huck wrote:
> On Tue, 29 Jan 2019 08:29:13 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Add proper typedefs to all structs and modify all bit fields to use consistent
>> formatting.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Reviewed-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  pc-bios/s390-ccw/cio.h      | 86 ++++++++++++++++++++++-----------------------
>>  pc-bios/s390-ccw/s390-ccw.h |  8 -----
>>  2 files changed, 43 insertions(+), 51 deletions(-)
>>
>> diff --git a/pc-bios/s390-ccw/cio.h b/pc-bios/s390-ccw/cio.h
>> index 1a0795f..a48eee5 100644
>> --- a/pc-bios/s390-ccw/cio.h
>> +++ b/pc-bios/s390-ccw/cio.h
>> @@ -53,12 +53,12 @@ struct schib_config {
>>      __u64 mba;
>>      __u32 intparm;
>>      __u16 mbi;
>> -    __u32 isc:3;
>> -    __u32 ena:1;
>> -    __u32 mme:2;
>> -    __u32 mp:1;
>> -    __u32 csense:1;
>> -    __u32 mbfc:1;
>> +    __u32 isc    : 3;
>> +    __u32 ena    : 1;
>> +    __u32 mme    : 2;
>> +    __u32 mp     : 1;
>> +    __u32 csense : 1;
>> +    __u32 mbfc   : 1;
>>  } __attribute__ ((packed));
> 
> This seems to make checkpatch unhappy... maybe consolidate to the other
> formatting instead?

Yeah, you get lots of these errors this way:

ERROR: spaces prohibited around that ':' (ctx:WxW)
#141: FILE: pc-bios/s390-ccw/cio.h:56:
+    __u32 isc    : 3;
                  ^

ERROR: spaces prohibited around that ':' (ctx:WxW)
#142: FILE: pc-bios/s390-ccw/cio.h:57:
+    __u32 ena    : 1;
                  ^

ERROR: spaces prohibited around that ':' (ctx:WxW)
#143: FILE: pc-bios/s390-ccw/cio.h:58:
+    __u32 mme    : 2;
                  ^
...

Not sure whether it's a checkpatch warning or really our official coding
style, but anyway, I'd rather prefer to keep checkpatch calm here and
thus no spaces around the ':' please.

 Thomas
