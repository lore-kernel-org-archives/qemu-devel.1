Received: from eggs.gnu.org ([209.51.188.92]:51716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gwjF8-0007Qt-Qm
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:58:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gwjF8-0003VF-1e
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:58:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57872)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gwjF7-0003U8-RT
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 02:58:05 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D758681F1B
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 07:58:03 +0000 (UTC)
Date: Thu, 21 Feb 2019 15:57:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190221075759.GA3091@xz-x1>
References: <20190220160628.6555-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190220160628.6555-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] RFC: make chardev context switching
 safer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 20, 2019 at 05:06:24PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi,

Hi,

>=20
> The chardev context switching code is a bit fragile, as it works as if
> the current context is properly synchronized with the new context.  It
> isn't so obvious to me that concurrent usage of chardev can't happen,
> as there might be various main loop sources being dispatched during
> the switch.
>=20
> Worried about the situation, I wrote those patches a while ago, I
> think they are still worth to consider. I used to have some basic
> test, but it now conflicts a lot with recent changes. I would like to
> get some feedback about the series before I rewrite it.
>=20
> The importat patch is "chardev: make qemu_chr_fe_set_handlers()
> context switching safer". It works by "freezing" the given contexts
> while the chardev will "move" (recreate to the new context) the
> various sources it owns. This looks quite ugly to me overall, but still
> safer than today.
>=20
> This should allow to simplify the scary code from "monitor: set the
> chardev context from the main context/thread".

Indeed it's at least not that friendly to readers... so out of
curiosity - is this the only reason for this series?

>=20
> Finally, "char-socket: restart the reconnect timer to switch context"
> shows that we have chardev backends that do not switch fully yet.

This seems irrelevant to the series, or am I wrong?

Thanks,

--=20
Peter Xu
