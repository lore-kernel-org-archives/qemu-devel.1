Received: from eggs.gnu.org ([2001:4830:134:3::10]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e9qPO-00006e-LD
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e9qPK-0007eQ-Ke
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:38:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e9qPK-0007dY-Eb
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:38:02 -0400
Message-ID: <1509532679.3856.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 01 Nov 2017 11:37:59 +0100
In-Reply-To: <20171023210803.20998-2-makovick@gmail.com>
References: <20171023210803.20998-1-makovick@gmail.com>
	<20171023210803.20998-2-makovick@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/7] sdl2: Fix broken display updating
 after the window is hidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>, qemu-devel@nongnu.org

On Mon, 2017-10-23 at 23:07 +0200, Jindrich Makovicka wrote:
> With SDL 2.0.6, calling SDL_ShowWindow during SDL_WINDOWEVENT_HIDDEN
> blocks all subsequent display updates.

Hmm, yes, seems we confuse SDL that way.  Also not letting the user
hide the window isn't very nice (same for the _SHOWN event).  But I
think we should update scon->hidden status on these events, so qemu
keeps track of the state properly and mixing ctrl-alt-<nr> hotkeys and
window buttons for hide/show works correctly.

cheers,
  Gerd
