Received: from eggs.gnu.org ([2001:4830:134:3::10]:57870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fmytS-0000QN-A3
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fmytP-0003XZ-Jf
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:07:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fmytP-0003XG-Ee
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 06:07:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D4B140201A3
	for <qemu-devel@nongnu.org>; Tue,  7 Aug 2018 10:07:06 +0000 (UTC)
Date: Tue, 7 Aug 2018 11:07:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180807100701.GE7335@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-4-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180803173614.12358-4-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] configure: bump spice-server
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Fri, Aug 03, 2018 at 07:36:07PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Looking at chardev/spice.c code, I realize compilation was broken for
> a while with spice-server < 0.12.3. I propose to bump required version
> to 0.12.6, released 3y ago, instead of adding more #ifdef.

Since we introduced our platform support policy[1], it is desired that
any min version changes consider what versions our target OS have
available. eg take a look at this commit message example:

  https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03796.html

could you use repology[2] to do the same for spice to validate that
this proposed min version is compatible with distros we target.

Regards,
Daniel

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

[2] https://repology.org/metapackage/spice/versions
    https://repology.org/metapackage/spice-server/versions
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
