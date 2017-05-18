Received: from eggs.gnu.org ([2001:4830:134:3::10]:37711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBLAE-0005eN-BB
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dBLA9-0007nS-DG
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dBLA9-0007nM-6l
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05600C04B936
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 13:08:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170518121921.GE2467@work-vm> (David Alan Gilbert's message of
	"Thu, 18 May 2017 13:19:21 +0100")
References: <20170518111837.29212-1-quintela@redhat.com>
	<20170518111837.29212-6-quintela@redhat.com>
	<20170518121921.GE2467@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 18 May 2017 15:08:12 +0200
Message-ID: <87d1b69utf.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/5] block migration: Allow compile time
 disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, eblake@redhat.com, armbru@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> 
>> Many users now prefer to use drive_mirror over NBD as an
>> alternative to the older migrate -b option; drive_mirror is
>> more complex to setup but gives you more options (e.g. only
>> migrating some of the disks if some of them are shared).
>> 
>> Allow the large chunk of block migration code to be compiled
>> out for those who don't use it.
>> 
>> Based on a downstream-patch we've had for a while by Jeff Cody.
>> 
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>
> Yes, I think that looks OK, but you lost your S-o-b for your changes.

git decided that the patch is still yours.

Will add my S-o-b.  Thanks.

Later, Juan.
