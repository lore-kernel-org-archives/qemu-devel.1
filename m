Received: from eggs.gnu.org ([2001:4830:134:3::10]:48066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa3c-00049D-0m
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJa3W-0006Yx-7r
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:44:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJa3W-0006Yi-3U
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:44:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98F287D84C
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:44:01 +0000 (UTC)
Date: Fri, 18 May 2018 09:44:00 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180518074400.7mmenihcabqq5lnq@sirius.home.kraxel.org>
References: <20180516115544.3897-1-jjelen@redhat.com>
	<20180516115544.3897-2-jjelen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516115544.3897-2-jjelen@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] hw/usb/dev-smartcard-reader: Handle 64
 B USB packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jjelen@redhat.com
Cc: qemu-devel@nongnu.org

On Wed, May 16, 2018 at 01:55:44PM +0200, jjelen@redhat.com wrote:
> From: Jakub Jelen <jjelen@redhat.com>
> 
> The current code was not correctly handling 64 B (Max USB 1.1 payload size)
> packets and therefore preventing some of the messages from smart card to
> pass through to the guest.

Added to usb queue.

thanks,
  Gerd
