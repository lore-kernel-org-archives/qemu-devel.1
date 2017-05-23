Received: from eggs.gnu.org ([2001:4830:134:3::10]:43008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDAiY-0004iY-C9
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:23:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDAiT-0004Hc-CC
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:23:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dDAiT-0004HG-6I
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:23:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0BEB8553F
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 14:23:15 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170513033316.22395-1-ehabkost@redhat.com>
	<20170513033316.22395-2-ehabkost@redhat.com>
Date: Tue, 23 May 2017 16:23:08 +0200
In-Reply-To: <20170513033316.22395-2-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Sat, 13 May 2017 00:33:14 -0300")
Message-ID: <87d1az64ab.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qemu.py: Don't set _popen=None on
 error/shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> Keep the Popen object around to we can query its exit code later.
>
> To keep the existing 'self._popen is None' checks working, add a
> is_running() method, that will check if the process is still running.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Looks harmless enough.  Have you tested the scripts using this module
still work?
