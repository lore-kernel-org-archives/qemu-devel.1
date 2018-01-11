Received: from eggs.gnu.org ([2001:4830:134:3::10]:35842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZZJS-0004t6-Gy
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZZJP-0006pa-T4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:38:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZZJP-0006ml-MG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:38:15 -0500
Date: Thu, 11 Jan 2018 10:38:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180111093811.kkoqx2zj6fwd7jms@sirius.home.kraxel.org>
References: <20180107221455.25504-1-patricktsen@gmail.com>
	<20180110163003.GO3205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110163003.GO3205@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/1] input-linux: provide hotkeys for
 evdev toggle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: byxk <patricktsen@gmail.com>, qemu-devel@nongnu.org

  Hi,

> I wonder if it is reasonable for ui/input-linux.c to honour the same
> global '-ungrab' configuration option ?

No.  Problem here is that input-linux is basically sniffing keyboard
input when the host owns the keyboard, so it can't prevent the hotkey
being seen by the host.  Therefore I picked something which (a) has no
side effects (modifier keys only) and (b) is highly unlikely to be used
in normal operation.

cheers,
  Gerd
