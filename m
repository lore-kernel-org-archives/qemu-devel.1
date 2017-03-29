Received: from eggs.gnu.org ([2001:4830:134:3::10]:52842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctB2b-0004hA-FC
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctB2Y-0003N3-B6
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:41:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ctB2Y-0003Lj-4u
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 06:41:22 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170328180321.GH5740@work-vm> (David Alan Gilbert's message of
	"Tue, 28 Mar 2017 19:03:21 +0100")
References: <20170323205025.12113-1-quintela@redhat.com>
	<20170328180321.GH5740@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 29 Mar 2017 12:41:19 +0200
Message-ID: <87k278nz5c.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC 0/2] Disable hotplug during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: lizhijian@cn.fujitsu.com, wency@cn.fujitsu.com, qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Hi
>> 
>> This series disable hotplug/unplug during migration.  Thank to Markus
>> for explaining where I had to put the checks.  Why?  Because during
>> migration we will fail if there are changes.  For instance, in
>> postcopy, if we add a memory region, we would failing.  Same for other
>> devices if they are not setup exactly the same on destination.
>> 
>> Iidea would be to disable it, andthen enable for the thing that we know that work.
>> 
>> This series are on top of my previous RAMState v2 serie.
>> 
>> Commets, please?
>
> So I think this is probably a good idea, but we should ask Li Zhijian who added
> migration_bitmap_extend if the reason for adding it was because they
> needed the hot add to work.
> cc'd.

I guess that the problem for them is that the bitmap size was wrong
after memory resizing.  But I don't know if this has ever worked.


> IMHO we really need a 'configuration change mutex' that you can take
> to stop any changes in the VM hardware, and that would probably reduce
> a lot of the places that hold the BQL for just stopping changes.

That was the previous patch.  With that one, you can't add/remove
hardware during migration.

Later, Juan.
