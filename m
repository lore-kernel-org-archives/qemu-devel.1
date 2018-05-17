Received: from eggs.gnu.org ([2001:4830:134:3::10]:39064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fJIUe-0006No-IJ
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fJIUa-0006lz-Hv
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:58:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fJIUa-0006lm-DS
	for qemu-devel@nongnu.org; Thu, 17 May 2018 08:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E6B18BB40D
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 12:58:47 +0000 (UTC)
Date: Thu, 17 May 2018 13:58:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180517125843.GL5657@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
	<20180517124403.GJ5657@redhat.com>
	<feddfb98-318a-d5ca-1aee-76f99fc52ce8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <feddfb98-318a-d5ca-1aee-76f99fc52ce8@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

On Thu, May 17, 2018 at 02:50:04PM +0200, Paolo Bonzini wrote:
> On 17/05/2018 14:44, Daniel P. Berrang=C3=A9 wrote:
> >> +ifeq ($(CONFIG_X11),y)
> >> +sdl.mo-objs +=3D x_keymap.o
> >> +gtk.mo-objs +=3D x_keymap.o
> > Would this cause symbol clash if both sdl & gtk modules are loaded
> > at the same time, or have we used linker scripts to limit what symbol=
s
> > each module exposes ?
> >=20
>=20
> We don't, but: 1) the file has only functions and no data; 2) in any
> case the symbols are the same, so it is not a real clash.

Ok, as long as dlopen() doesn't whine its fine with me.

> Adding linker scripts would be a nice improvement, but it is not
> necessary for this patch.

Agreed.

> Another possibility would be to include x_keymap.c in the files that us=
e
> it and make qemu_xkeymap_mapping_table static, but I think it would be
> the worst.

It isn't worth trying to be too clever since we're deleting SDL1 in
the 2.14 dev cycle.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
