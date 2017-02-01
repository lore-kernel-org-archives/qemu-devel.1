Received: from eggs.gnu.org ([2001:4830:134:3::10]:41352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYuuT-00026t-Ap
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYuuS-0008BO-IK
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:25:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYuuS-0008BG-CI
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:25:16 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F9B1C057EC9
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 13:25:16 +0000 (UTC)
Message-ID: <1485955513.1076.59.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 01 Feb 2017 14:25:13 +0100
In-Reply-To: <1485852398-2327-1-git-send-email-thuth@redhat.com>
References: <1485852398-2327-1-git-send-email-thuth@redhat.com>
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

On Di, 2017-01-31 at 09:46 +0100, Thomas Huth wrote:
> When compiling with SDL2, the semaphore trick used in sdlaudio.c
> does not work - QEMU locks up completely in this case. To avoid
> the hang and get at least some audio playback up and running (it's
> a little bit crackling, but better than nothing), we can use the
> SDL locking functions SDL_LockAudio() and SDL_UnlockAudio() to sync
> with the sound playback thread instead.

Does SDL_LockAudio work with sdl1 too?
So we can possibly avoid having all those #ifdefs?

cheers,
  Gerd
