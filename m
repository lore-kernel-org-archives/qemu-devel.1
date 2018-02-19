Received: from eggs.gnu.org ([208.118.235.92]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1enh8Q-000221-PV
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1enh8B-0002Mm-41
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:49:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1enh8A-0002Ll-QV
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 03:49:02 -0500
Date: Mon, 19 Feb 2018 09:48:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180219084853.zqds7ikihawpb57i@sirius.home.kraxel.org>
References: <20180203171743.13612-1-programmingkidx@gmail.com>
	<20180216131540.ioudb6rwf4y6qnxq@sirius.home.kraxel.org>
	<55E5910F-47CB-49BD-83F2-E867750F9BEA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55E5910F-47CB-49BD-83F2-E867750F9BEA@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6] ui/cocoa.m: Add ability for user to
 specify mouse ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

  Hi,

> > (b) Restrict allowed hotkeys to modifier key(s) plus one
> >    non-modifier key.  Forwarding modifier keydown+keyup
> >    to the guest has typically effects inside the guest,
> >    so we only have to hold back that single non-modifier
> >    key.  That is alot easier to implement.
> 
> Sorry but I was using this patch to make my ungrab key F15.
> This key is not used by anything and makes things so simple
> for me. Requiring a modifier key in the sequence seems unnecessary. 

Just a plain F15 without any modifier should be find too.

Allowing *two* (or more) non-modifier keys (i.e. F14+F15) is where it
becomes tricky ...

cheers,
  Gerd
