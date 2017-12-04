Received: from eggs.gnu.org ([2001:4830:134:3::10]:54929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eLsdw-0004MV-0S
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:26:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eLsdr-00085E-Rm
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:26:52 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eLsdr-00084x-Gr
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 10:26:47 -0500
Date: Mon, 4 Dec 2017 16:26:45 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20171204152645.fy5grsjjn5hedvko@var.youpi.perso.aquilenet.fr>
References: <20171204151705.26028-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA9CYSCJtGjRPQonyA8jvMZ6VBaWbGtrnJ7y6mJEbERMHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9CYSCJtGjRPQonyA8jvMZ6VBaWbGtrnJ7y6mJEbERMHg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] baum braille device update
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

Hello,

Peter Maydell, on lun. 04 déc. 2017 15:21:48 +0000, wrote:
> On 4 December 2017 at 15:17, Samuel Thibault
> <samuel.thibault@ens-lyon.org> wrote:
> > warning: redirection vers https://people.debian.org/~sthibault/qemu.git/
> > The following changes since commit 7edaf99759017d3e175e37cffc3536e86a3bd380:
> >
> >   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2017-11-13 13:54:59 +0000)
> >
> > are available in the Git repository at:
> >
> >   http://people.debian.org/~sthibault/qemu.git tags/samuel-thibault
> >
> > for you to fetch changes up to 15405525fce773d43e7e5cabc2b9ac4b9d4d7672:
> >
> >   baum: Truncate braille device size to 84x1 (2017-12-03 19:35:50 +0100)
> >
> > ----------------------------------------------------------------
> > baum updates
> >
> > ----------------------------------------------------------------
> > Samuel Thibault (1):
> >       baum: Truncate braille device size to 84x1
> 
> Hi. Is this pull request intended for 2.11?

If possible, yes.

> We're currently in freeze for that and only taking "absolutely release
> critical" bug fixes...

Ok, as you wish.

It's a relatively corner case: a friend of mine does have a 88-cell
braille display, and can not use it with guests by running qemu
-usbdevice braille due to this bug.

Samuel
