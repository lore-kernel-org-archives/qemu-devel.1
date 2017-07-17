Received: from eggs.gnu.org ([2001:4830:134:3::10]:33115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXFRj-0006o5-RR
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dXFRe-0003cj-Ts
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dXFRe-0003bh-NP
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 19:28:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 364CEC0587D4
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 23:28:53 +0000 (UTC)
Date: Tue, 18 Jul 2017 07:28:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170717232850.GF2585@lemon>
References: <20170717063521.GA7393@lemon>
	<20170717103937.GD5301@noname.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170717103937.GD5301@noname.redhat.com>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, 07/17 12:39, Kevin Wolf wrote:
 
> > Q3: What other tests do maintainers want? Different hosts? Different configure
> > combinations?
> 
> Would running qemu-iotests (at least the 'quick' group) be possible or
> would that take too many resources?

As long as it can be done in several minutes on the test machine, we should be
good.

> 
> Only today I noticed again that two recently merged pull requests broke
> qemu-iotests cases, so I must assume that apart from some block
> maintainers, nobody runs it regularly.
> 

This has been on my list for a long time, the difficulty has been the frequent
breakage - I need to enable it when all tests pass, maybe 2.10 freeze is a good
time.

Fam
