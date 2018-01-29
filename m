Received: from eggs.gnu.org ([2001:4830:134:3::10]:54484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg9Ac-0005L3-R7
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:08:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eg9AY-0007BI-U9
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 08:08:22 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-10-git-send-email-walling@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <00a86803-1978-db18-f076-60eb3c27de74@redhat.com>
Date: Mon, 29 Jan 2018 14:08:05 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-10-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 09/10] s390-ccw: read user
 input for boot index via the SCLP console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, thuth@redhat.com, cohuck@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> Implements an sclp_read function to capture input from the
> console and a wrapper function that handles parsing certain
> characters and adding input to a buffer. The input is checked
> for any erroneous values and is handled appropriately.
> 
> A prompt will persist until input is entered or the timeout
> expires (if one was set). Example:
> 
>     Please choose (default will boot in 10 seconds):
> 
> Correct input will boot the respective boot index. If the
> user's input is empty, 0, or if the timeout expires, then
> the default zipl entry will be chosen. If the input is
> within the range of available boot entries, then the
> selection will be booted. Any erroneous input will cancel
> the timeout and re-prompt the user.
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---

Also, a very nasty thing to take care of is the following:

SCLP and ckc interrupt at the same time pending.

-> We only dequeue one, the other remains pending and is presented to
the guest

-- 

Thanks,

David / dhildenb
