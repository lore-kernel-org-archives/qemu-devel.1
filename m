Received: from eggs.gnu.org ([209.51.188.92]:34355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1griXy-0005a9-8k
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1griXw-0005Hu-81
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:12:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1griXo-0005Dw-5P
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:12:43 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CE3F089AF9
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 12:12:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <d3c2373f-89cf-dc2f-472e-180ddcaaa64e@redhat.com> (Laurent
	Vivier's message of "Wed, 6 Feb 2019 20:00:46 +0100")
References: <20190206132331.1694-1-quintela@redhat.com>
	<20190206132331.1694-3-quintela@redhat.com>
	<3beec7d3-7a57-30be-affb-c68caa713a60@redhat.com>
	<87zhr8er47.fsf@trasno.org>
	<d3c2373f-89cf-dc2f-472e-180ddcaaa64e@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 07 Feb 2019 13:15:22 +0100
Message-ID: <8736ozg5gl.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/4] multifd: Drop x-multifd-page-count
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Laurent Vivier <lvivier@redhat.com> wrote:
> On 06/02/2019 18:58, Juan Quintela wrote:
>> Laurent Vivier <lvivier@redhat.com> wrote:
>>> On 06/02/2019 14:23, Juan Quintela wrote:
>>>> Libvirt don't want to expose (and explain it).  And testing looks like
>>>> 128 is good for all use cases, so just drop it.
>>>>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> ---
>>>>  hmp.c                 |  7 -------
>>>>  migration/migration.c | 30 ------------------------------
>>>>  migration/migration.h |  1 -
>>>>  migration/ram.c       | 13 ++++++++-----
>>>>  qapi/migration.json   | 13 +------------
>>>>  5 files changed, 9 insertions(+), 55 deletions(-)
>>>>
>>> ...
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index f673486679..65df9b566e 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -81,7 +81,6 @@
>>>>  /* The delay time (in ms) between two COLO checkpoints */
>>>>  #define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>>>>  #define DEFAULT_MIGRATE_MULTIFD_CHANNELS 2
>>>> -#define DEFAULT_MIGRATE_MULTIFD_PAGE_COUNT 128
>>>
>>> Why do you update it in the previous patch to remove it in this one?
>> 
>> To make clear that I change the default.  Otherwise it gets hidden into
>> the whole patch.  if you preffer I could have done the other way around.
>
> OK, I understand. It's not really clear because the new default
> (MULTIFD_PAGE_COUNT) is hidden in the patch.
>
> Moreover, in the first patch you update the value, but you don't update
> the comments in qapi/migration.json (I've seen that because you remove
> them in this patch).

Aha, I knew I was forgetting something.

> Perhaps you can proceed in the reverse order: remove the parameter and
> then set the new default... or merge the two patches and saying in the
> commit message you change the default value.

Ok.

> Thanks,
> Laurent

Later, Juan.
