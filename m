Received: from eggs.gnu.org ([2001:4830:134:3::10]:56688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWjnk-0002PR-U4
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWjnh-0000Jn-Mz
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:18:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWjnh-0000JB-GG
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:18:21 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-14-marcandre.lureau@redhat.com>
	<87a7lde1lg.fsf@dusky.pond.sub.org>
Date: Tue, 11 Dec 2018 16:18:13 +0100
In-Reply-To: <87a7lde1lg.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Mon, 10 Dec 2018 18:24:59 +0100")
Message-ID: <874lbkqeh6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 13/27] qapi: add a dictionary
 form for TYPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

New pylint gripes:

scripts/qapi/common.py:674:0: R0912: Too many branches (13/12) (too-many-branches)
scripts/qapi/common.py:764:0: R0912: Too many branches (13/12) (too-many-branches)
scripts/qapi/common.py:838:0: R0912: Too many branches (13/12) (too-many-branches)

That's check_type(), check_union(), check_alternate().  Let's ignore
these for now.
