Received: from eggs.gnu.org ([208.118.235.92]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gbPV8-0004hl-6O
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 07:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <remy.noel@blade-group.com>) id 1gbPV7-0002Yb-Fw
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 07:38:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <remy.noel@blade-group.com>)
	id 1gbPV7-0002Xc-6o
	for qemu-devel@nongnu.org; Mon, 24 Dec 2018 07:38:29 -0500
Received: by mail-wm1-x341.google.com with SMTP id f188so11680118wmf.5
	for <qemu-devel@nongnu.org>; Mon, 24 Dec 2018 04:38:28 -0800 (PST)
References: <20181220152030.28035-1-remy.noel@blade-group.com>
	<20181220163738.GA5662@stefanha-x1.localdomain>
	<44649c49-6d9f-a839-32f1-1cce9766da17@redhat.com>
From: Remy NOEL <remy.noel@blade-group.com>
Message-ID: <ffd3e660-9704-9522-2660-bc8b850c953d@blade-group.com>
Date: Mon, 24 Dec 2018 13:38:47 +0100
MIME-Version: 1.0
In-Reply-To: <44649c49-6d9f-a839-32f1-1cce9766da17@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
Subject: Re: [Qemu-devel] [QEMU-devel][PATCH v4 0/2] Fix concurrent
 aio_poll/set_fd_handler.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Weil <sw@weilnetz.de>

On 12/21/18 12:34 PM, Paolo Bonzini wrote:

> FWIW, I had missed the early version that used RCU, but lockcnt is
> already very RCU-like, so not using RCU is the right thing to do.  The
> difference between lockcnt and RCU is that cleanup is done by the reader
> instead of a separate thread.  Because we know that reader/writer
> concurrency is very rare for AioContext handlers, the tradeoffs favor
> lockcnt over RCU.

Indeed, i forgot to CC you in the first batch (get_maintainer.pl was not 
finding you).

Thanks for the RCU hints, i though the performance hit was due to the 
RCU being global to qemu.


Remy
