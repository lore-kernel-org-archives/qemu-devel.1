Received: from eggs.gnu.org ([2001:4830:134:3::10]:52873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQvSf-00081r-It
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQvSa-0001EW-4h
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:23:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQvSZ-0001ES-VC
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:23:28 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0FF79C0CD
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 12:23:27 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-13-marcandre.lureau@redhat.com>
Date: Tue, 10 Jan 2017 13:23:25 +0100
In-Reply-To: <20170109143437.30554-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 9 Jan 2017
	15:34:28 +0100")
Message-ID: <87wpe3qf2a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/21] qapi.py: fix line break before
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

PEP 8 permits both, but prefers line break before binary operator.
Thus, this warning is clearly bogus.  What version of pep8 do you use?
Mine doesn't warn.
