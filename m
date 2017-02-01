Received: from eggs.gnu.org ([2001:4830:134:3::10]:56894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZ1X3-000602-FN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cZ1X2-00058h-NJ
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 15:29:33 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1485800032-24404-1-git-send-email-hch@lst.de>
	<1485800032-24404-2-git-send-email-hch@lst.de>
	<20170201164050.GD12283@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af5d7115-1b30-41aa-f3e5-0c4e4271d52c@redhat.com>
Date: Wed, 1 Feb 2017 12:29:22 -0800
MIME-Version: 1.0
In-Reply-To: <20170201164050.GD12283@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] nvme: implement the DSM command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 01/02/2017 08:40, Stefan Hajnoczi wrote:
>> +    range = g_new(NvmeDsmRange, nr);
>> +
>> +    if (nvme_map_prp(&qsg, le64_to_cpu(cmd->prp1), le64_to_cpu(cmd->prp2),
>> +            sizeof(range), n)) {

This should be sizeof(*range) * nr, like the DMA below.

>> +        goto out_free_range;
>> +    }
>> +
>> +    if (dma_buf_write((uint8_t *)range, sizeof(range), &qsg)) {
> 
> Did you mean sizeof(*range) * nr?

Did you also mean dma_buf_read (you want to read from device to range)?

Paolo
