Received: from eggs.gnu.org ([2001:4830:134:3::10]:34592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceNlA-0003Rd-KI
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:14:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ceNl6-0000wO-QR
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:14:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ceNl6-0000vQ-KT
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 10:14:12 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D406719CBD8
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 15:14:12 +0000 (UTC)
Message-ID: <1487258050.32455.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Feb 2017 16:14:10 +0100
In-Reply-To: <7ba960b7-4235-8036-7f48-974819775292@redhat.com>
References: <1485852398-2327-1-git-send-email-thuth@redhat.com>
	<1485955513.1076.59.camel@redhat.com>
	<7ba960b7-4235-8036-7f48-974819775292@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [RFC PATCH] audio/sdlaudio: Allow audio playback
 with SDL2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Mi, 2017-02-01 at 16:30 +0100, Thomas Huth wrote:
> On 01.02.2017 14:25, Gerd Hoffmann wrote:
> > On Di, 2017-01-31 at 09:46 +0100, Thomas Huth wrote:
> >> When compiling with SDL2, the semaphore trick used in sdlaudio.c
> >> does not work - QEMU locks up completely in this case. To avoid
> >> the hang and get at least some audio playback up and running (it's
> >> a little bit crackling, but better than nothing), we can use the
> >> SDL locking functions SDL_LockAudio() and SDL_UnlockAudio() to sync
> >> with the sound playback thread instead.
> >=20
> > Does SDL_LockAudio work with sdl1 too?
> > So we can possibly avoid having all those #ifdefs?
>=20
> It somehow works, too, but sound quality is - at least for me - much
> worse here than with the semaphore code. Maybe it can be fixed, too, but
> I am really not familiar enough with the QEMU internal audio API to
> figure out how to fix this (e.g. I don't understand why the run_out
> function is called way more often than the callback function, but its
> "live" parameter never reaches the full buffer size).
> So maybe we can start with the #ifdefs for now and remove them once
> somebody figured out how to improve sound quality for SDL1, too? (or
> once we remove support for SDL1 from QEMU completely ... or do we want
> to carry that with us forever?).

Ok, picked as-is for now.  It's better than nothing, and I'm too busy
with other stuff atm to have a closer look myself.

thanks,
  Gerd
