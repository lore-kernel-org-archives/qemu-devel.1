Received: from eggs.gnu.org ([2001:4830:134:3::10]:38742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcprR-00026n-IR
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fcprO-0006Ae-IA
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fcprO-00069x-Cp
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 06:27:06 -0400
Date: Tue, 10 Jul 2018 07:27:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180710102703.GF7451@localhost.localdomain>
References: <20180704132239.6506-1-douly.fnst@cn.fujitsu.com>
	<20180710094253.0c122846@redhat.com>
	<2052cdff-3dea-1267-3442-39557637b2d4@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2052cdff-3dea-1267-3442-39557637b2d4@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/machine: Remove the Zero check of
 nb_numa_nodes for numa_complete_configuration()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org

On Tue, Jul 10, 2018 at 04:15:30PM +0800, Dou Liyang wrote:
[...]
> > > +    if (nb_numa_nodes)
> > >           machine_numa_finish_cpu_init(machine);
> > > -    }
> > missing curly brackets, should look like:
> >         if (nb_numa_nodes) {
> >             machine_numa_finish_cpu_init(machine);
> >         }
> > 
> > with that fixed
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > 
> 
> Thank you, Igor.
> 
> Due to Eduardo has sent the pull request of this patch,
> Can I fix this and send v2 patch now?

You can fix this on a follow-up patch and CC qemu-trivial.

-- 
Eduardo
