Received: from eggs.gnu.org ([2001:4830:134:3::10]:37416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eydEt-0004ov-LY
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1eydEn-0003w0-Q8
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:53:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1eydEn-0003ve-LI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:53:05 -0400
References: <20180320190023.24077-1-yuval.shaia@oracle.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <5ff502e3-4623-a097-4b83-68b68d7a76aa@redhat.com>
Date: Wed, 21 Mar 2018 14:53:00 +0200
MIME-Version: 1.0
In-Reply-To: <20180320190023.24077-1-yuval.shaia@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ihw/rdma: Implementation of Query QP verb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>, qemu-devel@nongnu.org
Cc: Michael Tsirkin <mst@redhat.com>

Hi Yuval,

On 20/03/2018 21:00, Yuval Shaia wrote:
> Please review implementation of Query QP verb which is needed by some RDMA
> applications.
> 
> Patch #1: Implementation in rdma backend layer
> Patch #2: Add support to pvrdma device
> 
> v0 -> v1:
> 	* Split to two patches, one for rdma and one for pvrdma
> 

Actually previous version was V1, this one is V2 :)

Next time please add V2 (V3...) prefix and I suggest using --cover-letter
when using git format-patch/send email instead of manually
adding it.


> [PATCH v1 1/2] hw/rdma: Add Query QP operation
> [PATCH v1 2/2] hw/rdma: Add support for Query QP verb to pvrdma

Second patch should have maybe rdma/vmw since is VMware specific (next time)

> 

I am thinking adding it to 2.12, it can be seen as a bug-fix, querying QP
is a basic operation the device should answer to.
Michael, sounds reasonable?


Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
