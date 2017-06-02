Received: from eggs.gnu.org ([2001:4830:134:3::10]:54320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dGnVg-0007wZ-95
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dGnVc-00055D-AQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:25:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dGnVc-000513-4M
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 10:25:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90C338047E
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 14:24:53 +0000 (UTC)
Date: Fri, 2 Jun 2017 15:24:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170602142445.GD11096@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170602141229.15326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170602141229.15326-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/9] Add memfd memory backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ehabkost@redhat.com

On Fri, Jun 02, 2017 at 06:12:20PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Add a new Linux-specific memory backend, similar to hostmem-file,
> except that it doesn't need file path. It also try to enforce memory
> sealing if available. It is thus slightly easier and secure, and is
> compatible with transparent huge-pages since Linux 4.8.

What about explicit huge pages ?  They are the key scenario scenario wher=
e
libvirt uses hostmem-file.  AFAICT, there's no way to request explicit
huge pages with memfd_create() syscall :-(

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
