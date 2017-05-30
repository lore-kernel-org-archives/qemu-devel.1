Received: from eggs.gnu.org ([2001:4830:134:3::10]:35477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFn7e-0002G6-MU
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dFn7d-0008MU-V6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:48:06 -0400
Date: Tue, 30 May 2017 16:47:56 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170530194756.GP32274@thinpad.lan.raisama.net>
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
	<1496161442-96665-7-git-send-email-imammedo@redhat.com>
	<20170530184022.4d17218a@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170530184022.4d17218a@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 6/7] spapr: cleanup
 spapr_fixup_cpu_numa_dt() usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, May 30, 2017 at 06:40:22PM +0200, Greg Kurz wrote:
> On Tue, 30 May 2017 18:24:01 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > even though spapr_fixup_cpu_numa_dt() has no effect on FDT
> > if numa is disabled, don't call it uselessly. It makes it
> > obvious at call sites that function is need only when numa
> 
> s/need/needed

Fixed while applying the patch.  Thanks!

> 
> > is enabled.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> 
> Reviewed-by: Greg Kurz <groug@kaod.org>
> 

-- 
Eduardo
