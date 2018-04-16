Received: from eggs.gnu.org ([2001:4830:134:3::10]:34164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f7zSz-0005ck-VJ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f7zSx-0001UB-90
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:26:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56280 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f7zSx-0001TZ-4S
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:26:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 108B881A88A7
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 08:26:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180413161842.5117-1-marcandre.lureau@redhat.com>
	<20180413161842.5117-5-marcandre.lureau@redhat.com>
Date: Mon, 16 Apr 2018 10:26:13 +0200
In-Reply-To: <20180413161842.5117-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 13 Apr 2018 18:18:42 +0200")
Message-ID: <87k1t7sgka.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/4] qobject: modify qobject_ref() to
 assert on NULL and return obj
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Following a discussion on the mailing list:

If a reader of this commit message could profit from reading the
discussion, refer to it by URL and/or Message-Id.  If not, don't mention
it.

>                                             while it may be convenient
> to accept NULL value in qobject_unref() (for similar reasons as free()
> accepts NULL), it is a probably a bad idea to accept NULL argument in
> qobject_ref().

Yes?  What's the patch doing about it?  Peeking ahead: it outlaws it.
So say that.

> Furthermore,

Commit message smell: two things in one patch.  Worth separating them?

>              it is convenient and more clear to call qobject_ref() at
> the time when the reference is associated with a variable, or
> argument. For this reason, make qobject_ref() return the same pointer
> as given.

Not 100% clear whether the patch merely makes the "convenient and more
clear" way possible, or reality.  Peeking ahead: it's the latter.  So
say that.

How did you find the places to change?

Do you think you got them all?

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
