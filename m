Received: from eggs.gnu.org ([2001:4830:134:3::10]:40366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linuxram@us.ibm.com>) id 1dmjQQ-0007xp-TD
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linuxram@us.ibm.com>) id 1dmjQM-0008Np-FR
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32882
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linuxram@us.ibm.com>) id 1dmjQM-0008Nf-AS
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:34 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7TGVGMh034856
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 12:31:33 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cn8agvd2v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 12:31:26 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <linuxram@us.ibm.com>;
	Tue, 29 Aug 2017 10:31:17 -0600
Date: Tue, 29 Aug 2017 09:31:07 -0700
From: Ram Pai <linuxram@us.ibm.com>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
	<20170824025448.GA27401@fergus.ozlabs.ibm.com>
	<20170828175356.GB26893@ram.oc3035372033.ibm.com>
	<20170829014030.GD2578@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170829014030.GD2578@umbus.fritz.box>
Message-Id: <20170829163107.GC26893@ram.oc3035372033.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Michael Ellerman <mpe@ellerman.id.au>

On Tue, Aug 29, 2017 at 11:40:30AM +1000, David Gibson wrote:
> On Mon, Aug 28, 2017 at 10:53:56AM -0700, Ram Pai wrote:
> > On Thu, Aug 24, 2017 at 12:54:48PM +1000, Paul Mackerras wrote:
> > > 
> > > We could either have two u16 fields for the number of keys for data
> > > and instruction, or we could have a u32 field for the number of keys
> > > and a separate bit in the flags field to indicate that instruction
> > > keys are supported.  Which would be preferable?
> > 
> > the second choice is more confusion-proof; to me atleast.
> > 
> > The first choice gives a illusion that there are 'x' number of data keys
> > and 'y' number of instruction keys; which is not exactly true.
> 
> Ah.. can you elaborate?

On power8 and power9, there are only 32 keys, each key can be configured to
disable data-access and instruction-access.  The first choice, will
report 32 keys for data-access and 32 keys for instruction-access. To a
casual on-looker it gives an impresssion that there are 32 keys for
data-access and 32 keys for instruction-access; 64 keys in total. And
that is what I think can be the cause for confusion.



RP
