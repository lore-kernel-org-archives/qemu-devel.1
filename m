Received: from eggs.gnu.org ([2001:4830:134:3::10]:47797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcL3F-00045E-Mp
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 21:33:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fcL3E-0004On-TH
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 21:33:17 -0400
Date: Mon, 9 Jul 2018 09:33:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180709013303.GB14487@lemon.usersys.redhat.com>
References: <20180705073701.10558-1-famz@redhat.com>
	<20180705073701.10558-10-famz@redhat.com>
	<88257975-71f6-ebe9-4888-9134e786d040@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88257975-71f6-ebe9-4888-9134e786d040@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 9/9] block: Use common write req
 handling in truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, 07/06 17:12, Eric Blake wrote:
> On 07/05/2018 02:37 AM, Fam Zheng wrote:
> > Truncation is the last to convert from open coded req handling to
> > reusing helpers. This time the permission check in prepare has to adapt
> > to the new caller: it checks a different permission bit, and don't
> 
> did you mean "won't" or "doesn't"?

Yeah, "doesn't'. Thanks!

Fam
