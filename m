Received: from eggs.gnu.org ([2001:4830:134:3::10]:42317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddHlO-0000Yu-JN
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ddHlL-0007D9-G8
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:10:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ddHlL-0007CB-7X
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:10:11 -0400
References: <1501766821-76419-1-git-send-email-hare@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ad6ed91-b793-fab1-ea72-1e30e5b59266@redhat.com>
Date: Thu, 3 Aug 2017 17:10:07 +0200
MIME-Version: 1.0
In-Reply-To: <1501766821-76419-1-git-send-email-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] scsi: enclosure support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hannes Reinecke <hare@suse.de>
Cc: qemu-devel@nongnu.org

On 03/08/2017 15:26, Hannes Reinecke wrote:
> Hi all,
> 
> due to a customer issue I've added simple subenclosure support
> to the SCSI emulation. The patch simply converts the current invisible
> LUN0 into an enclosure device; existing setups using LUN0 as disks or
> CD-ROMs will not be affected.

What is the issue exactly?  That is, for what is it necessary to have a
dummy enclosure?

I agree with Dan that this need machine type compatibility gunk.  For
example, could the new device affect /dev/sgN numbering?

Paolo
