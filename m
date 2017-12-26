Received: from eggs.gnu.org ([2001:4830:134:3::10]:39138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTfN8-00078U-MI
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 21:53:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eTfN7-000537-SC
	for qemu-devel@nongnu.org; Mon, 25 Dec 2017 21:53:42 -0500
Date: Tue, 26 Dec 2017 10:53:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171226025329.GE9418@lemon>
References: <20171221152628.12942-1-kwolf@redhat.com>
	<CAFEAcA8=SBwRDbfNyuHk3gYCYJCF89---EAeV-Peov458afWJQ@mail.gmail.com>
	<20171222133128.GF3763@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171222133128.GF3763@localhost.localdomain>
Subject: Re: [Qemu-devel] [PULL v2 00/13] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>

On Fri, 12/22 14:31, Kevin Wolf wrote:
> Am 21.12.2017 um 23:47 hat Peter Maydell geschrieben:
> > On 21 December 2017 at 15:26, Kevin Wolf <kwolf@redhat.com> wrote:
> > > The following changes since commit 4da5c51cac8363f86ec92dc99c38f9382d617647:
> > >
> > >   Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2017-12-20' into staging (2017-12-20 20:38:36 +0000)
> > >
> > > are available in the git repository at:
> > >
> > >   git://repo.or.cz/qemu/kevin.git tags/for-upstream
> > >
> > > for you to fetch changes up to af65cdae56861d5e163559a53f7ec34142a249f1:
> > >
> > >   nvme: Add tracing (2017-12-21 16:02:14 +0100)
> > >
> > > ----------------------------------------------------------------
> > > Block layer patches
> > >
> > > ----------------------------------------------------------------
> > 
> > Now I get these warnings on NetBSD/OpenBSD/OSX:
> > 
> >   GEN     qemu-doc.txt
> > /root/qemu/qemu-doc.texi:8: warning: unrecognized encoding name `UTF-8'.
> > /root/qemu//qemu-img.texi:61: warning: unlikely character ( in @var.
> > /root/qemu//qemu-img.texi:61: warning: unlikely character ) in @var.
> 
> Fam, I'm dropping "qemu-img: Document --force-share / -U" from my pull
> request again.
> 
> The problem there seems to be that we're inside of a '@table @var' here.
> People have been careless enough to add options in there, which results
> in less than optimal formatting in the manpage.
> 
> I'd suggest that we split the table in two, first a '@table @var' that
> explains only variables, and after that a proper '@table @option' for
> the options. I suppose (and hope) that in '@table @option', parentheses
> are allowed.

Sounds good. Thank you, v5 sent.

Fam
