Received: from eggs.gnu.org ([2001:4830:134:3::10]:35413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f8niC-0004Ju-9l
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:05:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f8ni3-0008Nw-OF
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:05:28 -0400
Date: Wed, 18 Apr 2018 15:04:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180418140458.GA2723@work-vm>
References: <16124cce-593c-8191-074c-19164acc3626@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16124cce-593c-8191-074c-19164acc3626@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] Why is there no qom_get in hmp.c?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Max Reitz <mreitz@redhat.com>

* QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
> Hi all,
> I did some investigation and found that "virsh qemu-monitor-command" supports qom-get,
> but qemu hmp doesn't. However, in hmp.c there are qom_list and qom_set. It confused me
> and my question is: why is this? And how can I get a property's value in hmp? e.g.
> qemu-system-* -nodefaults -machine accel=qtest -no-shutdown -nographic -monitor stdio -serial none -hda /root/t.qcow2
> "info qtree" can only get a few properties.

I did try that in 2016 (see my series from about September); but it got
bogged down in trying to fix output visitors; it's possible the visitor
code has been fixed since then though.

The 'Show values and description when using "qom-list"' patch
that Ricardo Perez Blanco posted would do something similar.

Dave

> Thanks a lot!
> -- 
> Regards
> QingFeng Hao
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
