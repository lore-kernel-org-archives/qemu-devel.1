Received: from eggs.gnu.org ([2001:4830:134:3::10]:51656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6Zwi-0008AX-CY
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e6Zwe-0004tL-FF
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e6Zwe-0004t9-83
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:26:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B7E17E425
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 10:26:55 +0000 (UTC)
Date: Mon, 23 Oct 2017 11:26:48 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171023102648.GG16472@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171023095910.23202-1-marcandre.lureau@redhat.com>
	<20171023095910.23202-7-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171023095910.23202-7-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 6/6] tests: use memfd in vhost-user-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com

On Mon, Oct 23, 2017 at 10:59:10AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> This will exercise the memfd memory backend and should generally be
> better for testing than memory-backend-file (thanks to anonymous files
> and sealing).

Since we'll support vhost-user with both backends, it would be preferrabl=
e
to test both backends so we don't loose test coverage of the memory-backe=
nd-file
which is what's actually used in practice right now.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
