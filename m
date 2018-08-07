Received: from eggs.gnu.org ([2001:4830:134:3::10]:55642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn22f-00038O-Ly
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fn22c-0002wv-HQ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:28:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41226 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fn22c-0002wm-Ch
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:28:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCA4240241C4
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 13:28:49 +0000 (UTC)
Date: Tue, 7 Aug 2018 15:28:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180807132847.gavgozyrmtmyol7u@sirius.home.kraxel.org>
References: <20180720214020.22897-1-bsd@redhat.com>
	<20180720214020.22897-4-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720214020.22897-4-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] dev-mtp: retry write for incomplete
 transfers
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

On Fri, Jul 20, 2018 at 05:40:18PM -0400, Bandan Das wrote:
> For large buffers, write may not copy the full buffer. For example,
> on Linux, write imposes a limit of 0x7ffff000. Note that this does
> not fix >4G transfers but ~>2G files will transfer successfully.

Hmm, I guess it would be a good idea to write the file in smaller
pieces, so we don't need a 2G host buffer to let the guest write
a 2G file ...

(as incremental improvement on top of this series).

cheers,
  Gerd
