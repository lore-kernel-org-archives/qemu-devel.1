Received: from eggs.gnu.org ([2001:4830:134:3::10]:53109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY8O4-0006sO-L6
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fY8O1-0006PN-Fh
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:13:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fY8O1-0006P8-BS
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:13:21 -0400
Date: Wed, 27 Jun 2018 13:13:19 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180627111319.4mlws52yq5ldoxwe@sirius.home.kraxel.org>
References: <20180625131253.11218-1-kraxel@redhat.com>
	<20180625131253.11218-2-kraxel@redhat.com>
	<6ad67e44-b002-1cd7-cfd1-2d98ebde1a7e@redhat.com>
	<20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627065126.mwzdxshr3njzok7n@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PULL 1/6] audio/hda: create millisecond timers
 that handle IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Martin Schrodt <martin@schrodt.org>, qemu-devel@nongnu.org

  Hi,

> Given the code runs under big qemu lock anyway the atomics are not
> needed, so we could drop just them.  I left them in nevertheless because
> 
>   (a) we might want try run the code in a thread instead of using a timer, and
>   (b) I was too lazy to rewrite the code to drop the atomics.
> 
> I'd prefer to keep option (a) ...

Well, experimented with that a bit. 

As long as the core audio system runs using qemu timers too moving to a
thread doesn't buy us much as any latency spikes in qemu will hit us no
matter what.

So, that point is moot.  I'll go drop the atomics.

cheers,
  Gerd
