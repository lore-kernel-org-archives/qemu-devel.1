Received: from eggs.gnu.org ([2001:4830:134:3::10]:41823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dJEIg-0001Sy-K6
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dJEIb-0001EL-JY
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:25:42 -0400
Received: from mailout4.w1.samsung.com ([210.118.77.14]:46476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dJEIb-0001E4-Cp
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 03:25:37 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout4.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OR900GWARAKUY40@mailout4.w1.samsung.com> for
	qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:25:32 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <f38e7d6b-f04b-ac9f-79d3-03b5b6422890@samsung.com>
Date: Fri, 09 Jun 2017 10:25:29 +0300
MIME-version: 1.0
In-reply-to: <20170609071455.GK3628@pxdev.xzpeter.org>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1496828798-27548-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170607094727eucas1p13b2228fead9fc5a49d953985c777b719@eucas1p1.samsung.com>
	<1496828798-27548-3-git-send-email-a.perevalov@samsung.com>
	<20170609041059.GI3628@pxdev.xzpeter.org>
	<b1260f4a-513e-b5c0-2cef-b9b6e0b65d17@samsung.com>
	<20170609071455.GK3628@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v8 02/11] migration: pass
 MigrationIncomingState* into migration check functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com

On 06/09/2017 10:14 AM, Peter Xu wrote:
> On Fri, Jun 09, 2017 at 09:21:38AM +0300, Alexey Perevalov wrote:
>> On 06/09/2017 07:10 AM, Peter Xu wrote:
>>> On Wed, Jun 07, 2017 at 12:46:29PM +0300, Alexey Perevalov wrote:
>>>> That tiny refactoring is necessary to be able to set
>>>> UFFD_FEATURE_THREAD_ID while requesting features, and then
>>>> to create downtime context in case when kernel supports it.
>>>>
>>>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>>>> ---
>>>>   migration/migration.c    |  3 ++-
>>>>   migration/postcopy-ram.c | 10 +++++-----
>>>>   migration/postcopy-ram.h |  2 +-
>>>>   migration/savevm.c       |  2 +-
>>>>   4 files changed, 9 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 48c94c9..2a77636 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -726,6 +726,7 @@ void qmp_migrate_set_capabilities(MigrationCapabilityStatusList *params,
>>>>                                     Error **errp)
>>>>   {
>>>>       MigrationState *s = migrate_get_current();
>>>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>>> If this patch is only servicing patch 6, I'd prefer in patch 6 we call
>>> migration_incoming_get_current() (rather than here), then this patch
>>> may be dropped?...
>> I planed this patch as preparation, I used to separate refactoring from main
>> change, for
>> easy merging while rebasing.
>> mis - is necessary here to have the same behaviour as before.
> Could I ask what's the "same behavior" you mentioned?
I meant no changes in functionality.
>
> I thought this patch is only used by patch 6 when creating the
> blocktime struct (but not really a clean-up), no?
>

-- 
Best regards,
Alexey Perevalov
