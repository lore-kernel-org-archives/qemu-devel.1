Received: from eggs.gnu.org ([2001:4830:134:3::10]:35254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnhju-0003Ft-Qw
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnhjr-0005s5-Oe
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:00:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fnhjr-0005qk-J1
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 06:00:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A604C40216E8
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 10:00:14 +0000 (UTC)
Date: Thu, 9 Aug 2018 12:00:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180809120011.51023bf2@redhat.com>
In-Reply-To: <20180808231636-mutt-send-email-mst@kernel.org>
References: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
	<1533741349-199141-4-git-send-email-imammedo@redhat.com>
	<20180808231636-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] pc: acpi: add _CST support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, 8 Aug 2018 23:17:48 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Aug 08, 2018 at 05:15:48PM +0200, Igor Mammedov wrote:
> > Reuse CPU hotplug IO registers for passing a CST entry
> > containing package for shalowest C1 using mwait and
> > read it out in guest with new CCST AML method.  
> 
> I don't see how 1 entry is enough. We need to describe full _CST package so
> that guest can do reasonable power management on the CPU.
I was assuming that CST are to be used for mwait/monitor idle combo
to help reduce latencies/vmexits on cpus wakeup from idle state, hence 1 entry.
It's trivial to add as much as needed entries though.
If you are fine with approach I can respin patch with arbitrary
number of CStates.
 
> > The CState support is optional and could be turned on
> > with '-global PIIX4_PM.cstate=on' CLI option.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
[...]
