Received: from eggs.gnu.org ([2001:4830:134:3::10]:35270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUnZ6-00078I-8H
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUnZ2-0005JE-1p
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:55:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUnYy-0005G6-6g
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 01:55:11 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181205194701.17836-1-danielhb413@gmail.com>
	<20181205194701.17836-3-danielhb413@gmail.com>
Date: Thu, 06 Dec 2018 07:54:59 +0100
In-Reply-To: <20181205194701.17836-3-danielhb413@gmail.com> (Daniel Henrique
	Barboza's message of "Wed, 5 Dec 2018 17:47:00 -0200")
Message-ID: <87y393jgak.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qga: update guest-suspend-ram and
 guest-suspend-hybrid descriptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, imammedo@redhat.com

Daniel Henrique Barboza <danielhb413@gmail.com> writes:

> This patch updates the descriptions of 'guest-suspend-ram' and
> 'guest-suspend-hybrid' to mention that both commands relies now
> on the proper support for wake up from suspend, retrieved by the
> 'wakeup-suspend-support' attribute of the 'query-current-machine'
> QMP command.
>
> Reported-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
