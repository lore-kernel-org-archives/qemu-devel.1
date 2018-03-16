Received: from eggs.gnu.org ([2001:4830:134:3::10]:42971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtVg-0006nr-VI
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:51:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtVd-0008Jd-15
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:51:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewtVc-0008JP-SR
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:51:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E15BD1443
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:51:16 +0000 (UTC)
Date: Fri, 16 Mar 2018 17:51:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316175112.GB3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
	<20180316115403.4148-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316115403.4148-4-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 03/15] migration: terminate_* can be
 called for other threads
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

On Fri, Mar 16, 2018 at 12:53:51PM +0100, Juan Quintela wrote:
> Once there, make  count field to always be accessed with atomic
> operations.  To make blocking operations, we need to know that the
> thread is running, so create a bool to indicate that.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
>=20
> --
>=20
> Once here, s/terminate_multifd_*-threads/multifd_*_terminate_threads/
> This is consistente with every other function

Usuaully I'd suggest that renames be done in a separate patch from
functional changes.

> ---
>  migration/ram.c | 38 ++++++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 14 deletions(-)

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
