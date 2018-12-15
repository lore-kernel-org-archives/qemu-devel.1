Received: from eggs.gnu.org ([2001:4830:134:3::10]:59836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gYEvV-00025D-3h
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 13:44:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gYEvR-0003L7-Ve
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 13:44:37 -0500
Received: from 10.mo68.mail-out.ovh.net ([46.105.79.203]:33866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gYEvR-0003Er-PA
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 13:44:33 -0500
Received: from player746.ha.ovh.net (unknown [10.109.143.223])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 38D041087BF
	for <qemu-devel@nongnu.org>; Sat, 15 Dec 2018 19:44:26 +0100 (CET)
Date: Sat, 15 Dec 2018 19:44:23 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181215194423.776ebdc7@bahia.lan>
In-Reply-To: <CAFEAcA8uMP7LmyUeqzGfOUiP16cu7hrDaYt1jHo94cDOpE0qPQ@mail.gmail.com>
References: <20181213090343.1137475-1-groug@kaod.org>
	<CAFEAcA8uMP7LmyUeqzGfOUiP16cu7hrDaYt1jHo94cDOpE0qPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/3] 9p patches 2018-12-13
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

On Fri, 14 Dec 2018 19:12:07 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Thu, 13 Dec 2018 at 09:03, Greg Kurz <groug@kaod.org> wrote:
> >
> > The following changes since commit bb9bf94b3e8926553290bc9a7cb84315af422086:
> >
> >   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2018-12-11 19:18:58 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/gkurz/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 93aee84f575d46699f49af3c96194012527e0b22:
> >
> >   9p: remove support for the "handle" backend (2018-12-12 14:18:10 +0100)
> >
> > ----------------------------------------------------------------
> > Most notable change in this PR is the full removal of the "handle" fsdev
> > backend.
> >
> > ----------------------------------------------------------------
> > Greg Kurz (3):
> >       9p: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
> >       xen/9pfs: use g_new(T, n) instead of g_malloc(sizeof(T) * n)
> >       9p: remove support for the "handle" backend  
> 
> Applied, thanks.
> 
> Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
> for any user-visible changes.
> 

I've updated https://wiki.qemu.org/ChangeLog/4.0#Incompatible_changes
accordingly.

Cheers,

--
Greg

> -- PMM
