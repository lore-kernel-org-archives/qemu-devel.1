Received: from eggs.gnu.org ([2001:4830:134:3::10]:37711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fImoJ-0006Zq-PP
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fImoI-0007y3-Mu
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:09:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fImoI-0007xj-Im
	for qemu-devel@nongnu.org; Tue, 15 May 2018 23:09:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 413D8400E9BA
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 03:09:02 +0000 (UTC)
Date: Wed, 16 May 2018 11:08:58 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180516030858.GD9089@xz-mi>
References: <20180515091356.24106-1-peterx@redhat.com>
	<87mux16s9c.fsf@dusky.pond.sub.org> <20180515123827.GB9089@xz-mi>
	<87vaboud3h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87vaboud3h.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-error: introduce error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, May 15, 2018 at 05:56:34PM +0200, Markus Armbruster wrote:

[...]

> I see.
> 
> Add a contract comment (suggest to start with the one next to
> error_report()), expand the tabs, replace the reserved identifiers
> (caught by patchew; you can use foo_ instead of __foo), throw in at
> least one use to serve as a showcase (ideally one demonstrating the
> difference to trace points), and consider working some of your
> additional rationale into your commit message.

Will do.  Thanks Markus.

-- 
Peter Xu
