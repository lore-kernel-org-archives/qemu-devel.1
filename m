Received: from eggs.gnu.org ([2001:4830:134:3::10]:42305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMV3Y-00035m-5u
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMV3T-0003Js-9P
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:27:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1eMV3T-0003Ix-2p
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 03:27:47 -0500
Date: Wed, 6 Dec 2017 09:27:43 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171206082743.GB4207@localhost.localdomain>
References: <20171204151741.14485-1-danielhb@linux.vnet.ibm.com>
	<20171204151741.14485-2-danielhb@linux.vnet.ibm.com>
	<20171205180612.GB2969@work-vm>
	<3b62cb3c-11d4-6215-1e14-b1abb9ba59d5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b62cb3c-11d4-6215-1e14-b1abb9ba59d5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] tests/qemu-iotests: adding
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>

Am 05.12.2017 um 20:31 hat Daniel Henrique Barboza geschrieben:
> On 12/05/2017 04:06 PM, Dr. David Alan Gilbert wrote:
> > * Daniel Henrique Barboza (danielhb@linux.vnet.ibm.com) wrote:
> > > This patch implements a test case for the scenario that was failing
> > > prior to the patch "migration/ram.c: do not set 'postcopy_running' in
> > > POSTCOPY_INCOMING_END", commit acab30b85d.
> > > 
> > > This new test file 201 was derived from the test file 181 authored
> > > by Kevin Wolf.
> > The test is interesting because it enables postcopy but never triggers
> > postcopy entry (using migrate_start_postcopy).  Still it's a good path
> > to check.
> > 
> > It will fail to enable postcopy on older linux hosts or non-linux hosts
> > that don't have userfault though; I'm not sure how your test fails
> > with that.
> Hmmm I am not sure either. I have tested it with Travis and it passed all
> tests,
> including a claimed Mac OS environment. Not sure if that counts.
> 
> I'll see if I can get this tested on a Windows env to see how this test
> fails.

qemu-iotests is basically Linux-only and we don't even try to keep
things portable. If it works on Windows, that's more by accident than
intentional.

Kevin
