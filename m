Received: from eggs.gnu.org ([2001:4830:134:3::10]:43367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb40d-00015P-6Q
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb40Z-0003Si-7H
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:09:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35692 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fb40Z-0003Rm-24
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:09:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B9B1C7262D
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:09:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180705031755.3254-10-peterx@redhat.com> (Peter Xu's message of
	"Thu, 5 Jul 2018 11:17:55 +0800")
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-10-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 05 Jul 2018 15:09:06 +0200
Message-ID: <87zhz5zv65.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 9/9] tests: hide stderr for
 postcopy recovery test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> We dumped something when network failure happens.  We should avoid those
> messages to be dumped when running the tests:
>
>   $ ./tests/migration-test -p /x86_64/migration/postcopy/recovery
>   /x86_64/migration/postcopy/recovery: qemu-system-x86_64: check_section_footer: Read section footer failed: -5
>   qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
>   qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
>   OK
>
> After the patch:
>
>   $ ./tests/migration-test -p /x86_64/migration/postcopy/recovery
>   /x86_64/migration/postcopy/recovery: OK
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
