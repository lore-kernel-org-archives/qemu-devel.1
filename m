Received: from eggs.gnu.org ([209.51.188.92]:34941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glag2-00009n-Sc
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:35:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glag0-0004xY-Sr
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:35:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glag0-0004x1-Mv
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:35:48 -0500
Date: Mon, 21 Jan 2019 15:35:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190121143545.su4ondup4a7go2h5@sirius.home.kraxel.org>
References: <154107832062.28716.3850477436321808708.malonedeb@soybean.canonical.com>
	<154807353706.28438.6153701841246987263.malone@chaenomeles.canonical.com>
	<CAFEAcA9uJ7+T64u1HSztCweJhqEDpctmohFnmCyKRD8B_sLnzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9uJ7+T64u1HSztCweJhqEDpctmohFnmCyKRD8B_sLnzg@mail.gmail.com>
Subject: Re: [Qemu-devel] [Bug 1801073] Re: util/zbin.c:390:37: error:
 absolute value function 'abs' given an argument of type 'long int' but has
 parameter of type 'int' which may cause truncation of value
 [-Werror=absolute-value]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Bug 1801073 <1801073@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, Jan 21, 2019 at 12:57:16PM +0000, Peter Maydell wrote:
> On Mon, 21 Jan 2019 at 12:47, Martin Liska <mliska@suse.cz> wrote:
> >
> > Should be fixed here:
> > http://git.ipxe.org/ipxe.git/commitdiff/956f6a722
> >
> > Btw. how do you pull changes from ipxe into qemu repo?
> 
> The next step is a QEMU patch which updates our git submodule
> to point at a version of IPXE with the fix and also has the
> pre-built binaries corresponding to that new version.
> 
> Gerd, it looks like you did the last IPXE update -- could
> we do another one with this fix in it?

Yes, makes sense to do that, last ipxe rebase was more than a year ago.

cheers,
  Gerd
