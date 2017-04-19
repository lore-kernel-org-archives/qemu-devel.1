Received: from eggs.gnu.org ([2001:4830:134:3::10]:51664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0jde-0007U7-Uv
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0jda-00027I-0u
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:02:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0jdZ-000276-RE
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:02:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A09C4F12A4
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 07:02:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170418184022.GO2205@work-vm> (David Alan Gilbert's message of
	"Tue, 18 Apr 2017 19:40:22 +0100")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-3-quintela@redhat.com>
	<20170418184022.GO2205@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 19 Apr 2017 09:02:47 +0200
Message-ID: <87fuh4hobs.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/19] migration: They are called
 vmstate_foo, move them to vmstate.c
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
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/savevm.c  | 17 -----------------
>>  migration/vmstate.c | 16 ++++++++++++++++
>>  2 files changed, 16 insertions(+), 17 deletions(-)
>
> OK, but it's a little odd, savevm.c still has the vmstate_register_with_alias_id
> and vmstate-unregister,  so this is just the simple ram cases.

This are the easy bits, for others I need to rearrange headers elsewhere.

Thanks, Juan.
