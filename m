Received: from eggs.gnu.org ([2001:4830:134:3::10]:39836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gDOeL-0007rD-0z
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gDOeG-0003Rq-Pv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:52:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53864)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gDOeG-0003GG-CT
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 02:52:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77D32307D843
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:52:30 +0000 (UTC)
Date: Fri, 19 Oct 2018 08:52:29 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181019065229.3htdad7hanqud5ua@sirius.home.kraxel.org>
References: <20181017082702.5581-1-armbru@redhat.com>
	<20181017082702.5581-28-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181017082702.5581-28-armbru@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 27/38] vnc: Clean up error reporting in
 vnc_init_func()
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

On Wed, Oct 17, 2018 at 10:26:51AM +0200, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  vnc_init_func() does that, and then fails without
> setting an error.  Its caller main(), via qemu_opts_foreach(), is fine
> with it, but clean it up anyway.
>=20
> While there, drop a "Failed to start VNC server: " error message
> prefix that doesn't really add value.
>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
