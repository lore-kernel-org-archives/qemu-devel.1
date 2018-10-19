Received: from eggs.gnu.org ([2001:4830:134:3::10]:40268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gDOem-0008RZ-4v
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gDOei-0004Fj-0X
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:53:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gDOeh-0004Cz-NS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:53:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 06548821C3
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:53:07 +0000 (UTC)
Date: Fri, 19 Oct 2018 08:53:05 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181019065305.cgwauwj4u5x24dd5@sirius.home.kraxel.org>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-31-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181017082702.5581-31-armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 30/38] spice: Clean up error reporting
 in add_channel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Oct 17, 2018 at 10:26:54AM +0200, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  add_channel() does that, and then exit()s.  Its caller
> main(), via qemu_opts_foreach(), is fine with it, but clean it up
> anyway.
>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
