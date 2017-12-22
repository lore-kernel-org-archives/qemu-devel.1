Received: from eggs.gnu.org ([2001:4830:134:3::10]:32803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSMjn-0000To-00
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 07:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSMjm-0001UA-CK
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 07:47:43 -0500
Date: Fri, 22 Dec 2017 13:47:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171222124732.GC3763@localhost.localdomain>
References: <20171215080446.10671-1-famz@redhat.com>
	<20171215080446.10671-3-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171215080446.10671-3-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: Test creating overlay when
 guest running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Am 15.12.2017 um 09:04 hat Fam Zheng geschrieben:
> Signed-off-by: Fam Zheng <famz@redhat.com>

The updated test case passes even without your fix. I can reproduce the
problem manually and verify that patch 1 fixes it, but the test case
seems ineffective.

And having a closer look at the test, this is because the running VM
opened its images read-only.

Kevin
