Received: from eggs.gnu.org ([2001:4830:134:3::10]:42226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuUwl-0006cm-D6
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuUwh-0000WJ-5G
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:45:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57454 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuUwh-0000W0-11
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 23:45:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A07085788
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 03:45:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180827223244.30817-1-marcandre.lureau@redhat.com>
Date: Tue, 28 Aug 2018 05:45:29 +0200
In-Reply-To: <20180827223244.30817-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 28 Aug 2018 00:32:44 +0200")
Message-ID: <87wosbqhly.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] editorconfig: set emacs mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Some time ago, I proposed to use an (eval) in .dir-locals.el to set
> the mode for all json files and Makefile. Unfortunately, this isn't
> safe, and emacs will prompt the user, which isn't very friendly.
>
> Fortunately, editorconfig provides a special config key which does
> allow to set the emacs mode. Add a few missing entries and set the
> emacs mode.
>
> Update top comment to provide a short summary about the file and the
> IDE plugins while at it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Markus Armbruster <armbru@redhat.com>
