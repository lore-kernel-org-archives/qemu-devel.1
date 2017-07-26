Received: from eggs.gnu.org ([2001:4830:134:3::10]:50172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daKjg-0006eh-2O
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:44:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1daKjc-0005QA-R3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1daKjc-0005Pm-Ku
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:44:12 -0400
Message-ID: <1501069447.29903.4.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 26 Jul 2017 13:44:07 +0200
In-Reply-To: <20170726112826.GE7620@redhat.com>
References: <20170724164601.21063-1-berrange@redhat.com>
	<88f8a661-f832-1d03-2736-d7b35c920e32@reactos.org>
	<20170725083251.GB26394@redhat.com>
	<1500983620.29790.3.camel@redhat.com>
	<20170726112826.GE7620@redhat.com>
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

> qcodes as currently defined cover only a subset of the AT set1
> scancodes,
> so we need to define countless more qcodes before we consider
> converting
> UIs to use qcodes.
> 
> Aside from the pause/break bug, the changes to ps2 driver to round
> trip
> via qcodes have now made it impossible to send a large number of key
> sequences to the guest OS :-( Admittedly the missing key codes are
> not
> so commonly used, but it is still a notable regression in
> functionality
> today

My keymap branch carries fixes for that now:
https://www.kraxel.org/cgit/qemu/log/?h=work/xkbcommon

For your keycodemapdb patches I'd suggest to cherry-pick at least the
"ui: move qemu_input_linux_to_qcode()" patch.

Then have sdl + gtk generate linux evdev codes using keycodemapdb, map
that to qcodes using qemu_input_linux_to_qcode(), submit qcodes to the
qemu input layer.

cheers,
  Gerd
