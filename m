Received: from eggs.gnu.org ([2001:4830:134:3::10]:45929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtiH-0004dX-JQ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtiD-0007IF-LN
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:04:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49626 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewtiD-0007Hm-GK
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:04:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 677E48182D24
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 18:04:06 +0000 (UTC)
Date: Fri, 16 Mar 2018 18:03:58 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316180358.GH3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
	<20180316115403.4148-12-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316115403.4148-12-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 11/15] migration: Delay start of
 migration main routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Fri, Mar 16, 2018 at 12:53:59PM +0100, Juan Quintela wrote:
> We need to make sure that we have started all the multifd threads.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 4 ++--
>  migration/migration.h | 1 +
>  migration/ram.c       | 3 +++
>  migration/socket.c    | 3 +++
>  4 files changed, 9 insertions(+), 2 deletions(-)

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
