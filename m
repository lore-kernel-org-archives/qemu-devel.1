Received: from eggs.gnu.org ([2001:4830:134:3::10]:42899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cGOkl-0000cv-Vq
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:26:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cGOki-0003dT-1U
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:26:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cGOkh-0003cy-OK
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 06:26:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBCBP3qr093878
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 06:26:38 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 279qqcgxwk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 06:26:38 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 12 Dec 2016 11:26:34 -0000
Date: Mon, 12 Dec 2016 12:26:26 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20161209200650.GB29563@thinpad.lan.raisama.net>
References: <148104617887.7699.984921868108236415.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<20161206191952.GD4027@thinpad.lan.raisama.net>
	<20161206193159.GE4027@thinpad.lan.raisama.net>
	<20161207143925.7b3a54f2@bahia>
	<20161209200650.GB29563@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161212122626.20a63c82.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC for-2.8] machine: Convert abstract typename
 on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 9 Dec 2016 18:06:50 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Now my question is: what should we do in 2.8.1?
> 
> 1) Change the rules and apply "[PATCH] qdev: fix the order compat
>    and global properties are applied"

I don't think changing the rules is something that should be done for a
stable release.

> 2) Fix only virtio-pci (apply a new version of "[PATCH] virtio:
>    fix HW_COMPAT_2_6 macro for virtio-*-pci drivers")

This has the benefit of fixing exactly one problem in an easily
reviewable patch...

> 3) Apply this hack so we fix all compat_props cases without
>    changing ordering rules. (And then change the ordering rules
>    in 2.9)

...while this has the benefit of fixing the complete class of problems.

I'd say 2 or 3, but I'd favour 3. 2.8.1 will not be released next week,
so we have enough time to verify that we don't introduce any new
breakage.
