Received: from eggs.gnu.org ([2001:4830:134:3::10]:54367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9PZx-00011F-Gh
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f9PZu-0006zZ-CU
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 02:31:29 -0400
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-3-git-send-email-thuth@redhat.com>
	<0be89209-6ee5-2f12-fae2-21709fcf6f8a@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7ebf0874-1b70-47e4-fce6-15566887270f@redhat.com>
Date: Fri, 20 Apr 2018 08:31:16 +0200
MIME-Version: 1.0
In-Reply-To: <0be89209-6ee5-2f12-fae2-21709fcf6f8a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.13 2/4] pc-bios/s390-ccw/net: Stop
 virtio-net device before jumping into the OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>

On 19.04.2018 17:49, Christian Borntraeger wrote:
> On 04/18/2018 02:31 PM, Thomas Huth wrote:
>> The virtio-net receive buffers are filled asynchronously, so we should
>> make sure to properly shut down the virtio-net device before we jump into
>> the loaded kernel. Otherwise an incoming packet could destroy memory of
>> the OS kernel if it did not re-initialize the virtio-net device fast
>> enough yet.
> 
> The normal bios does a full subsystem reset before we enter the OS.
> (see jump_to_IPL_code the diag 308). That should reset all virtio 
> devices on the qemu level. Shouldnt we rather do the same for
> the net bios?

That should fix this issue, too, right. I'll give it a try and include
it in v2 if I can make it work...

 Thomas
