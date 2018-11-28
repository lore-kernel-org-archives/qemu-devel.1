Received: from eggs.gnu.org ([2001:4830:134:3::10]:49174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS0uE-0004Wp-06
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gS0uA-0001wA-R4
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:33:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gS0uA-0001vb-J4
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:33:30 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 71706C058CB0
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 14:33:29 +0000 (UTC)
Date: Wed, 28 Nov 2018 14:33:07 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181128143307.GM24355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181128142135.15900-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181128142135.15900-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] configure: bump spice-server
 required version to 0.12.6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kraxel@redhat.com, fziglio@redhat.com

On Wed, Nov 28, 2018 at 06:21:35PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Looking at chardev/spice.c code, I realize compilation was broken for
> a while with spice-server < 0.12.3. I propose to bump required version
> to 0.12.6, released 3y ago, instead of adding more #ifdef.

As mentioned last time this patch was posted[1], any changes in the
min required versions should follow our supported build platforms
support statement:

  https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

Preferrably the commit message should list the version in each of the
main distros, such as in a0722409bcb980ecdab8330d4c716a73c9fcb489

At a glance it looks like Debian Jessie is likely to be the determining
vote with 0.12.5 as its newest version.

Regards,
Daniel

[1] https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00905.html
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
