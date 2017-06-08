Received: from eggs.gnu.org ([2001:4830:134:3::10]:41755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dJ0Of-0000YJ-De
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dJ0Ob-0000GM-Vl
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dJ0Ob-0000Fm-PK
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 12:34:53 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7834C43A47
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 16:34:52 +0000 (UTC)
References: <20170608161013.17920-1-lersek@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <961e1ac9-56a5-df24-9ed7-e1981e61942a@redhat.com>
Date: Thu, 8 Jun 2017 18:34:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170608161013.17920-1-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] q35/mch: implement extended TSEG sizes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>



On 08/06/2017 18:10, Laszlo Ersek wrote:
> When the guest writes value 0xffff to this register, the value that can be
> read back is that of "mch.extended-tseg-mbytes" -- unless it remains
> 0xffff. The guest is required to write 0xffff first (as opposed to a
> read-only register) because PCI config space is generally not cleared on
> QEMU reset, and after S3 resume or reboot, new guest firmware running on
> old QEMU could read a guest OS-injected value from this register.

I guess that's also a reason not to make it readonly (that is, it would
require some firmware code anyway to test for "readonlyness" and
distinguish old machine types from new)?

Thanks,

Paolo
