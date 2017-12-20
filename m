Received: from eggs.gnu.org ([2001:4830:134:3::10]:33129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eRm4O-0004DL-5p
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eRm4J-0002IN-Dw
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:38:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eRm4J-0002Db-7R
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:38:27 -0500
Date: Wed, 20 Dec 2017 19:38:20 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171220213820.GF24025@localhost.localdomain>
References: <20171214040855.22231-1-douly.fnst@cn.fujitsu.com>
	<20171218220901.GE5209@localhost.localdomain>
	<f5057cbf-c699-847a-d219-78a0ba6bff63@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5057cbf-c699-847a-d219-78a0ba6bff63@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [RESEND PATCH for-2.12 0/2] ACPI/unit-test: Add a
 testcase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: imammedo@redhat.com, mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, indou.takao@jp.fujitsu.com

On Tue, Dec 19, 2017 at 12:01:59PM +0800, Dou Liyang wrote:
> Hi Eduardo,
> 
> At 12/19/2017 06:09 AM, Eduardo Habkost wrote:
> > On Thu, Dec 14, 2017 at 12:08:53PM +0800, Dou Liyang wrote:
> > > These are the patches left over from the pull request:
> > > 
> > >    [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
> > > 
> > > because of some errors when tested by "make check" command[1].
> > > 
> > > Now, the QEMU 2.11.0 has been released, rebase/retest/respin them
> > > for v2.12 dev.
> > > 
> > > Changelog:
> > >    --Rebase and retest this patch in v2.11.0
> > >    --Update the DSDT.numamem:
> > > 
> > > [1]: http://lists.gnu.org/archive/html/qemu-devel/2017-10/msg01334.html
> > 
> > Do we know what caused the failures Peter saw, and if we can now
> > be sure it won't happen again?
> 
> Sorry, I can't. I tested it many times with my colleagues, it won't
> happen like Peter saw. This issue is very subtle and funny. Could you
> give me some suggestions?

I guess all we can do is to ask Peter to test if the issue is
still reproducible.

Peter, do you prefer that I just send a regular pull request
asking for testing, or do you prefer to apply this series and
test it manually before I send a pull request?

> 
> BTW, I used "make TEST_ACPI_REBUILD_AML=1 check" to create the DSDT
> file. Is it correct?

This sounds correct to me.  Igor, can you confirm?

-- 
Eduardo
