Received: from eggs.gnu.org ([209.51.188.92]:53306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGfwM-0006c1-T6
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:29:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGfwK-0001ck-UV
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:29:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hGfwK-0001Xn-FH
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 04:29:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B49F30832C6
	for <qemu-devel@nongnu.org>; Wed, 17 Apr 2019 08:29:07 +0000 (UTC)
Date: Wed, 17 Apr 2019 10:29:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190417082904.jzqjzgznfreuz3pb@sirius.home.kraxel.org>
References: <jpgwojv9pwv.fsf@linux.bootlegged.copy>
	<jpg8swbi55o.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jpg8swbi55o.fsf@linux.bootlegged.copy>
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: change default to success for
 usb_mtp_update_object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

On Mon, Apr 15, 2019 at 12:50:43PM -0400, Bandan Das wrote:
> Forgot to cc people ...
> 
> Bandan Das <bsd@redhat.com> writes:
> 
> > Commit c5ead51f90cf (usb-mtp: return incomplete transfer on a lstat
> > failure) checks if lstat succeeded when updating attributes of a
> > file. However, it also changed behavior to return an error by
> > default. This is incorrect because for smaller file sizes, Qemu
> > will attempt to write the file in one go and there won't be
> > an object for it.

Patch added to usb queue.

Current queue is https://git.kraxel.org/cgit/qemu/log/?h=queue/usb

If anything is missing there please resend.

thanks,
  Gerd
