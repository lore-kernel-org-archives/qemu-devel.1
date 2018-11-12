Received: from eggs.gnu.org ([2001:4830:134:3::10]:43517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMC3X-0003nw-GE
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMC3S-0008Ih-Pm
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:15:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33902)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMC3Q-0008GP-SL
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 08:15:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B543394D21
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 13:14:59 +0000 (UTC)
Date: Mon, 12 Nov 2018 14:14:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181112131456.ksqmz62l7mu7wwkz@sirius.home.kraxel.org>
References: <20181110111623.31356-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181110111623.31356-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] edid: silence a stringop-overflow warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

On Sat, Nov 10, 2018 at 03:16:23PM +0400, Marc-Andr=E9 Lureau wrote:
> Simplify the code that doesn't need strncpy() since length of string
> is already computed.
>=20
> /home/elmarco/src/qemu/hw/display/edid-generate.c: In function 'edid_de=
sc_text':
> /home/elmarco/src/qemu/hw/display/edid-generate.c:168:5: error: 'strncp=
y' specified bound depends on the length of the source argument [-Werror=3D=
stringop-overflow=3D]
>      strncpy((char *)(desc + 5), text, len);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/elmarco/src/qemu/hw/display/edid-generate.c:164:11: note: length =
computed here
>      len =3D strlen(text);
>            ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

queued for 3.1

thanks,
  Gerd
