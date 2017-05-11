Received: from eggs.gnu.org ([2001:4830:134:3::10]:33802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8iqW-0002JK-Cf
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:49:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8iqS-0005M1-CQ
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:49:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8iqS-0005LQ-6j
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:49:08 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 190873B71C
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 07:49:07 +0000 (UTC)
References: <1494309644-18743-1-git-send-email-peterx@redhat.com>
	<1494309644-18743-4-git-send-email-peterx@redhat.com>
	<20170511025649.GC28293@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7dca113-22b8-1917-d759-3c4e42271e0f@redhat.com>
Date: Thu, 11 May 2017 09:48:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170511025649.GC28293@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>



On 11/05/2017 04:56, Peter Xu wrote:
>> @@ -3510,12 +3511,16 @@ static void kvm_update_msi_routes_all(void *private, bool global,
>>      int cnt = 0;
>>      MSIRouteEntry *entry;
>>      MSIMessage msg;
>> +    PCIDevice *dev;
>> +
>>      /* TODO: explicit route update */
>>      QLIST_FOREACH(entry, &msi_route_list, list) {
>> -        cnt++;
> 
> Oops, I think this line should be kept. It does not affect too much,
> only the trace below. But still, no reason to remove it.
> 
> Paolo, would it still possible to touch it up in your queue?

Yup, fixed.

Paolo
