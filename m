Received: from eggs.gnu.org ([2001:4830:134:3::10]:39434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsli@synology.com>) id 1dQthG-0006Fh-Cj
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsli@synology.com>) id 1dQthB-0000Mx-Gv
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:02:46 -0400
Received: from synology.com ([59.124.61.242]:34408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsli@synology.com>) id 1dQthA-0000Dj-Nr
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:02:41 -0400
Date: Fri, 30 Jun 2017 19:02:18 +0800
From: jsli <jsli@synology.com>
Message-ID: <ad81f904-0aa1-4504-bc62-d5e48b759f41@Mail>
In-Reply-To: <CAJ+F1CJ0qP_0XiuUG8cA8PRsARzrWpxJWasPeKZv7M6J7MyNew@mail.gmail.com>
References: <1498187397-127781-1-git-send-email-jsli@synology.com>
	<CAJ+F1CJ0qP_0XiuUG8cA8PRsARzrWpxJWasPeKZv7M6J7MyNew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH] vhost: Fix use-after-free in
 vhost_log_put()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org



On 2017-06-29 05:12, Marc-Andr=C3=A9 Lureau<marcandre.lureau=40gmail.com>=
wrote:
> Hi
>  =20
> On =46ri, Jun 23, 2017 at 6:28 AM Jia-Shiun Li<jsli=40synology.com(mail=
to:jsli=40synology.com)>wrote:
> > In commit 9e0bc24f dev->log=5Fsize was reset to zero too early before=

> > syncing vhost log. It causes syncing to be skipped.
>  =20
> ooch, I guess I didn't realize it was also accessing dev->log=5Fsize wh=
en taking dev->log in local variable.
> I wonder why the code is written this way, it looks like the function m=
ay be reentered. =46or consistency, and perhaps for the reentering case, =
I would use a local log=5Fsize variable too.
> Btw, how did you find this regression=3F
>  =20
>  =20
>  =20

Ok, it makes sense to prevent reentering. Willregenerate patch.
We are trying to do vhost-scsi migration, and found it to cause dataincon=
sistency migrating an i/o stressed guest.

-Jia-Shiun
