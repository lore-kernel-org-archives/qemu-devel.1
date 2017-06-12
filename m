Received: from eggs.gnu.org ([2001:4830:134:3::10]:55318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKMhz-0008QS-6H
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKMhv-0006Hw-6m
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:36:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKMhv-0006Hi-0H
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 06:36:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0BC4381252
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 10:36:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170612092934.GG12928@pxdev.xzpeter.org> (Peter Xu's message of
	"Mon, 12 Jun 2017 17:29:34 +0800")
References: <20170601212921.30241-1-quintela@redhat.com>
	<20170601212921.30241-4-quintela@redhat.com>
	<20170612092934.GG12928@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Mon, 12 Jun 2017 12:36:23 +0200
Message-ID: <87efuplcgo.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/11] migration: Split registration
 functions from vmstate.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Jun 01, 2017 at 11:29:13PM +0200, Juan Quintela wrote:
>> They are indpendent, and nowadays almost every device register things
>> with qdev->vmsd.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>> +
>> +int register_savevm(DeviceState *dev,
>> +                    const char *idstr,
>> +                    int instance_id,
>> +                    int version_id,
>> +                    SaveStateHandler *save_state,
>> +                    LoadStateHandler *load_state,
>> +                    void *opaque);
>
> Looks like this patch needs a rebasing since this function is already
> remove...
>
>> +
>> +int register_savevm_live(DeviceState *dev,
>> +                         const char *idstr,
>> +                         int instance_id,
>> +                         int version_id,
>> +                         SaveVMHandlers *ops,
>> +                         void *opaque);
>> +
>> +void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque);
>> +
>> +#endif
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index b95c9bb..6de554d 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -29,53 +29,8 @@
>>  
>>  #include "migration/qjson.h"
>>  
>> -typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
>
> Should be removed too?
>
> Other than mentioned above:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Local copy already have this two bits fixed.  It is just that I posted
this series before that changes got into upstream.

Later, Juan.
