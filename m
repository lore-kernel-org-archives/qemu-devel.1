Received: from eggs.gnu.org ([2001:4830:134:3::10]:55080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcLu0-00087i-Gk
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 21:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dcLtw-0001hL-Gz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 21:23:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59312
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dcLtw-0001h8-BM
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 21:23:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v711ImvO045746
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 21:23:11 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2c2a86nsa1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 21:23:11 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 31 Jul 2017 21:23:10 -0400
Date: Tue, 1 Aug 2017 09:23:04 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170727015418.85407-4-bjsdjshi@linux.vnet.ibm.com>
	<20170727135910.27d9e42e@gondolin>
	<316dd24e-cc45-8469-dd23-491c8b15480e@linux.vnet.ibm.com>
	<20170727161457.58b3c7d1@gondolin>
	<abdfb954-d67b-d360-1627-b51bac263880@linux.vnet.ibm.com>
	<20170728121101.2a85216a@gondolin>
	<f183e2d8-4f75-2981-e148-02c88014a4b1@linux.vnet.ibm.com>
	<20170728145819.2dd0e608@gondolin>
	<20170731014616.GA10549@bjsdjshi@linux.vnet.ibm.com>
	<20170731104147.51ff1d79@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170731104147.51ff1d79@gondolin>
Message-Id: <20170801012304.GC12259@bjsdjshi@linux.vnet.ibm.com>
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
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, rth@twiddle.net

* Cornelia Huck <cohuck@redhat.com> [2017-07-31 10:41:47 +0200]:

> On Mon, 31 Jul 2017 09:46:17 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > * Cornelia Huck <cohuck@redhat.com> [2017-07-28 14:58:19 +0200]:
> 
> > > Exposing real channel paths to the guest means that the guest OS needs
> > > to be able to deal with path-related things, but OTOH it has more
> > > control. As I don't think we'll ever want to support a guest OS that
> > > does not also run under LPAR, I'd prefer that way.
> > >   
> > My poor English... Sorry, I don't undersatnd the last sentence...
> 
> Probably too many negations... let me rephrase.
Negations kill my brain. ;)

> 
> Looking at the guest OSes we want to support, it's currently Linux,
> Linux, or Linux. And Linux runs fine under LPAR, as it is able to deal
> with the details of channel path handling (and LPAR does not virtualize
> anything of this).
Nod.

> 
> Of the other OSes, z/OS is way too insanely complex, z/VM does not make
> much sense, and I don't see a case for z/TPF either. Which leaves
> z/VSE, which should be able to deal with the path related stuff as well.
Nod.

> 
> So, I don't think we close any doors if we expose the path handling
> complexities to the guest.
> 
Understand now! Thanks a lot!

-- 
Dong Jia Shi
