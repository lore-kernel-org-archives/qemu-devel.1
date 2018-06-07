Received: from eggs.gnu.org ([2001:4830:134:3::10]:44941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvsD-0001Ga-OG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:26:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fQvsD-0006VJ-20
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:26:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fQvsC-0006V6-T1
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 10:26:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C0B3401EF14
	for <qemu-devel@nongnu.org>; Thu,  7 Jun 2018 14:26:44 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180529055755.12404-1-peterx@redhat.com>
	<20180529055755.12404-4-peterx@redhat.com>
Date: Thu, 07 Jun 2018 16:26:43 +0200
In-Reply-To: <20180529055755.12404-4-peterx@redhat.com> (Peter Xu's message of
	"Tue, 29 May 2018 13:57:51 +0800")
Message-ID: <87h8meu0yk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 3/7] monitor: more comments on lock-free
 elements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> Add some explicit comments for both Readline and cpu_set/cpu_get helpers
> that they do not need the mon_lock protection.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
