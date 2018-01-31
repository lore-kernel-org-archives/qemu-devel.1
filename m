Received: from eggs.gnu.org ([2001:4830:134:3::10]:50839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egma9-0004Il-Nl
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egma4-0007OG-0i
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:13:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egma3-0007O2-Q3
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 02:13:15 -0500
Date: Wed, 31 Jan 2018 08:13:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180131071313.r4uhfrwzhpg4p43m@sirius.home.kraxel.org>
References: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
	<20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801291701130.88941@zero.eik.bme.hu>
	<20180130092101.hiuru6lnzbjw2jiy@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801301425250.81470@zero.eik.bme.hu>
	<20180130145858.hczpqjfzdjziosj6@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801302047290.89551@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1801302047290.89551@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

  Hi,

> I think it does not have to be runtime switchable in the sense that the
> setting does not need to be changable during run (like in gtk) because we
> don't have a UI for changing it anyway. It's enough to have an option to
> decide it once at startup, in case that's easier to implement.

Yes, a global switch (so all consoles are in the same mode) is probably
easier to implement.

> If not then I guess this will remain as it is now but it's unfortunate
> to change the previous behaviour with a version change for no good
> reason.

Well, I find it quite useful to see windows side by side.  For example
in case of a multihead setup, or to see vga and serial console at the
same time ...

cheers,
  Gerd
