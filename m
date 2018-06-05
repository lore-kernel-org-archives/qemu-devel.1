Received: from eggs.gnu.org ([2001:4830:134:3::10]:42969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQ951-0001Je-3d
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQ94x-0007RY-SG
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:20:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55616 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fQ94x-0007Qn-M9
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:20:39 -0400
Date: Tue, 5 Jun 2018 12:20:37 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180605102037.3f54j2ir4aqrvelr@sirius.home.kraxel.org>
References: <20180221170820.15365-1-kraxel@redhat.com>
	<20180221170820.15365-3-kraxel@redhat.com>
	<78856018-DE4F-42C2-899F-428FE7E55141@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78856018-DE4F-42C2-899F-428FE7E55141@gmail.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/5] kbd-state: add hotkey registry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, peter.maydell@linaro.org

  Hi,

> You say the hotkey is a QKeyCode and a modifier key combined. But it looks like a single QKeyCode would be supported. I would prefer being able to use a single key like F16 to ungrab the mouse. Would that be possible here?
> 
> Kbd_state_hotkey_register(kbd, KBD_HOTKEY_GRAB, Q_KEY_CODE_F16, KBD_MOD_NONE, KBD_MOD_NONE, KBD_MOD_NONE);

Yes, that should work.  I'm working on the series now and then (when I
find some time), latest state is here:

https://git.kraxel.org/cgit/qemu/log/?h=sirius/kbd-state

cheers,
  Gerd
