Received: from eggs.gnu.org ([2001:4830:134:3::10]:45982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnkug-0001AT-CD
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnkub-0001QP-B9
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnkub-0001Q4-4q
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:19:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1EDBB80F79
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:19:00 +0000 (UTC)
Date: Fri, 1 Sep 2017 13:18:54 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170901121854.GM31680@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170901115500.12654-1-quintela@redhat.com>
	<20170901115500.12654-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170901115500.12654-3-quintela@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/2] tests: Make vmgenid test compile
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

On Fri, Sep 01, 2017 at 01:55:00PM +0200, Juan Quintela wrote:
> Just make sure that nr_tables is size_t not int.
> Once there, do the assert in the right place and be sure that we don't
> have a division by zero.
>=20
> Suggested-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
