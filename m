Received: from eggs.gnu.org ([2001:4830:134:3::10]:38025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRxdr-0002WD-OC
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gRxdq-0003GJ-NR
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:04:27 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gRxdq-0003FE-G7
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:04:26 -0500
Received: by mail-wr1-x443.google.com with SMTP id p4so25846933wrt.7
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 03:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-5-marcandre.lureau@redhat.com>
	<20180807134706.il5ckcgdpxpqx32r@sirius.home.kraxel.org>
In-Reply-To: <20180807134706.il5ckcgdpxpqx32r@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 28 Nov 2018 15:04:12 +0400
Message-ID: <CAJ+F1CJmMiszLSWd_ED1qf-y_yKKKYb-Vsn2iVBjx3bu2=-dng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

Hi
On Tue, Aug 7, 2018 at 5:48 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Fri, Aug 03, 2018 at 07:36:08PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > The Spice server doesn't like to be started or stopped twice . It
> > aborts with:
> >
> > (process:6191): Spice-ERROR **: 19:29:35.912: red-worker.c:623:handle_d=
ev_start: assertion `!worker->running' failed
> >
> > It's easy to avoid that situation since qemu spice_display_is_running
> > tracks the server state.
>
> How do you trigger this?  qemu should not do that in the first place.

After "[PATCH 06/10] spice: do not stop spice if VM is paused ", you
can pause the VM and resume it (also through spice): it will call
qemu_spice_display_start() twice. The easiest seems to add a check for
spice_display_is_running, with this patch.

--=20
Marc-Andr=C3=A9 Lureau
