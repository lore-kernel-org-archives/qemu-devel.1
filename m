Received: from eggs.gnu.org ([2001:4830:134:3::10]:41577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4VQ-0005Wp-NL
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:15:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4VM-0005YN-VJ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:15:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cS4VM-0005XN-PF
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:15:04 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06E1AC04B926
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 16:15:05 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
	<20170113144135.5150-13-marcandre.lureau@redhat.com>
Date: Fri, 13 Jan 2017 17:15:02 +0100
In-Reply-To: <20170113144135.5150-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 13 Jan 2017 15:41:26 +0100")
Message-ID: <87pojrhr7d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 12/21] qapi.py: fix line break before
 binary operator pep8
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

> Python code style accepts both form, but pep8 complains. Better to clean
> up the single warning for now, so new errors stand out more easily.
>
> Fix scripts/qapi.py:1539:21: W503 line break before binary operator
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I'm dropping this patch, as per review of v7.
