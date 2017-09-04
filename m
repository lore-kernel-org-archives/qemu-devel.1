Received: from eggs.gnu.org ([2001:4830:134:3::10]:48122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dooQk-0007uA-B5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dooQf-0005F6-AY
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:16:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dooQf-0005ER-4g
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 06:16:29 -0400
Date: Mon, 4 Sep 2017 11:16:24 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170904101624.GE7186@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <CAOE=1Z3xuudQenX+Oe11fPDZfrC_d02S50HQ9mJ=RfnJ0B5DUg@mail.gmail.com>
	<20170904093623.GB7186@redhat.com>
	<CAOE=1Z2HFVhD8b1TXaQFd8sGvqoddOeJoSds1ZxwzKSw8im7ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOE=1Z2HFVhD8b1TXaQFd8sGvqoddOeJoSds1ZxwzKSw8im7ng@mail.gmail.com>
Subject: Re: [Qemu-devel] How to use monitor socket in python to connect VM?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam <batmanustc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, Sep 04, 2017 at 06:11:44PM +0800, Sam wrote:
> Actually I use qga socket first(send json format command like {'execute':
> 'chardev-add', 'arguments': {'id': id, 'type': type}, 'params': params} by
> qga socket, which is
> /opt/cloud/workspace/servers/1925a92d-f003-4d77-871c-bce8f85229aa/qga.sock,
> using the same script as first mail), but it response me "netdev_add is not
> valid command"(it's reasonable, as guest OS could not operate 'netdev_add'
> command), so I thought qga could not do this work, then I change to monitor.

You're mixing up two different things.  'QGA' is the QEMU guest agent
which is a service than runs in the guest OS. 'QMP' is the QEMU monitor
socket which runs in the host OS. Both of these use the same JSON based
protocol, but take completely different commands.

You need to use 'QMP' for 'netdev_add', not 'QGA'.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
