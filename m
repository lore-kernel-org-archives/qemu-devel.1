Received: from eggs.gnu.org ([2001:4830:134:3::10]:56642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eme6k-0002cH-A6
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eme6f-0003mG-AR
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:23:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eme6f-0003lX-4x
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 06:23:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFC43EAEA6
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 11:23:07 +0000 (UTC)
Date: Fri, 16 Feb 2018 12:23:07 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180216112307.jodyynu233g3pohz@sirius.home.kraxel.org>
References: <20180215102602.10864-1-berrange@redhat.com>
	<jpglgfucdrl.fsf@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <jpglgfucdrl.fsf@linux.bootlegged.copy>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vnc: remove bogus object_unref on client
 socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Thu, Feb 15, 2018 at 01:24:14PM -0500, Bandan Das wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
>=20
> > vnc_listen_io() does not own the reference on the 'cioc' parameter is=
 it
> > passed, so should not be unref'ing it.
> >
> > Reported-by: Bandan Das <bsd@redhat.com>
> > Signed-off-by: Daniel P. Berrang=E9 <berrange@redhat.com>
>=20
> Daniel, wouldn't a Fixes: 13e1d0e71e78a925848258391a6e616b6b5ae219
> be helpful here ?

Added & queued.

thanks,
  Gerd
