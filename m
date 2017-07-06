Received: from eggs.gnu.org ([2001:4830:134:3::10]:33871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT24C-0002HE-8l
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dT249-00017M-51
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:23:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dT248-00016y-V0
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:23:13 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170601124143.10915-1-marcandre.lureau@redhat.com>
Date: Thu, 06 Jul 2017 10:23:05 +0200
In-Reply-To: <20170601124143.10915-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 1 Jun 2017 16:41:41 +0400")
Message-ID: <87k23m6kk6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] scripts: use build_ prefix for
 string not piped through cgen()
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

> Suggested by Markus Armbruster:

Replacing the line above with ...

> The gen_ prefix is awkward.  Generated C should go through cgen()
> exactly once (see commit 1f9a7a1).  The common way to get this wrong is
> passing a foo=3Dgen_foo() keyword argument to mcgen().  I'd like us to
> adopt a naming convention where gen_ means "something that's been piped
> through cgen(), and thus must not be passed to cgen() or mcgen()".
> Requires renaming gen_params(), gen_marshal_proto() and
> gen_event_send_proto().

Suggested-by: Markus Armbruster <armbru@redhat.com>

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Applied, thanks!
