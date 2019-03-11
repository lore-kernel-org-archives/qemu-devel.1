Received: from eggs.gnu.org ([209.51.188.92]:47933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3J4Q-00067P-5U
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3Iro-00088D-3C
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 07:13:13 -0400
Date: Mon, 11 Mar 2019 12:06:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190311110631.GC7899@localhost.localdomain>
References: <1545387387-9613-1-git-send-email-baiyaowei@cmss.chinamobile.com>
	<20190306215633.GM6818@localhost.localdomain>
	<20190307084405.GB26350@byw>
	<20190307112505.GB5786@linux.fritz.box> <20190308072230.GA9529@byw>
	<20190308100826.GB5339@localhost.localdomain>
	<20190309014648.GA28010@byw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309014648.GA28010@byw>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] tcmu: Introduce qemu-tcmu
 utility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Amar Tumballi <atumball@redhat.com>, Mike Christie <mchristi@redhat.com>, Prasanna Kalever <pkalever@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Xiubo Li <xiubli@redhat.com>, Fam Zheng <fam@euphon.net>, stefanha <stefanha@redhat.com>

Am 09.03.2019 um 02:46 hat Yaowei Bai geschrieben:
> Thanks for explaining the background. It comes to my mind that actually we
> talked about these two cases with Fam a bit long time ago and decided to
> support both these two cases. The reason why we implement case2 first is
> currently we care more about exporting new opened images and it's a bit
> more convenient, exporting from a VM or QMP can be added in the later
> release. Do you think it's reasonable/acceptable that we support both
> cases and use case2 for normal new opened images and case1 for the
> circumstances you mention above?

I would like to avoid a second code path because it comes with a
maintenance cost.

Experience also tells that adding a new way to parse option strings will
come back at us later because it we must always maintain compatibility
with yet another format.

So I would prefer not doing this and just passing command line options
to qemu-tcmu, which can reuse the already existing code paths.

Kevin
