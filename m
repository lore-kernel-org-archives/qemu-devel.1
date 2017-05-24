Received: from eggs.gnu.org ([2001:4830:134:3::10]:50764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDUXv-0005Mx-7D
	for qemu-devel@nongnu.org; Wed, 24 May 2017 07:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDUXq-0006qX-8C
	for qemu-devel@nongnu.org; Wed, 24 May 2017 07:33:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dDUXq-0006pi-1u
	for qemu-devel@nongnu.org; Wed, 24 May 2017 07:33:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E26A61BB2
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 11:33:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170524112412.GK3873@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 24 May 2017 19:24:12 +0800")
References: <20170524112152.23226-1-quintela@redhat.com>
	<20170524112412.GK3873@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 24 May 2017 13:33:31 +0200
Message-ID: <87wp965w1g.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] migration: Allow unregister of
 save_live handlers
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
> On Wed, May 24, 2017 at 01:21:52PM +0200, Juan Quintela wrote:
>> Migration non save_live handlers have an ops member that is
>> dinamically allocated by migration code.  Save_live handlers have it
>> passed as argument and are responsability of the caller.  Add a new
>> member is_allocated that remembers if ops has to be freed.  This
>> allows unregister_savevm() to work with save_live handlers.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> I thought Laurent will prepare one patch that will directly remove
> existing register_savevm() callers, no?

s390, vmxnet3 and slirp are using it.  I am not sure that we will get
that ones "changed" so easily.

Later, Juan.
