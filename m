Received: from eggs.gnu.org ([2001:4830:134:3::10]:41695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d2g3y-0002L2-Oj
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d2g3x-0001kS-Sa
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:38:06 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<1492957997-28587-2-git-send-email-lidongchen@tencent.com>
	<7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7bb35794-6a50-c92f-fee7-e8f9cc55a1d0@amsat.org>
Date: Mon, 24 Apr 2017 12:37:56 -0300
MIME-Version: 1.0
In-Reply-To: <7c616dbd-f83f-1643-d211-f5be8d8b2dc4@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: fix some spelling errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, jemmy858585@gmail.com, Lidong Chen <lidongchen@tencent.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Hi Eric,

On 04/24/2017 11:40 AM, Eric Blake wrote:
> On 04/23/2017 09:33 AM, jemmy858585@gmail.com wrote:
>> From: Lidong Chen <lidongchen@tencent.com>
>>
>> Fix some spelling errors in is_allocated_sectors comment.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> ---
>>  qemu-img.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index df6d165..0b3349c 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1033,8 +1033,8 @@ done:
>>  }
>>
>>  /*
>> - * Returns true iff the first sector pointed to by 'buf' contains at least
>> - * a non-NUL byte.
>> + * Returns true if the first sector pointed to by 'buf' contains at least
>> + * a non-NULL byte.
>
> NACK to both changes.  'iff' is an English word that is shorthand for
> "if and only if".  "NUL" means the one-byte character, while "NULL"
> means the 8-byte (or 4-byte, on 32-bit platform) pointer value.

I agree with Lidong shorthands are not obvious from non-native speaker.

What about this?

  * Returns true if (and only if) the first sector pointed to by 'buf' 
contains
  * at least a non-null character.
