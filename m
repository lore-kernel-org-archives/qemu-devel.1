Received: from eggs.gnu.org ([2001:4830:134:3::10]:59617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coXmh-0005bq-B5
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1coXme-0006fd-3q
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1coXmd-0006e2-Tv
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 11:57:48 -0400
Message-ID: <1489679864.15659.125.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 16 Mar 2017 16:57:44 +0100
In-Reply-To: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

  Hi,

> I'm not sure here if we want to just have this as a bald list,
> or to have some kind of two tier setup with OSes we expect to
> dump in one tier and OSes where we're really trolling for a build
> machine in the other tier (the "unlikely to dump" category would
> get most of the BSD variants in it). Putting out a changelog
> that says "we're gonna drop all the BSDs" seems like it might
> produce a lot of yelling?

Maybe we should have two levels of support.  Level one would be "machine
for test builds available", level two would be "someone looking after
it".

At least the freebsd guys have been posting patches to fix freebsd bugs
in the past.  Can't remember a recent post though, dunno whenever that
is because we didn't break anything or because they stopped bothering to
send their ports collection patches upstream.

usb-host support for bsd used to break now and then, but with the switch
to libusb that particular problem area went away a while back ...

cheers,
  Gerd
