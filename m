Received: from eggs.gnu.org ([2001:4830:134:3::10]:55556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSRu-0000PV-M8
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:19:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejSRr-0000PO-Gb
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:19:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47576 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejSRr-0000Or-3m
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:19:51 -0500
References: <20180207160638.98872-1-brijesh.singh@amd.com>
	<20180207160638.98872-2-brijesh.singh@amd.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63949650-cea1-f035-261e-e79dc15d85b8@redhat.com>
Date: Wed, 7 Feb 2018 10:19:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180207160638.98872-2-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 02/26] exec: add ram_debug_ops support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Richard Henderson <rth@twiddle.net>

On 02/07/2018 10:06 AM, Brijesh Singh wrote:
> Currently, the guest memory access for the debug purpose is performed
> using the memcpy(). Lets extend the 'struct MemoryRegion' to include
> ram_debug_ops callbacks. The ram_debug_ops can be used to override
> memcpy() with something else.

[meta-comment]

Your threading is off.  This email was sent with the headers:

 > In-Reply-To: <20180207160638.98872-1-brijesh.singh@amd.com>
 > References: <20180207160638.98872-1-brijesh.singh@amd.com>

which ties it only to patch 1/26; in turn, that message has no 
In-Reply-To header at all, making it a top-level thread.  Meanwhile, 
your 0/26 cover letter has:

> Message-Id: <20180207160324.98614-1-brijesh.singh@amd.com>

which nothing in the rest of the series refers to, making it a separate 
thread.  It would be helpful if you could the threading used in your 
sending environment, although I don't have any specific suggestions on 
what that fix would be.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
