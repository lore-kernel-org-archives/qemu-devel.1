Received: from eggs.gnu.org ([2001:4830:134:3::10]:34527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fucqO-00076h-0H
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fucqM-0002RO-4Z
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:11:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fucqK-0002Q2-54
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:11:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180827213943.33524-1-eblake@redhat.com>
	<20180827213943.33524-2-eblake@redhat.com>
Date: Tue, 28 Aug 2018 14:11:29 +0200
In-Reply-To: <20180827213943.33524-2-eblake@redhat.com> (Eric Blake's message
	of "Mon, 27 Aug 2018 16:39:42 -0500")
Message-ID: <87pny2ofm6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi: Minor introspect.py cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eric Blake <eblake@redhat.com> writes:

> Commit 7d0f982b changed generated introspection output to no longer
> produce long lines in the generated .c file, but failed to adjust
> comments to match.  Add some clarity that the shorter length that
> matters most is the overall QMP response on the wire.
>
> Commit 25b1ef31 triggers a pep8 formatting nit.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
