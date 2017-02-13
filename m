Received: from eggs.gnu.org ([2001:4830:134:3::10]:60159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdIzD-0008ID-JA
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cdIzA-0004Ke-U6
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 10:56:19 -0500
References: <20170208170533.28822-1-jsnow@redhat.com>
	<20170213150003.GO10361@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <ae6284d9-6776-6ae4-a041-06819d69d413@redhat.com>
Date: Mon, 13 Feb 2017 10:56:15 -0500
MIME-Version: 1.0
In-Reply-To: <20170213150003.GO10361@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ide: remove undefined behavior in ide-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org



On 02/13/2017 10:00 AM, Stefan Hajnoczi wrote:
> On Wed, Feb 08, 2017 at 12:05:33PM -0500, John Snow wrote:
>> trivial: initialize the dirty buffer with a random-ish byte.
>> Stops valgrind from whining about uninitialized buffers.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  tests/ide-test.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/ide-test.c b/tests/ide-test.c
>> index 2fa97bc..139ebc0 100644
>> --- a/tests/ide-test.c
>> +++ b/tests/ide-test.c
>> @@ -550,6 +550,7 @@ static void make_dirty(uint8_t device)
>>  
>>      guest_buf = guest_alloc(guest_malloc, len);
>>      buf = g_malloc(len);
>> +    memset(buf, rand() % 255 + 1, len);
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> 

Thanks.

This can go in through the next TRIVIAL pull, as my queue is otherwise
empty right now.

>>      g_assert(guest_buf);
>>      g_assert(buf);
> 
> Pre-existing issue:
> g_assert(buf) is unnecessary since g_malloc() is guaranteed to return
> non-NULL.
> 

Yeah, I did see that ...
