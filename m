Received: from eggs.gnu.org ([2001:4830:134:3::10]:40974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3t0-0004TQ-2A
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fb3sv-0001LX-5J
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:01:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fb3sv-0001KP-0r
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 09:01:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8175F401EF04
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 13:01:20 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180705031755.3254-3-peterx@redhat.com> (Peter Xu's message of
	"Thu, 5 Jul 2018 11:17:48 +0800")
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-3-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 05 Jul 2018 15:01:12 +0200
Message-ID: <871sch3kh3.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/9] migration: loosen recovery
 check when load vm
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
> We were checking against -EIO, assuming that it will cover all IO
> failures.  But actually it is not.  One example is that in
> qemu_loadvm_section_start_full() we can have tons of places that will
> return -EINVAL even if the error is caused by IO failures on the
> network.
>
> Let's loosen the recovery check logic here to cover all the error cases
> happened by removing the explicit check against -EIO.  After all we
> won't lose anything here if any other failure happened.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
