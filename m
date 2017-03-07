Received: from eggs.gnu.org ([2001:4830:134:3::10]:54364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clBt1-00044y-HF
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clBsW-0007SN-CL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 04:58:31 -0500
Date: Tue, 7 Mar 2017 17:57:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170307095724.GG29283@lemon.lan>
References: <20170307025328.53409-1-haoqf@linux.vnet.ibm.com>
	<20170307025328.53409-2-haoqf@linux.vnet.ibm.com>
	<20170307092951.GA5871@noname.str.redhat.com>
	<20170307094154.GB2869@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170307094154.GB2869@work-vm>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] vmstate: draft fix for failed
 iotests case 68 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, mreitz@redhat.com, quintela@redhat.com

On Tue, 03/07 09:41, Dr. David Alan Gilbert wrote:
> > This is really a live migration fix, so I'm adding Juan and Dave to CC.
> > 
> > I suspect the real question is why a field with size 0 was even stored
> > in the vmstate to begin with.
> 
> Yes; which field is it that's failing?

See Qingfeng's other reply in this thread. It is irqstate.

Fam
