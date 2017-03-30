Received: from eggs.gnu.org ([2001:4830:134:3::10]:51240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctW7Q-0000oO-Qj
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ctW7M-0006T8-Ir
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:11:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ctW7M-0006RN-Ch
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:11:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3948561B85
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 09:11:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170330080334.GB21915@pxdev.xzpeter.org> (Peter Xu's message of
	"Thu, 30 Mar 2017 16:03:34 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-41-quintela@redhat.com>
	<20170330080334.GB21915@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Thu, 30 Mar 2017 11:11:39 +0200
Message-ID: <87y3vnm8ms.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 40/51] ram: Rename qemu_target_page_bits()
 to qemu_target_page_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Mar 23, 2017 at 09:45:33PM +0100, Juan Quintela wrote:
>> It was used as a size in all cases except one.
>
> Considering that:
>
> - qemu_target_page_bits() is only used in migration codes, in only
>   several places below
>
> - migration codes is using TARGET_PAGE_{BITS|SIZE} a lot as well

TARGET_PAGE_* is only defined for target specific files, migration (in
general) is not one of them (ram.c on the other hand is).

Until we exported that function, there wasn't a way to know the
TARGET_PAGE_SIZE in migration.c, for instance.

>
> How about we just remove this function, and directly use
> TARGET_PAGE_{BITS|SIZE}?

We can't.  This was the reason why we used to have exported the sizes in
bytes and in pages.  There are files in qemu that are compiled by
target, and there are files that are compiled the same for all targets.

Later, Juan.
