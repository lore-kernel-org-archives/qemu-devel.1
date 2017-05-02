Received: from eggs.gnu.org ([2001:4830:134:3::10]:38723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5W3e-0003r5-BR
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5W3b-00018b-7V
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5W3b-00017a-0y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:33:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9FCEFD1ED
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 11:33:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170427223628.20893-1-jsnow@redhat.com>
Date: Tue, 02 May 2017 13:33:21 +0200
In-Reply-To: <20170427223628.20893-1-jsnow@redhat.com> (John Snow's message of
	"Thu, 27 Apr 2017 18:36:28 -0400")
Message-ID: <87h913o5mm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3] qmp-shell: add persistent command
 history
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org

John Snow <jsnow@redhat.com> writes:

> Use the existing readline history function we are utilizing
> to provide persistent command history across instances of qmp-shell.
>
> This assists entering debug commands across sessions that may be
> interrupted by QEMU sessions terminating, where the qmp-shell has
> to be relaunched.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Applied to qapi-next, thanks!
