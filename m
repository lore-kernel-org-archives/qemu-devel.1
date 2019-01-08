Received: from eggs.gnu.org ([209.51.188.92]:42651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggq2c-0007HS-Hz
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggq2Z-00043t-KB
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:59:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:17470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggq2X-0003u6-ST
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:59:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3C02E13BF61
	for <qemu-devel@nongnu.org>; Tue,  8 Jan 2019 11:59:23 +0000 (UTC)
Date: Tue, 8 Jan 2019 12:59:20 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190108115920.kmtuxtlxabgajl6f@sirius.home.kraxel.org>
References: <20181115220132.6531-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115220132.6531-1-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Break down the MTP write operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> For larger files, not only do we keep reallocating to increase the mtp buffer
> size, the write also happens in one go. This does two things:
> 
> Write to file upto a certain data size we have received so far and second,
> reuse the buffer again instead of reallocating to a larger buffer size.
> 
> Tested with different file sizes on a Linux guest.

Doesn't apply to master, please rebase.

thanks,
  Gerd
