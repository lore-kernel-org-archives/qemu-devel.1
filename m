Received: from eggs.gnu.org ([209.51.188.92]:32888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gzJFf-0002ea-Va
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:49:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gzJFf-0003Yz-BA
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:49:19 -0500
Date: Thu, 28 Feb 2019 11:49:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190228104906.GA5563@linux.fritz.box>
References: <20190227144413.30975-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227144413.30975-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] iotests: use iotests.VM in 238
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>

Am 27.02.2019 um 15:44 hat Stefan Hajnoczi geschrieben:
> Test 238 does not require the kvm accelerator.  Using the qtest
> accelerator allows the test to run in both non-kvm and non-tcg
> environments.
> 
> iotests.VM implicitly uses the qtest accelerator and is really the class
> that this test should be using.  Switch to that instead of
> qemu.QEMUMachine.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to the block branch.

Kevin
