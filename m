Received: from eggs.gnu.org ([2001:4830:134:3::10]:42187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9EdI-0002f9-PJ
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1e9EdE-0002BJ-QC
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 14:17:56 -0400
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-6-vsementsov@virtuozzo.com>
	<20171030173159.GD8941@work-vm>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3ae0a76b-f600-2101-e177-65054345bf7b@virtuozzo.com>
Date: Mon, 30 Oct 2017 21:17:43 +0300
MIME-Version: 1.0
In-Reply-To: <20171030173159.GD8941@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v8 05/14] migration: introduce
 postcopy-only pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

30.10.2017 20:31, Dr. David Alan Gilbert wrote:
> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>> There would be savevm states (dirty-bitmap) which can migrate only in
>> postcopy stage. The corresponding pending is introduced here.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Note the error patchew picked up on this for s390 which has
> cmma_save_pending.
>
> Dave

Thanks for pointing here, I'll update the patch.



-- 
Best regards,
Vladimir
