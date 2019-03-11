Received: from eggs.gnu.org ([209.51.188.92]:39030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3THU-0001OM-U2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3THS-0001d4-GV
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:20:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:30328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3THR-0001b9-DZ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:20:22 -0400
Date: Tue, 12 Mar 2019 06:19:53 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190311221953.GB27441@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190311083234.20841-1-richardw.yang@linux.intel.com>
	<CAJ+F1CJrUawSKzcCg4yOh8A+Fn0gQXqDtq1Tw14g7jEBBLOZHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJrUawSKzcCg4yOh8A+Fn0gQXqDtq1Tw14g7jEBBLOZHA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] qom: use object_new_with_type in
 object_new_with_propv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, QEMU <qemu-devel@nongnu.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>

On Mon, Mar 11, 2019 at 06:08:10PM +0100, Marc-André Lureau wrote:
>Hi
>
>On Mon, Mar 11, 2019 at 9:34 AM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> Function object_new_with_propv already get the Type of the object, so we
>> could leverage object_new_with_type here.
>>
>> [make check test pass]
>>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  qom/object.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 05a8567041..76d2f1eb2f 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -640,7 +640,7 @@ Object *object_new_with_propv(const char *typename,
>>          error_setg(errp, "object type '%s' is abstract", typename);
>>          return NULL;
>>      }
>> -    obj = object_new(typename);
>> +    obj = object_new_with_type(klass->type);
>>
>>      if (object_set_propv(obj, &local_err, vargs) < 0) {
>>          goto error;
>> --
>> 2.19.1
>>
>>
>
>Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>

Thanks :-)

>-- 
>Marc-André Lureau

-- 
Wei Yang
Help you, Help me
