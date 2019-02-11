Received: from eggs.gnu.org ([209.51.188.92]:46239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtCwN-0006hY-GR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:52:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtCwL-0003ea-KW
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:52:11 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:40105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtCwL-0003OV-Fn
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 09:52:09 -0500
Received: by mail-qt1-f178.google.com with SMTP id j36so12387117qta.7
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 06:52:04 -0800 (PST)
Date: Mon, 11 Feb 2019 09:52:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211095049-mutt-send-email-mst@kernel.org>
References: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c30bdd-6cd0-ee9b-9fdf-cc8eaa54f7cc@yandex-team.ru>
Subject: Re: [Qemu-devel] Is IOThread for virtio-net a good idea?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Kuchin <antonkuchin@yandex-team.ru>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com

On Mon, Feb 11, 2019 at 04:40:44PM +0300, Anton Kuchin wrote:
> As far as I can see currently IOThread offloading is used only for block
> devices and all others are emulated by main thread.
> 
> I expect that network devices can also benefit from processing in separate
> thread but I couldn't find any recent work in this direction. I'm going to
> implement a PoC but I want to ask if you know any previous attempts and do
> you know why it can be a total waste of time. Are there fundamental
> obstacles that prevent network emulation handling in IOThread?

No but vhost-net is there. Unlike block where you gain lots of
functionality such as snapshots there seems to be little to
be gained by doing it in userspace.

-- 
MST
