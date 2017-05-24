Received: from eggs.gnu.org ([2001:4830:134:3::10]:47399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDQYh-0000z3-EX
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:18:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDQYd-0008WV-L5
	for qemu-devel@nongnu.org; Wed, 24 May 2017 03:18:14 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170524063617.GX30246@umbus.fritz.box> (David Gibson's message
	of "Wed, 24 May 2017 16:36:17 +1000")
References: <1495601614-18586-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495601614-18586-2-git-send-email-bharata@linux.vnet.ibm.com>
	<87a8627opg.fsf@secure.mitica>
	<20170524063617.GX30246@umbus.fritz.box>
Reply-To: quintela@redhat.com
Date: Wed, 24 May 2017 09:18:08 +0200
Message-ID: <8760gq7mfj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/3] migration: Introduce
 unregister_savevm_live()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com, sjitindarsingh@gmail.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

David Gibson <david@gibson.dropbear.id.au> wrote:
> On Wed, May 24, 2017 at 08:28:59AM +0200, Juan Quintela wrote:
>> Bharata B Rao <bharata@linux.vnet.ibm.com> wrote:
>> > Introduce a new function unregister_savevm_live() to unregister the vmstate
>> > handlers registered via register_savevm_live().
>> >
>> > register_savevm() allocates SaveVMHandlers while register_savevm_live()
>> > gets passed with SaveVMHandlers. During unregistration, we  want to
>> > free SaveVMHandlers in the former case but not free in the latter case.
>> > Hence this new API is needed to differentiate this.
>> >
>> > This new API will be needed by PowerPC to unregister the HTAB savevm
>> > handlers.
>> >
>> > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
>> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> > Cc: Juan Quintela <quintela@redhat.com>
>> > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> 
>> Hi
>> 
>> How about this one?
>> I just test compiled it.
>> 
>> Advantage from my point of view is that we always do the right thing.
>> And as migration code already knows if it has to be freed or not, I
>> think it is a better API.
>> 
>> What do you think?
>
> I think this is a better approach.  Do you want to push this one
> directly, Juan, or do you want me to take it through my tree?

I will push it on my next pull request.  I mean, I will send it for
review on own top level.

Thanks, Juan.
