Received: from eggs.gnu.org ([2001:4830:134:3::10]:60870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGnvR-0003Y6-J6
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dGnvM-0006AU-Nd
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:51:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dGnvM-0006AF-IA
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:51:36 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8350FC057EC9
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:51:35 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-22-marcandre.lureau@redhat.com>
Date: Fri, 02 Jun 2017 16:51:31 +0200
In-Reply-To: <20170531135709.345-22-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Wed, 31 May 2017 17:56:45 +0400")
Message-ID: <871sr2a1e4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 21/45] qdev: use appropriate
 getter/setters type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Based on underlying property type, use the appropriate getters/setters.

Well, the getter and setter is the closest thing to a property type QOM
has.  Do you mean the type of the data accessed by the getter and
setter?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Patch looks okay.
