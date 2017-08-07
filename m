Received: from eggs.gnu.org ([2001:4830:134:3::10]:51057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1deXrj-0005mn-Ch
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 22:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1deXrf-0006W3-73
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 22:33:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57148)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1deXrf-0006Sl-15
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 22:33:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B767C04B930
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 02:26:06 +0000 (UTC)
Date: Mon, 7 Aug 2017 10:26:03 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170807022603.GA28516@lemon>
References: <20170804213625.3756-1-ehabkost@redhat.com>
	<20170805145620.GE14780@lemon>
	<20170805191133.GL3108@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170805191133.GL3108@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/5] qmp-shell non-interactive
 mode, delete scripts/qmp/qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On Sat, 08/05 16:11, Eduardo Habkost wrote:
> On Sat, Aug 05, 2017 at 10:56:20PM +0800, Fam Zheng wrote:
> > On Fri, 08/04 18:36, Eduardo Habkost wrote:
> > > This series adds the ability to run QMP commands
> > > non-interactively to qmp-shell, and deletes scripts/qmp/qmp.
> > 
> > Hmm, not so simple:
> > 
> > $ git grep 'import qmp'
> > scripts/qemu.py:import qmp.qmp
> > scripts/qmp/qemu-ga-client:import qmp
> > scripts/qmp/qmp-shell:import qmp
> > scripts/qtest.py:import qmp.qmp
> > tests/migration/guestperf/engine.py:import qmp.qmp
> 
> I'm deleting scripts/qmp/qmp, not scripts/qmp/qmp.py.

Yeah, OK, I was confused.

Fam
