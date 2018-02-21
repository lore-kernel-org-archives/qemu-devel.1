Received: from eggs.gnu.org ([2001:4830:134:3::10]:51989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoRLI-0002Tk-EG
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:09:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eoRLD-0005fB-Fm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:09:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eoRLD-0005eo-A2
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 05:09:35 -0500
References: <20180214001105.21508-1-mdroth@linux.vnet.ibm.com>
	<20180214165040.GA2508@work-vm>
	<151863233842.4211.15732702297985774243@sif>
	<20180216115721.GB3000@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ad81069-6ddd-eecc-b1dd-b3aa8f184812@redhat.com>
Date: Wed, 21 Feb 2018 11:09:25 +0100
MIME-Version: 1.0
In-Reply-To: <20180216115721.GB3000@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post documenting
 Spectre/Meltdown options for QEMU 2.11.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 16/02/2018 12:57, Dr. David Alan Gilbert wrote:
> It's a bit weird to end up pointing to them to a lkml post;
> Paolo: Any ideas on anything better to say?

IBRS is really that much slower than retpolines on pre-Skylake machines,
so it's a hard call to tell people to use it.  It looks like Intel is
going to add Yet Another Bit to clean up the Skylake mess; in the
meanwhile I would just use retpolines even on Skylake and newer
machines, because the Spectre attacks are much more theoretical than
Meltdown, but it's good to point out the issue for the paranoid folks.

Paolo
