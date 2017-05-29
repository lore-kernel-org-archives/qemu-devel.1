Received: from eggs.gnu.org ([2001:4830:134:3::10]:38672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFNmA-0000al-Qs
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFNm5-0004R6-Vj
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dFNm5-0004Q5-PM
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:44:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51FDE448D60
	for <qemu-devel@nongnu.org>; Mon, 29 May 2017 16:44:08 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170526181200.17227-1-ehabkost@redhat.com>
	<20170526181200.17227-2-ehabkost@redhat.com>
Date: Mon, 29 May 2017 18:44:04 +0200
In-Reply-To: <20170526181200.17227-2-ehabkost@redhat.com> (Eduardo Habkost's
	message of "Fri, 26 May 2017 15:11:58 -0300")
Message-ID: <878tlfzk8b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qemu.py: Don't set _popen=None on
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

Reviewed-by: Markus Armbruster <armbru@redhat.com>
