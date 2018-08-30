Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvOOW-0003lc-Dy
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fvOOV-0000im-J3
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:58:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50624 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fvOOV-0000ia-Ce
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:57:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0ADEB26352
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 14:57:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-6-marcandre.lureau@redhat.com>
Date: Thu, 30 Aug 2018 16:57:55 +0200
In-Reply-To: <20180827222322.26009-6-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 28 Aug 2018 00:23:18 +0200")
Message-ID: <87o9djzyto.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] char-fe: set_handlers() needs an
 associted chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> It is futile to call qemu_chr_fe_set_handlers() without an associated
> chardev, because the function is doing nothing in that case, not even
> reporting an error, it would likely be a programming error. Let's not
> handle that hypothetical case.
>
> (fwiw, I introduced the check in commit
> 94a40fc56036b5058b0b194d9e372a22e65ce7be, that was a mistake imho)
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

In your subject, s/associted/associated/.
