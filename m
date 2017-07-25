Received: from eggs.gnu.org ([2001:4830:134:3::10]:50577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZou4-0004hh-CU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 21:44:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZou3-0007t3-EI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 21:44:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170724182751.18261-1-f4bug@amsat.org>
	<20170724182751.18261-8-f4bug@amsat.org>
	<92a75f2c-d99c-a4c8-77c4-11898b16fe1b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2cbbd3d3-87b4-a276-079c-b4f2e97385fe@amsat.org>
Date: Mon, 24 Jul 2017 22:44:38 -0300
MIME-Version: 1.0
In-Reply-To: <92a75f2c-d99c-a4c8-77c4-11898b16fe1b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 07/35] qcow2: fix null pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-block@nongnu.org

Hi Eric,

On 07/24/2017 03:46 PM, Eric Blake wrote:
> On 07/24/2017 01:27 PM, Philippe Mathieu-Daudé wrote:
>> If find_bitmap_by_name() fails we have bm=NULL and go to the 'fail' label, then
>> call bitmap_free(bm) which does g_free(bm->name) with bm=NULL...
>>
>> Clang's scan-build-5.0 output:
>> block/qcow2-bitmap.c:492:12: warning: Access to field 'name' results in a dereference of a null pointer (loaded from variable 'bm')
>>      g_free(bm->name);
>>             ^~~~~~~~
>>
>> Reported-by: Clang Static Analyzer
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>   block/qcow2-bitmap.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Max already has a better patch from Vladimir pending on his block queue:
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04398.html

Oh I missed that.
I'm not sure it is "better", it may be safer although ;)

Patch dropped.

Regards,

Phil.
