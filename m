Received: from eggs.gnu.org ([2001:4830:134:3::10]:56251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb6Ov-00082X-Vy
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eb6Or-0006Ke-HV
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:10:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eb6Or-0006K5-CQ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 10:10:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E466A3280
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 15:10:12 +0000 (UTC)
Date: Mon, 15 Jan 2018 16:10:09 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180115151009.3cqfppwtsr4zx4mo@sirius.home.kraxel.org>
References: <20171212140459.2234-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212140459.2234-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 0/4] Convert frontends to use
 keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, Dec 12, 2017 at 02:04:55PM +0000, Daniel P. Berrange wrote:
> This is a followup to
> 
>   v1: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02047.html
>   v2: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02471.html
>   v3: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02517.html
>   v4: https://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg02708.html
>   v5: https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg02950.html
> 
> This new series contains just the patches for converting the ui frontends
> for SDL1, SDL2, and GTK to use keycodemapdb.
> 
> The particularly notable benefit is that this includes fixes such that SDL1
> and GTK2/3 can actually work when using a non-Linux host Xorg/X11 server.
> Previously it would display but key handling was complete garbage, making it
> unusable in practice.
> 
> Daniel P. Berrange (4):
>   ui: convert the SDL2 frontend to keycodemapdb
>   ui: convert GTK and SDL1 frontends to keycodemapdb
>   ui: add fix for GTK Pause key handling on Win32
>   ui: ignore hardware keycode 255 on win32

Doesn't apply cleanly any more, could you rebase please?

thanks,
  Gerd
