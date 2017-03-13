Received: from eggs.gnu.org ([2001:4830:134:3::10]:34191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cnRJV-0004sM-3K
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kripper@imatronix.cl>) id 1cnRJR-0000MC-51
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:51:09 -0400
Received: from ip35.imatronix.com ([200.73.112.45]:44589
	helo=cpanel.imatronix.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kripper@imatronix.cl>)
	id 1cnRJQ-0000KB-Kt
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 10:51:05 -0400
References: <2e5a75c0-b142-5e23-4314-445385b2cdb6@imatronix.cl>
	<20170313112132.GB5545@noname.redhat.com>
From: Christopher Pereira <kripper@imatronix.cl>
Message-ID: <143fa7b8-1345-d506-04ca-d91bf2e7d7ad@imatronix.cl>
Date: Mon, 13 Mar 2017 11:51:02 -0300
MIME-Version: 1.0
In-Reply-To: <20170313112132.GB5545@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Swap disks virtualization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org

On 13-Mar-17 08:21, Kevin Wolf wrote:
> I think the state of the art is to give the VMs enough memory rather
Thanks Kevin. This was the answer I expected, so here follows my second 
question:

By increasing virtual RAM, I'm afraid that the guest OS may detect and 
use more memory, causing the host to pay the price of overcommited 
memory being swapped on the host.
If the guest OS (let's say Linux) detects less available memory, isn't 
there a chance it will try to use less memory?
My guess is that the OS's should distinguish between physical (fast) and 
swap memory (slow) for better memory management.
Any thoughts?
