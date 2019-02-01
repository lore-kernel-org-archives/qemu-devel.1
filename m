Received: from eggs.gnu.org ([209.51.188.92]:35135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpYBm-0001O7-Na
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpYBl-0003A8-PR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 07:44:58 -0500
Date: Fri, 1 Feb 2019 13:44:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190201124424.GE5730@localhost.localdomain>
References: <20190131123810.10233-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131123810.10233-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] qtest.py: Wait for the result
 of qtest commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

Am 31.01.2019 um 13:38 hat Alberto Garcia geschrieben:
> The cmd() method of the QEMUQtestProtocol class sends a qtest command
> to QEMU but doesn't wait for the return message ("OK", "FAIL", "ERR").
> Because of this, it can return control to the caller before the
> command has actually finished.
> 
> In cases like clock_step or clock_set this means that cmd() can return
> before all the timers triggered by the clock change have been fired.
> This can be fixed by making cmd() wait for the output of the qtest
> command.
> 
> This fixes iotests 093 and 136, which are flaky since commit
> 8258292e18c39480b64eba9f3551 when the machine is under heavy workload.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
