Received: from eggs.gnu.org ([2001:4830:134:3::10]:38292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5sY8-0005e6-T1
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f5sY5-0003jY-ME
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:39:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55752 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f5sY5-0003jH-Hp
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:38:57 -0400
Date: Tue, 10 Apr 2018 14:38:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180410123855.wefgye4j6sznxp5y@sirius.home.kraxel.org>
References: <20180410120222.31845-1-tournier.elie@gmail.com>
	<20180410120222.31845-2-tournier.elie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410120222.31845-2-tournier.elie@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qapi: Parameter gl of DisplayType
 now accept an enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Elie Tournier <tournier.elie@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Elie Tournier <elie.tournier@collabora.com>

> -    if (dpy.has_gl && dpy.gl && display_opengl == 0) {
> +    if (dpy.has_gl && !dpy.gl == DISPLAYGL_MODE_OFF && display_opengl == 0) {

That should be "... && !(dpy.gl == DISPLAYGL_MODE_OFF) && ..." to work
correctly.  Or just "dpy.gl != DISPLAYGL_MODE_OFF" ...

cheers,
  Gerd
