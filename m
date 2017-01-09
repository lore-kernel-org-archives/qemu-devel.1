Received: from eggs.gnu.org ([2001:4830:134:3::10]:37088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQPY1-0007nt-3D
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:18:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cQPXx-0004XQ-VH
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:18:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cQPXx-0004WB-PG
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 21:18:53 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 392633D955
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 02:18:53 +0000 (UTC)
Date: Mon, 9 Jan 2017 10:18:45 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170109021845.GE4135@pxdev.xzpeter.org>
References: <1483675573-12636-1-git-send-email-peterx@redhat.com>
	<20170106132738.GD2461@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170106132738.GD2461@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] VT-d migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Amit Shah <amit.shah@redhat.com>

On Fri, Jan 06, 2017 at 01:27:38PM +0000, Dr. David Alan Gilbert wrote:

[...]

> > (P.S. I found that split irqchip cannot work well with migration. Is
> >  this an known issue?)
> 
> How did it fail?

The keyboard hangs after migration.

Command line for reference:

$qemu -M q35,kernel-irqchip=split -enable-kvm \
      -netdev user,id=net0 \
      -device e1000,netdev=net0 \
      -m 512M -monitor stdio \
      $incoming /var/lib/libvirt/images/vm1.qcow2

Here $incoming is "" for init vm, and "-incoming tcp:0:6666" for the
dest side. Not sure whether this is reproducable issue. Looks like
some EOI ack is missing.

Host: 4.10.0-rc1+ (I should also tried 4.6.4-301.fc24)
Qemu: latest master

Looking into it.

-- peterx
