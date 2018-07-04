Received: from eggs.gnu.org ([2001:4830:134:3::10]:52051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadwr-0000Va-8D
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:19:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadwn-0005E0-8f
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:19:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadwn-0005Du-3a
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:19:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF8EC406C7A9
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 09:19:36 +0000 (UTC)
Date: Wed, 4 Jul 2018 17:19:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180704091931.GC2568@xz-mi>
References: <20180704091038.29449-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180704091038.29449-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/3] monitor: allow per-monitor events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Wed, Jul 04, 2018 at 05:10:35PM +0800, Peter Xu wrote:
> This series tries to allow QEMU to send events to specific monitor.
> Markus told me to send this out before I threw the code away, so I
> did.  Testing only covered compilation and qtest to make sure the
> broadcast way should be working at least.
> 
> No real user, no nice testing, no idea on whether it could finally be
> used - it takes the RFC tag then.

This is based on below series:

Subject: [PATCH 0/9] monitor: enable OOB by default

Patchew version:

Based-on: <20180704084507.14560-1-peterx@redhat.com>

-- 
Peter Xu
