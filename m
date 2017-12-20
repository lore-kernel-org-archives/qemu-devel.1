Received: from eggs.gnu.org ([2001:4830:134:3::10]:38384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eRcZC-0001OT-9F
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:29:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eRcZB-0004c7-EP
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 06:29:42 -0500
Date: Wed, 20 Dec 2017 12:29:30 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20171220112930.wdcvxs5sjfb7e6g6@eukaryote>
References: <2cd24073-b6d9-6479-59b1-869db6c25103@redhat.com>
	<87ind4gxcb.fsf@dusky.pond.sub.org>
	<20171220104436.fzucmsombnpyxoke@eukaryote>
	<20171220105740.GQ21216@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171220105740.GQ21216@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] Raw notes from a small block
 layer/QAPI/something pre-christmas meeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Wed, Dec 20, 2017 at 10:57:40AM +0000, Daniel P. Berrange wrote:
> On Wed, Dec 20, 2017 at 11:44:36AM +0100, Kashyap Chamarthy wrote:
> > On Mon, Dec 18, 2017 at 11:11:00AM +0100, Markus Armbruster wrote:

[...]

> > > Another thought: do we want to give qemu-system-* the necessary
> > > privileges for creating images?  Two cases: running with and without a
> > > guest.
> > 
> > Related: Just curious -- was it an explicit design decision to not give
> > `qemu-system-*` permissions to create disk images?
> 
> Our security model considers QEMU broadly untrustworthy, and so any resources
> it needs to use must either be passed in by libvirt, or have permissions
> explicitly assigned to permit usage by QEMU. QEMU is allowed to create tmp
> files, and create RAM files for memory backing, but in general we don't want
> to have QEMU able to create arbitrary files, only open things that are
> already created.

Ah, true.  Thanks for the reminder about the security architecture.
(Also I realize that libvirt launches QEMU as an unprivileged user,
'qemu', which is part of the defense-in-depth approach, along w/ sVirt
mechanism, etc.)

[...]

-- 
/kashyap
