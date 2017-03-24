Received: from eggs.gnu.org ([2001:4830:134:3::10]:49906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1crSKn-000531-2a
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1crSKj-00076d-Vl
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:45:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6995)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1crSKj-00076F-QP
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 12:45:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8C02D4E4CD
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 16:45:01 +0000 (UTC)
Date: Fri, 24 Mar 2017 17:44:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170324164457.GA3823@noname.redhat.com>
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
	<20170323203819.GH5344@noname.redhat.com>
	<87lgrvyy6l.fsf@dusky.pond.sub.org>
	<87lgrvw06q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgrvw06q.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: jdurgin@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, jcody@redhat.com

Am 24.03.2017 um 09:25 hat Markus Armbruster geschrieben:
> Post 2.9, we should either finish the QAPIfication of block
> configuration we started with blockdev-add, or back it out, i.e. make
> the QAPI schema accept anything, and rely on the QemuOpts-based
> checking.
> 
> I want us to finish QAPIfication.

So our next task is probably getting us a way to have options in QAPI
that aren't exposed in QMP. You added some of these non-QMP options to a
block driver yourself only recently, so you probably already know of and
understand the need for it. If we ever get QAPI for the command line,
this might actually be a third set because I think we have some options
that are only meant to be set internally, but never from either QMP or
the command line.

Once we have support from QAPI to consider the context when parse
structs (i.e. reject non-QMP fields when parsing QMP commands), we can
look into converting the block layer step by step. I'm not sure if this
is the only problem we have (I would be surprised if it were), but it's
the big one that I know of.

Kevin
