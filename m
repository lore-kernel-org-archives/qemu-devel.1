Received: from eggs.gnu.org ([2001:4830:134:3::10]:35632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gDRE8-0005CW-MG
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gDRE4-0001eT-Mz
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:37:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40794)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gDRE4-0001dt-GF
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 05:37:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 52FF973029
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:37:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-38-armbru@redhat.com>
	<20181017134555.GC31479@localhost.localdomain>
	<874ldko4t9.fsf@dusky.pond.sub.org>
Date: Fri, 19 Oct 2018 11:37:45 +0200
In-Reply-To: <874ldko4t9.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 17 Oct 2018 19:34:26 +0200")
Message-ID: <87pnw6qnti.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 37/38] raw: Convert a warning to
 warn_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

I'm dropping this patch for now.

Nice formatting of hints is good.  Consistency is good.  The way to get
both is probably a more structured interface to print hints after
FOO_report().  But this goes beyond what this series tries to do.
