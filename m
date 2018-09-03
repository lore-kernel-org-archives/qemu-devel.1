Received: from eggs.gnu.org ([2001:4830:134:3::10]:52793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lightn1ngstr1ke@protonmail.com>) id 1fwpC1-0008S6-ER
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lightn1ngstr1ke@protonmail.com>) id 1fwpBy-0001iT-9i
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:47:01 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:37141)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lightn1ngstr1ke@protonmail.com>)
	id 1fwpBx-0001hw-UF
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:46:58 -0400
Date: Mon, 03 Sep 2018 13:46:43 +0000
From: Ryan El Kochta <lightn1ngstr1ke@protonmail.com>
Reply-To: Ryan El Kochta <lightn1ngstr1ke@protonmail.com>
Message-ID: <UrupYUeF5XDYjfimXZ2yoMQlZwjETaG71WpZZaxE255beqghwf2z9p0T4z1a9TEAG9VOrfgt8H9FPein3rbbF1rat-O5Hl6jxTYtM7H7kyY=@protonmail.com>
In-Reply-To: <20180903062916.cdlraihduddkbzfa@sirius.home.kraxel.org>
References: <petKSachdmuxWMgY2EXHzES3PpUCAUwQacKEaIU9PHykNXfsah1sP3OaVuDLz0VBYJM7qtJsWSrv3U9bkb_2LT_itBxDbAYKIHlEJJXtEiE=@protonmail.com>
	<20180827101609.p2blhd7ka7gkqqtq@sirius.home.kraxel.org>
	<CSjEdwPfIMyBPsRNM1KZG7ugmTMLh2leLbHEBEQ2o0UjHftEBoh98TcX-xoHTgjDAW7Vn1psMATSN_4IS68-sdTWKkd32SL-HGN5A5-pqz0=@protonmail.com>
	<20180830105102.mk3p4rnpge7f2n4h@sirius.home.kraxel.org>
	<VfOZq_8WA8_tWfpd_mx7RajgNVmE8Qm0NSeInrS-66gCH0OTsrgsXV3kVPOQkk0TpC_7xBuegwMuM27aS7yK78nonRd1GjNgv4tZQian1Qs=@protonmail.com>
	<20180831060715.mmiwtsdienomd37b@sirius.home.kraxel.org>
	<QF6Ux6apq57-eXyEA1HN0yQZZAkPm5hEla8kqVF_y_tJ2iLXXoOBCOre_sSMOT95Lq1Oi5tCVb07KGWArv3AaOJGV8cTs4QUgQ_at6zZ78o=@protonmail.com>
	<20180903062916.cdlraihduddkbzfa@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] input-linux: toggle for lock keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On September 3, 2018 2:29 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Fri, Aug 31, 2018 at 01:31:06PM +0000, Ryan El Kochta wrote:
>
> > On Aug 31, 2018, 2:07 AM, Gerd Hoffmann wrote:
> > Hi,
> >
> > > That's a wonderful idea. Would you be comfortable with
> > > grab_toggle=3Dcustom:x:x as well?
> >
> > What this is supposed to do?
> > cheers,
> > Gerd
> > It would be the same as the original patch (you can input custom key ID=
s if you so desire) in addition to a few hardcoded sane defaults.
>
> What would be the use case? Most keys have the problem that they have
> some effect on the host, so using them to switch between host + guest
> will have annonying side effects ...
>
> cheers,
> Gerd

You do have a point. I can really only think of about 4 or 5 key combinatio=
ns that do not cause problems. I'll submit a patch later today.

Thanks,

Ryan El Kochta
