Received: from eggs.gnu.org ([2001:4830:134:3::10]:55075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRHe7-0005np-Ou
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 08:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRHe4-0002CV-15
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 08:09:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44414)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRHe3-0002BW-R2
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 08:09:19 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5BB085545
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 13:09:18 +0000 (UTC)
References: <20171210063819.14892-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d6bd4068-8a9f-e043-adba-01cb198021f3@redhat.com>
Date: Tue, 19 Dec 2017 14:09:12 +0100
MIME-Version: 1.0
In-Reply-To: <20171210063819.14892-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] i8259: cleanups and enhancements
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

On 10/12/2017 07:38, Peter Xu wrote:
> It's mostly a cleanup, but patch 4 allows kvm-i8259 to support "info
> pic" and "info irq" too.
> 
> I'm thinking whether it'll be good to move on this work to spread
> these commands to IOAPICs too, by removing "info ioapic" command and
> let "info pic" dump the things altogether (after all I think ioapic is
> also one type of PIC).  Also, we can let ioapic to have statistics
> too.

Yes, I agree.  I queued this series.

Paolo
