Received: from eggs.gnu.org ([2001:4830:134:3::10]:36421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJIJi-0000Pu-Pw
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fJIJf-0001Zr-OS
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:47:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fJIJf-0001Yw-Ju
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:47:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B1004067F19
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:47:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180509041734.14135-1-peterx@redhat.com>
	<20180509041734.14135-3-peterx@redhat.com>
Date: Thu, 17 May 2018 14:47:24 +0200
In-Reply-To: <20180509041734.14135-3-peterx@redhat.com> (Peter Xu's message of
	"Wed, 9 May 2018 12:17:32 +0800")
Message-ID: <87y3gila8z.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/4] monitor: protect mon->fds with
 mon_lock
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

> mon->fds were protected by BQL.  Now protect it by mon_lock so that it
> can even be used in monitor iothread.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
