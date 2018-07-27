Received: from eggs.gnu.org ([2001:4830:134:3::10]:51428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiyyl-0002Tg-S6
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fiyyi-0003lO-Ms
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:24:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fiyyi-0003kM-IH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 05:24:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A690487AAC
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 09:24:03 +0000 (UTC)
Date: Fri, 27 Jul 2018 17:24:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180727092215.GG19416@lemon.usersys.redhat.com>
References: <20180724084739.580-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724084739.580-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: Fix 226 on _my_ system
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Tue, 07/24 16:47, Fam Zheng wrote:
> Something has locked /dev/null on my system (I still don't know what to do with
> the annoying incapability of lslocks, or more precisely /proc/locks, on
> inspecting OFD lock information), and as a result 226 cannot pass due to the
> unexpected image locking error.
> 
> Fix the test case by disabling locking, and add a doc text about using test
> images.
> 
> Fam Zheng (2):
>   docs: Describe using images in writing iotests
>   iotests: Don't lock /dev/null in 226
> 
>  docs/devel/testing.rst | 11 +++++++++++
>  tests/qemu-iotests/226 |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)

Kevin, could you apply this for 3.0 too?

Fam
