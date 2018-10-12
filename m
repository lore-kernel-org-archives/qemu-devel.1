Received: from eggs.gnu.org ([2001:4830:134:3::10]:52755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAutp-0007Oc-PB
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gAutk-0001Vx-Mj
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gAutk-0001Vg-Gd
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 06:42:24 -0400
Date: Fri, 12 Oct 2018 12:42:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181012104222.vzwu73lanjbelnbl@sirius.home.kraxel.org>
References: <20181009131052.18500-1-lhrazky@redhat.com>
	<20181011122757.gsynkctea7reqnik@sirius.home.kraxel.org>
	<1539263541.16655.110.camel@redhat.com>
	<20181011134336.w55g5ts6kln6cgtt@sirius.home.kraxel.org>
	<1539268208.16655.144.camel@redhat.com>
	<20181011150944.5qfaflgkcekdlz3o@sirius.home.kraxel.org>
	<1539272266.16655.154.camel@redhat.com>
	<20181012092700.np256rvz6octswia@sirius.home.kraxel.org>
	<2078529305.33241973.1539339318932.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2078529305.33241973.1539339318932.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] [RFC PATCH spice 1/2] QXL interface:
 add functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

  Hi,

> > When using qemu_console_get_head() it doesn't work correctly, it would
> > use the qxl card's data.  It would work if spice-server would filter the
> > list to only include the entries for the given display channel before
> > calling the ->client_monitors_config() callback.  But it doesn't, we get
> > the complete set.
> 
> That's why I said is a bug, IMHO it should.

Hmm, this should be easily detectable on qemu side I think.  If
num_of_monitors (for a non-qxl card) is > 1, then we have an old,
non-filtering spice-server.  If num_of_monitors == 1, then it is a new,
filtering spice-server.  Or a single-head channel configuration, in
which case it doesn't matter whenever it filters or not.

So this should be fixable without causing too much compatibility pain.

cheers,
  Gerd
