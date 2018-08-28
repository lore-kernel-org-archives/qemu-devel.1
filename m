Received: from eggs.gnu.org ([2001:4830:134:3::10]:35608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fufbc-0007aH-0v
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fufYW-0000uO-1H
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:05:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47136 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fufYV-0000uK-Qa
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:05:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 733C940241F0
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 15:05:19 +0000 (UTC)
Date: Tue, 28 Aug 2018 16:05:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828150512.GA31005@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180713130916.4153-3-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/29] chardev: remove
 qemu_chr_fe_read_all() counter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, airlied@redhat.com, kraxel@redhat.com

On Fri, Jul 13, 2018 at 03:08:49PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> There is no obvious reason to have a loop counter. This limits from
> reading several megabytes large buffers in one go, since socket
> read/write usually have a limit.

The counter was there since this method's introduction in
7b0bfdf52d694c9a3a96505aa42ce3f8d63acd35, and no obvious
indication of its purpose in that commit.

I can imagine maybe it was a misguided attempt to prevent
QEMU blocking forever if no data was pending, but it does
not in fact achieve that.

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  chardev/char-fe.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)


Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
