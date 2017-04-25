Received: from eggs.gnu.org ([2001:4830:134:3::10]:53457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2wKe-0000ZF-PC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d2wKY-0007n1-QJ
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:00:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d2wKY-0007m8-Jf
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:00:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F824B5670
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 09:00:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170418184022.GO2205@work-vm> (David Alan Gilbert's message of
	"Tue, 18 Apr 2017 19:40:22 +0100")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-3-quintela@redhat.com>
	<20170418184022.GO2205@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 25 Apr 2017 11:00:15 +0200
Message-ID: <87d1c0oo9s.fsf@secure.mitica>
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

Dropped the patch.

vmstate.c ends only having the interpreter on it.
