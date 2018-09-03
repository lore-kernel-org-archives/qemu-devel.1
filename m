Received: from eggs.gnu.org ([2001:4830:134:3::10]:50540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwiMe-00044D-Nd
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:29:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fwiMS-0004Q0-AH
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:29:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fwiMR-0004L2-Kn
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 02:29:19 -0400
Date: Mon, 3 Sep 2018 08:29:16 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180903062916.cdlraihduddkbzfa@sirius.home.kraxel.org>
References: <petKSachdmuxWMgY2EXHzES3PpUCAUwQacKEaIU9PHykNXfsah1sP3OaVuDLz0VBYJM7qtJsWSrv3U9bkb_2LT_itBxDbAYKIHlEJJXtEiE=@protonmail.com>
	<20180827101609.p2blhd7ka7gkqqtq@sirius.home.kraxel.org>
	<CSjEdwPfIMyBPsRNM1KZG7ugmTMLh2leLbHEBEQ2o0UjHftEBoh98TcX-xoHTgjDAW7Vn1psMATSN_4IS68-sdTWKkd32SL-HGN5A5-pqz0=@protonmail.com>
	<20180830105102.mk3p4rnpge7f2n4h@sirius.home.kraxel.org>
	<VfOZq_8WA8_tWfpd_mx7RajgNVmE8Qm0NSeInrS-66gCH0OTsrgsXV3kVPOQkk0TpC_7xBuegwMuM27aS7yK78nonRd1GjNgv4tZQian1Qs=@protonmail.com>
	<20180831060715.mmiwtsdienomd37b@sirius.home.kraxel.org>
	<QF6Ux6apq57-eXyEA1HN0yQZZAkPm5hEla8kqVF_y_tJ2iLXXoOBCOre_sSMOT95Lq1Oi5tCVb07KGWArv3AaOJGV8cTs4QUgQ_at6zZ78o=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <QF6Ux6apq57-eXyEA1HN0yQZZAkPm5hEla8kqVF_y_tJ2iLXXoOBCOre_sSMOT95Lq1Oi5tCVb07KGWArv3AaOJGV8cTs4QUgQ_at6zZ78o=@protonmail.com>
Subject: Re: [Qemu-devel] [PATCH] input-linux: toggle for lock keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryan El Kochta <lightn1ngstr1ke@protonmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, Aug 31, 2018 at 01:31:06PM +0000, Ryan El Kochta wrote:
> On Aug 31, 2018, 2:07 AM, Gerd Hoffmann wrote:
> 
> Hi,
> 
> > That's a wonderful idea. Would you be comfortable with
> > grab_toggle=custom:x:x as well?
> 
> What this is supposed to do?
> 
> cheers,
> Gerd
> 
> It would be the same as the original patch (you can input custom key IDs if you so desire) in addition to a few hardcoded sane defaults.

What would be the use case?  Most keys have the problem that they have
some effect on the host, so using them to switch between host + guest
will have annonying side effects ...

cheers,
  Gerd
