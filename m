Received: from eggs.gnu.org ([2001:4830:134:3::10]:37122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmGiA-00026P-9E
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:19:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cmGi6-0001on-4r
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:19:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cmGi5-0001oT-Vi
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 04:19:42 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EA6280F94
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 09:19:42 +0000 (UTC)
References: <1489119213-977-1-git-send-email-peterx@redhat.com>
	<da6200fe-c0ac-00bb-d0b7-dbf3c5a8a21f@redhat.com>
	<20170310085917.GF17299@pxdev.xzpeter.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <93e9b7c1-4451-39e0-224e-90b6ce2a1d28@redhat.com>
Date: Fri, 10 Mar 2017 10:19:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170310085917.GF17299@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hostmem: fix reference to uninit mr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>



On 10/03/2017 09:59, Peter Xu wrote:
>> What is the effect of the bug? The idea was to do the initialization
>> once only (memory_region_size ought to be 0 when the MR is
>> uninitialized; now it is ugly but it made more sense when MemoryRegion
>> was just a C struct and not a QOM object).
> It's not really a bug. I just saw it, thought it was something not
> quite right, so posted a patch. Since it's intended, then please
> ignore this patch, and sorry for the noise... :)

It's intended but ugly. :)  Peter's idea is a good one if you want to
implement something along those lines.

Paolo
