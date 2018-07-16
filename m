Received: from eggs.gnu.org ([2001:4830:134:3::10]:56662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ff00N-0008Tu-24
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:41:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ff00J-0004Jo-VF
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:41:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ff00J-0004Je-Pa
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:41:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CE7081663C2
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 09:41:15 +0000 (UTC)
Date: Mon, 16 Jul 2018 10:41:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180716094110.GM5616@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180716073226.21127-1-armbru@redhat.com>
	<20180716073226.21127-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716073226.21127-2-armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-doc: Move appendix "Deprecated
 features" to its own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, thuth@redhat.com, cohuck@redhat.com, pkrempa@redhat.com

On Mon, Jul 16, 2018 at 09:32:25AM +0200, Markus Armbruster wrote:
> Consumers of QEMU need to track feature deprecation.  Keeping
> deprecation documentation in its own file helps in two small ways:
>=20
> * You can track changes the easy and obvious way, with git-log.
>   Before, you had to resort to more complex gittery like "git-log
>   --oneline -L '/@node Deprecated features/,/@node Supported build
>   platforms/:qemu-doc.texi'"
>=20
> * It lets us use MAINTAINERS to copy interested parties on deprecation
>   patches, so they can advise or object before they're a done deal.
>   The next commit will do that for libvirt.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-deprecated.texi | 234 ++++++++++++++++++++++++++++++++++++++++++
>  qemu-doc.texi        | 235 +------------------------------------------
>  2 files changed, 235 insertions(+), 234 deletions(-)
>  create mode 100644 qemu-deprecated.texi

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
