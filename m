Received: from eggs.gnu.org ([2001:4830:134:3::10]:36757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8ivc-00053q-2Z
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d8ivY-0001kF-Cz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:54:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d8ivY-0001jK-7l
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:54:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E6B14E4C6
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 07:54:23 +0000 (UTC)
Date: Thu, 11 May 2017 15:54:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170511075405.GG28293@pxdev.xzpeter.org>
References: <1494309644-18743-1-git-send-email-peterx@redhat.com>
	<1494309644-18743-4-git-send-email-peterx@redhat.com>
	<20170511025649.GC28293@pxdev.xzpeter.org>
	<e7dca113-22b8-1917-d759-3c4e42271e0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7dca113-22b8-1917-d759-3c4e42271e0f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] kvm: irqchip: skip update msi when
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

On Thu, May 11, 2017 at 09:48:52AM +0200, Paolo Bonzini wrote:
> 
> 
> On 11/05/2017 04:56, Peter Xu wrote:
> >> @@ -3510,12 +3511,16 @@ static void kvm_update_msi_routes_all(void *private, bool global,
> >>      int cnt = 0;
> >>      MSIRouteEntry *entry;
> >>      MSIMessage msg;
> >> +    PCIDevice *dev;
> >> +
> >>      /* TODO: explicit route update */
> >>      QLIST_FOREACH(entry, &msi_route_list, list) {
> >> -        cnt++;
> > 
> > Oops, I think this line should be kept. It does not affect too much,
> > only the trace below. But still, no reason to remove it.
> > 
> > Paolo, would it still possible to touch it up in your queue?
> 
> Yup, fixed.

That's great. Thanks!

-- 
Peter Xu
