Received: from eggs.gnu.org ([2001:4830:134:3::10]:38199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eb5ae-0000nJ-8t
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eb5ab-0002IE-5j
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:18:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eb5aa-0002Hr-VP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:18:17 -0500
Date: Mon, 15 Jan 2018 15:18:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180115141810.GF32271@localhost.localdomain>
References: <20171205133508.15061-1-danielhb@linux.vnet.ibm.com>
	<20171205133508.15061-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205133508.15061-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/1] tests/qemu-iotests: adding
 savevm/loadvm with postcopy flag test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>

Am 05.12.2017 um 14:35 hat Daniel Henrique Barboza geschrieben:
> This patch implements a test case for the scenario that was failing
> prior to the patch "migration/ram.c: do not set 'postcopy_running' in
> POSTCOPY_INCOMING_END", commit acab30b85d.
> 
> This new test file 201 was derived from the test file 181 authored
> by Kevin Wolf.
> 
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> CC: Cleber Rosa <crosa@redhat.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Thanks, applied to the block branch.

Kevin
