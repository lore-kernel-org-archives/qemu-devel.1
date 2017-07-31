Received: from eggs.gnu.org ([2001:4830:134:3::10]:57725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dbzmv-0002Bf-MI
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 21:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dbzms-00025y-Ir
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 21:46:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dbzms-000250-8z
	for qemu-devel@nongnu.org; Sun, 30 Jul 2017 21:46:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6V1hS5x039464
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 21:46:24 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c1rc0d3ng-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 30 Jul 2017 21:46:23 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 30 Jul 2017 21:46:22 -0400
Date: Mon, 31 Jul 2017 09:46:17 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-1-bjsdjshi@linux.vnet.ibm.com>
	<20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<316dd24e-cc45-8469-dd23-491c8b15480e@linux.vnet.ibm.com>
	<20170727161457.58b3c7d1@gondolin>
	<abdfb954-d67b-d360-1627-b51bac263880@linux.vnet.ibm.com>
	<20170728121101.2a85216a@gondolin>
	<f183e2d8-4f75-2981-e148-02c88014a4b1@linux.vnet.ibm.com>
	<20170728145819.2dd0e608@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170728145819.2dd0e608@gondolin>
Message-Id: <20170731014616.GA10549@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x/css: generate channel path
 initialized CRW for channel path hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, rth@twiddle.net

* Cornelia Huck <cohuck@redhat.com> [2017-07-28 14:58:19 +0200]:

[...]

> > 
> > If I understand you correctly it ain't possible to handle these
> > in the host (and let the guest a simple 'non-real' virtual
> > channel path whose reliability depends on what the host does),
> > or?
> 
> It is possible. Mapping to a virtual channel path or not is basically a
> design decision (IIRC, z/VM supports both).
> 
> Mapping everything to a virtual chpid basically concentrates all
> path-related handling in the hypervisor. This allows for a dumb guest
> OS, but can make errors really hard to debug from the guest side.
I understood this.

> 
> Exposing real channel paths to the guest means that the guest OS needs
> to be able to deal with path-related things, but OTOH it has more
> control. As I don't think we'll ever want to support a guest OS that
> does not also run under LPAR, I'd prefer that way.
> 
My poor English... Sorry, I don't undersatnd the last sentence...

[...]

-- 
Dong Jia Shi
