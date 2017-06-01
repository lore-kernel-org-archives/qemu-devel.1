Received: from eggs.gnu.org ([2001:4830:134:3::10]:54850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGKfZ-0003lX-98
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dGKfY-0007BL-D1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 03:37:21 -0400
MIME-Version: 1.0
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
	<20170503223846.6559-6-marcandre.lureau@redhat.com>
	<CAJ+F1CJBs_uqCNbrj4iS94p-04OC3f3_2GZ8sUichC_h=9PHbg@mail.gmail.com>
In-Reply-To: <CAJ+F1CJBs_uqCNbrj4iS94p-04OC3f3_2GZ8sUichC_h=9PHbg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 01 Jun 2017 07:37:07 +0000
Message-ID: <CAJ+F1C+yP2fGyrNsBc_9fizw75SF_6W1zZATNXAnCZoi2cgpgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 5/5] dump: fix memory_mapping_filter leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, wencongyang@gmail.com, qemu trival <qemu-trivial@nongnu.org>

On Fri, May 26, 2017 at 3:03 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Thu, May 4, 2017 at 2:42 AM Marc-Andr=C3=A9 Lureau <
> marcandre.lureau@redhat.com> wrote:
>
>> Spotted by ASAN.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  memory_mapping.c | 1 +
>>
>
> No maintainer for this file, Wen, Paolo?
>

CC qemu-trivial

thanks


>
>
>
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/memory_mapping.c b/memory_mapping.c
>> index 6a39d71da2..a5d38552a6 100644
>> --- a/memory_mapping.c
>> +++ b/memory_mapping.c
>> @@ -337,6 +337,7 @@ void memory_mapping_filter(MemoryMappingList *list,
>> int64_t begin,
>>          if (cur->phys_addr >=3D begin + length ||
>>              cur->phys_addr + cur->length <=3D begin) {
>>              QTAILQ_REMOVE(&list->head, cur, next);
>> +            g_free(cur);
>>              list->num--;
>>              continue;
>>          }
>> --
>> 2.12.0.191.gc5d8de91d
>>
>>
>> --
> Marc-Andr=C3=A9 Lureau
>
--=20
Marc-Andr=C3=A9 Lureau
