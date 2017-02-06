Received: from eggs.gnu.org ([2001:4830:134:3::10]:42911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cakDf-0001c9-FN
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:24:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cakDc-0005Gn-B8
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:24:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33801)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cakDc-0005GX-5P
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 09:24:36 -0500
Message-ID: <1486391074.32329.23.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 06 Feb 2017 15:24:34 +0100
In-Reply-To: <CAJ+F1CJUciyf2KON6nqSHiW6Zba2wr5O7S2V+_ygCGoh+6ST0g@mail.gmail.com>
References: <1485940779-24225-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CJUciyf2KON6nqSHiW6Zba2wr5O7S2V+_ygCGoh+6ST0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] Add wctablet device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Anatoli Huseu1 <avg.tolik@gmail.com>

  Hi,

>         +    cc->chr_free =3D wctablet_chr_free;
>=20
>=20
> chr_free is going away in the last pull request, you can replace it
> with qom finalize.

Yep, saw the patches already, rebased now, v4 is on the way.

cheers,
  Gerd
