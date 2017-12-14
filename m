Received: from eggs.gnu.org ([2001:4830:134:3::10]:44670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePTuG-0008W8-Be
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePTuC-0002fu-9v
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:50:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ePTuC-0002fQ-4S
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:50:32 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-41-marcandre.lureau@redhat.com>
Date: Thu, 14 Dec 2017 14:50:26 +0100
In-Reply-To: <20170911110623.24981-41-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:13 +0200")
Message-ID: <874lot1krh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 40/50] qapi: add -i/--include filename.h
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add a new option to add user-specified #include lines in the generated
> headers. This will help to split a schema, where one generated header
> will depend on another.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

If we need to manage includes manually, then this patch is one way to do
it.  But I'm not sure we need to.  Let me review the remainder of the
series before we analyze this further.
