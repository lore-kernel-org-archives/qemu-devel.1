Received: from eggs.gnu.org ([2001:4830:134:3::10]:39365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSMuR-0003vq-GQ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:31:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSMuO-0001nh-Df
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:30:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39473)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fSMuO-0001n3-6O
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 09:30:56 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so16537518wmc.4
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 06:30:55 -0700 (PDT)
References: <20180607154705.6316-1-david@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6da8d892-fa42-c870-7be2-bded1ab4e28f@redhat.com>
Date: Mon, 11 Jun 2018 15:30:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180607154705.6316-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] memory: fix alignment checks/asserts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 07/06/2018 17:47, David Hildenbrand wrote:
> We can currently hit two asserts. Let's fix those.
> 
> Patch nr. 1 is a result from:
>     "[PATCH v4 00/14] MemoryDevice: use multi stage hotplug handlers"
> 
> We treat right now any alignment > 1GB as a violation, as it would
> fragment guest memory heavily. Turn the assert into a check.
> 
> Also, we run into an assert when using alignments that are not a power of
> two.

Queued, thanks.

Paolo
