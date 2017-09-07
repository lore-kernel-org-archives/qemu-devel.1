Received: from eggs.gnu.org ([2001:4830:134:3::10]:38981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpx9d-0001DH-MO
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpx9Z-00040K-7f
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:47:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpx9Z-0003yl-1e
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:47:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F88A356DB
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 13:47:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1504771369.git.mprivozn@redhat.com>
Date: Thu, 07 Sep 2017 15:47:29 +0200
In-Reply-To: <cover.1504771369.git.mprivozn@redhat.com> (Michal Privoznik's
	message of "Thu, 7 Sep 2017 10:05:23 +0200")
Message-ID: <87vaku62oe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 0/3] watchdog.h: Drop local redefinition
 of actions enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org

Michal Privoznik <mprivozn@redhat.com> writes:

> diff to v4:
> - in 3/3 compare passed action string case insensitively to the qapi enum

In 2/3, actually.

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>
