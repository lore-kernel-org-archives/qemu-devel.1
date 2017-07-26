Received: from eggs.gnu.org ([2001:4830:134:3::10]:52691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daLVF-0004l6-T8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daLVA-0001WD-D6
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daLVA-0001VR-6S
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:33:20 -0400
Message-ID: <1501072390.29903.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 14:33:10 +0200
In-Reply-To: <20170726120529.GG7620@redhat.com>
References: <20170724164601.21063-1-berrange@redhat.com>
	<88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
	<20170725083251.GB26394@redhat.com>
	<1500983620.29790.3.camel@redhat.com>
	<20170726112826.GE7620@redhat.com>
	<1501069447.29903.4.camel@redhat.com>
	<20170726120529.GG7620@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: =?ISO-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-devel@nongnu.org

  Hi,

> FYI, after adding qcodes to the keycodemapdb, (but not having picked
> your branch),

I don't think this is a good idea.  qkeycode numbers are a qemu-private 
thing, they can (and did in the past) change.  The names are api and
must not change.

> I was actually just going add an entry for QKeyCode names to the
> keycodemapdb, so we can convert straight to that, and also let
> us auto-generate the qemu_input_linux_to_qcode() table.

Ok, with the names it should work.

> Strangely there is no Linux key code defined for AltGr, so if we
> map via Linux key codes, we would loose ability to send AltGr

KEY_RIGHTALT?

cheers,
  Gerd
