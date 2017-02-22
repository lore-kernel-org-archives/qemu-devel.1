Received: from eggs.gnu.org ([2001:4830:134:3::10]:42977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgULu-00053t-JJ
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:40:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cgULr-0002zL-HO
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:40:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cgULr-0002z7-B3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:40:51 -0500
Message-ID: <1487760048.5782.10.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 22 Feb 2017 11:40:48 +0100
In-Reply-To: <CAJ+F1CLAsqBe7B81wOzVrLWJVsWpQQ4kfH1ZPgMxpwZmaE7qJA@mail.gmail.com>
References: <1487663858-11731-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CLK3aPi+aDgHGUjCCF2Xbi1V=g5UjM_BAko_PSfau33KA@mail.gmail.com>
	<1487668309.2694.37.camel@redhat.com>
	<CAJ+F1C+0jQ=e3dC--qWGDzhjAHtxDeYd_FRo3QGfWKO-thQ3yA@mail.gmail.com>
	<1487671486.2694.65.camel@redhat.com>
	<CAJ+F1CLAsqBe7B81wOzVrLWJVsWpQQ4kfH1ZPgMxpwZmaE7qJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] spice: add display & head options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

  Hi,

>         The second way is a single display channel with a single, big
>         surface
>         for all heads.  Then -- with spice-agent help -- guest and
>         client
>         negotiate which region of the big display gets scanned out to
>         which
>         head.


> My understanding is that "head" will not work correctly with QXL (only
> head 0, but can be a multi-head QXL),

For the second way yes, because in that case "head" is a qxl/spice
private thing and not visible outside.  You'll see that for example in
case you try to screendump or connect with vnc.  No heads, only the big
surface.

cheers,
  Gerd
