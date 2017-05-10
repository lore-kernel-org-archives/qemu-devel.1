Received: from eggs.gnu.org ([2001:4830:134:3::10]:43096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8Tbt-0000iQ-UK
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d8Tbr-0004RM-Bs
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:33:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d8Tbr-0004RE-68
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:33:03 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C0B19D41E
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 15:33:01 +0000 (UTC)
References: <1494309644-18743-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed04714d-cef2-bacb-15d0-3effa07e6461@redhat.com>
Date: Wed, 10 May 2017 17:32:58 +0200
MIME-Version: 1.0
In-Reply-To: <1494309644-18743-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] kvm: irqchip: skip msi update when
 msi disabled
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



On 09/05/2017 08:00, Peter Xu wrote:
> v2:
> - missed one line in last patch to include msix header
> 
> First two patches are new traces, please collect them if needed.
> 
> The third patch is a fix to a qemu crash reported here:
> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=1448813
> 
> Please see its commit message for more information.
> 
> Please review. Thanks.
> 
> Peter Xu (3):
>   kvm: irqchip: trace changes on msi add/remove
>   msix: trace control bit write op
>   kvm: irqchip: skip update msi when disabled
> 
>  hw/pci/msix.c       | 11 +++++++++--
>  hw/pci/trace-events |  3 +++
>  kvm-all.c           |  4 +++-
>  target/i386/kvm.c   | 13 +++++++++----
>  trace-events        |  3 ++-
>  5 files changed, 26 insertions(+), 8 deletions(-)
> 

Looks good, queued for 2.10.  Michael, would you like to ack patch 2?

Thanks,

Paolo
