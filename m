Received: from eggs.gnu.org ([2001:4830:134:3::10]:55793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJT-0005aW-Vr
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gZCJR-0007TR-CU
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gZCJR-0007T0-5T
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 05:09:17 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181217204046.14861-1-marcandre.lureau@redhat.com>
Date: Tue, 18 Dec 2018 11:09:11 +0100
In-Reply-To: <20181217204046.14861-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 18 Dec 2018 00:40:46 +0400")
Message-ID: <87efafi1tk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi: fix flat union on uncovered branches
 conditionals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Default branches variant should use the member conditional.
>
> This fixes compilation with --disable-replication.
>
> Fixes: 335d10cd8e2c3bb6067804b095aaf6371fc1983e
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Queued, thanks!
