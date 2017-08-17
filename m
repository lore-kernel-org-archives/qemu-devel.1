Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diJWn-0006yZ-EK
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1diJWj-0003k4-Ca
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1diJWj-0003ha-6T
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 08:03:53 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE5E125A7B4
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 12:03:51 +0000 (UTC)
Date: Thu, 17 Aug 2017 20:03:48 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170817120348.GE616@lemon>
References: <20170817102848.19294-1-famz@redhat.com>
	<1d0ebe1e-293d-b119-0621-d0f666b9ca36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d0ebe1e-293d-b119-0621-d0f666b9ca36@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-block: Add qdev error properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 08/17 13:44, Paolo Bonzini wrote:
> On 17/08/2017 12:28, Fam Zheng wrote:
> > This makes the werror/rerror options available on the scsi-block device,
> > to allow user specify error handling policy in the same way as scsi-hd
> > etc.
> > 
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> I'm not sure this is enough, because you would only obey the
> rerror/werror action if ioctl fails, not if the ioctl succeeds but the
> command fails (the "r->status && *r->status" conditional in
> scsi_disk_req_check_error).

Yes, I missed that.  Why isn't scsi_handle_rw_error called in that if block
currently?

Fam
