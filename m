Received: from eggs.gnu.org ([2001:4830:134:3::10]:56863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eZZ8D-00011j-67
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:26:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eZZ8C-0004Zi-Bg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 04:26:41 -0500
Date: Thu, 11 Jan 2018 10:26:27 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180111092627.2frgbxf4yyijfcsu@eukaryote>
References: <20180105065538.13375-1-famz@redhat.com>
	<20180108144136.GF8052@localhost.localdomain>
	<20180110140349.6ehnffp6hlkyncss@eukaryote>
	<CAMr-obup=EPn2tS1HGUZvFwzMgxgKQMqsAs4bnBp0Y_pvOYhAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMr-obup=EPn2tS1HGUZvFwzMgxgKQMqsAs4bnBp0Y_pvOYhAg@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/2] qemu-img: Let "info" warn
 and go ahead without -U
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Jan 10, 2018 at 04:43:22PM +0000, Nir Soffer wrote:
> On Wed, Jan 10, 2018 at 4:04 PM Kashyap Chamarthy <kchamart@redhat.com>
> wrote:

[...]

> > Yes, for completness' sake, Nova upstream is already patched to use the
> > `qemu-img` '--force-share' flag that comes with QEMU >= 2.10.
> >
> 
> What abut users running released Nova, upgrading to 2.10?

There are three stable Nova branches at any time, in various phases.  

It is already backported to the current newest stable Nova branch (where
all bug fixes that meet certain criteria are accepted).

Then there are two other stable releases.  One is in "Only critical
bugfixes and security patches" phase; the other is in "Only security
patches" phase.  So this change wasn't backported there, and users would
be using QEMU 2.9 or below with those two versions of Nova.

-- 
/kashyap
