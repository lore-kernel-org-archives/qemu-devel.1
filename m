Received: from eggs.gnu.org ([2001:4830:134:3::10]:41212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8XuE-0006G8-CI
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8XuB-0008Hx-3n
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f8XuA-0008CB-Tu
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:12:47 -0400
Date: Tue, 17 Apr 2018 18:12:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180417211238.GE29865@localhost.localdomain>
References: <1523991487-241006-1-git-send-email-mst@redhat.com>
	<1523991487-241006-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523991487-241006-2-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] update-linux-headers.sh: drop
 kvm_para.h hacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Wanpeng Li <kernellwp@gmail.com>, kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, Brijesh Singh <brijesh.singh@amd.com>, Gerd Hoffmann <kraxel@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On Tue, Apr 17, 2018 at 09:58:21PM +0300, Michael S. Tsirkin wrote:
> It turns out (as will be clear from follow-up patches)
> we do not really need any kvm para macros host side
> for now, except on x86, and there we need it
> unconditionally whether we run on kvm or we don't.
> 
> Import the x86 asm/kvm_para.h into standard-headers,
> follow-up patches remove a bunch of code using this.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

I didn't review the code yet but I agree it's a good change, so:

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
