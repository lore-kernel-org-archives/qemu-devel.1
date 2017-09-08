Received: from eggs.gnu.org ([2001:4830:134:3::10]:53623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqESx-00040E-QU
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqESt-0003IE-4V
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqESs-0003HA-Up
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 04:16:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E9728883B4
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 08:16:37 +0000 (UTC)
Date: Fri, 8 Sep 2017 16:16:33 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908081633.GH4511@lemon>
References: <20170907085316.8861-1-famz@redhat.com>
	<20170908081057.GB16888@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170908081057.GB16888@vader>
Subject: Re: [Qemu-devel] [PATCH] buildsys: Move seccomp cflags/libs to per
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, 09/08 10:10, Eduardo Otubo wrote:
> On Thu, Sep 07, 2017 at 04:53:16PM +0800, Fam Zheng wrote:
> > Like many other libraries, libseccomp cflags and libs should only apply
> > to the building of necessary objects. Do so in the usual way with the
> > help of per object variables.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> I'll include in the next pull request. Thanks for the patch.

Great, thanks!

Fam
