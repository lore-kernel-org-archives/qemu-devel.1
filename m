Received: from eggs.gnu.org ([2001:4830:134:3::10]:37316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctcn8-0004bm-AM
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctcn4-00049R-Vm
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:19:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ctcn4-00048n-OT
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:19:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C9BA39D0CB
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 16:19:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170329180239.GG2501@work-vm> (David Alan Gilbert's message of
	"Wed, 29 Mar 2017 19:02:39 +0100")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-38-quintela@redhat.com>
	<20170329180239.GG2501@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 30 Mar 2017 18:19:12 +0200
Message-ID: <874lyan3en.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 37/51] ram: Move compression_switch to
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Rename it to preffer_xbzrle that is a more descriptive name.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 6a39704..591cf89 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -217,6 +217,9 @@ struct RAMState {
>>      uint64_t dirty_pages_rate;
>>      /* Count of requests incoming from destination */
>>      uint64_t postcopy_requests;
>> +    /* Should we move to xbzrle after the 1st round
>> +       of compression */
>> +    bool preffer_xbzrle;
>
> That's 'prefer' - however, do we need it at all?
> How about just replacing it by:
>    !ram_bulk_stage && migrate_use_xbzrle()
>
> would that work?

Changed to that.  I am not sure if that is simpler or more complex, but
it is clearly one less variable, so ....

Thanks, Juan.
