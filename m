Received: from eggs.gnu.org ([2001:4830:134:3::10]:34417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn2KP-0004rH-N3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn2KK-0002lD-P3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:47:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35056 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fn2KK-0002ks-Ig
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:47:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06EAA805A530
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 13:47:08 +0000 (UTC)
Date: Tue, 7 Aug 2018 15:47:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180807134706.il5ckcgdpxpqx32r@sirius.home.kraxel.org>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180803173614.12358-5-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/10] spice: avoid spice runtime assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Aug 03, 2018 at 07:36:08PM +0200, Marc-Andr=E9 Lureau wrote:
> The Spice server doesn't like to be started or stopped twice . It
> aborts with:
>=20
> (process:6191): Spice-ERROR **: 19:29:35.912: red-worker.c:623:handle_d=
ev_start: assertion `!worker->running' failed
>=20
> It's easy to avoid that situation since qemu spice_display_is_running
> tracks the server state.

How do you trigger this?  qemu should not do that in the first place.

cheers,
  Gerd
