Received: from eggs.gnu.org ([209.51.188.92]:43140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h29zK-0004ob-Nl
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h29zJ-0002Ib-TA
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:32:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h29zI-0002Hg-Rb
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:32:12 -0500
Date: Fri, 8 Mar 2019 08:32:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190308073206.qd3efvlxgeos45np@sirius.home.kraxel.org>
References: <cover.1551902740.git.balaton@eik.bme.hu>
	<12a45041a9a5ae863bf04edf3875aa9d25c481a3.1551902740.git.balaton@eik.bme.hu>
	<c245140a-8cf7-63c6-f7e0-078ae1f1c0fd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c245140a-8cf7-63c6-f7e0-078ae1f1c0fd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5-resend 2/2] mips_fulong2e: Add on-board
 graphics chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Thu, Mar 07, 2019 at 01:32:41AM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 3/6/19 9:05 PM, BALATON Zoltan wrote:
> > Add (partial) emulation of the on-board GPU of the machine. This
> > allows the PMON2000 firmware to run and should also work with Linux
> > console but probably not with X yet.
> >=20
> > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> Mojibaked again :(

Mail was sent without Content-Type: header.  Both mutt and "git am" on
my machine assume utf-8 and everything looks fine.  I guess your mail
client assumes something else ...

"git send-email" should send the patches with correct headers, it even
asks for the charset it should use in case it finds non-ascii
characters.  So BALATON, could you check your mail client config, or
switch over to "git send-email" for submitting patches?

cheers,
  Gerd
