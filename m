Received: from eggs.gnu.org ([2001:4830:134:3::10]:47556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZyUk-0000pa-TX
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dZyUk-000533-60
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:59:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dZyUj-00052U-Vj
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:59:22 -0400
Message-ID: <1500983620.29790.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 25 Jul 2017 13:53:40 +0200
In-Reply-To: <20170725083251.GB26394@redhat.com>
References: <20170724164601.21063-1-berrange@redhat.com>
	<88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
	<20170725083251.GB26394@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.10] ps2: fix sending of PAUSE/BREAK
 scancodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org

  Hi,

> > You're putting some specific code for spice in ps2 emulation.
> > IMO, the workaround should be moved to spice keyboard handling
> > (ui/spice-input.c),
> > which needs to generate a qcode instead of a scancode.
> 
> This isn't really a spice specific hack. QEMU internal code is *not*
> required
> to use qcodes 

qcodes are prefered in new code though.

> - the KeyValue struct is a union that allows use of either qcodes
> or XT scancodes, and the latter is what all the frontends (SPICE,
> VNC, GTk, SDL)
> use. QCodes are really only input by the monitor (the sendkey
> command).

Well, PAUSE is actually sent as qcode by sdl and gtk.  This avoids
special cases in the input layer (PAUSE is the only three scancodes key
sequence).  IMO spice should do the same.  I want switch UIs to qcodes
anyway.

cheers,
  Gerd
