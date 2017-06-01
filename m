Received: from eggs.gnu.org ([2001:4830:134:3::10]:46758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Paul.Burton@imgtec.com>) id 1dGYEx-00061q-Rv
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:06:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Paul.Burton@imgtec.com>) id 1dGYEu-0000vq-Ln
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:06:47 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:35730
	helo=imgpgp01.kl.imgtec.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Paul.Burton@imgtec.com>)
	id 1dGYEu-0000qY-Ce
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 18:06:44 -0400
From: Paul Burton <paul.burton@imgtec.com>
Date: Thu, 1 Jun 2017 15:06:29 -0700
Message-ID: <2178962.Og9WLNWV2W@np-p-burton>
In-Reply-To: <20170601192206.3z6yki3sji5efrjc@aurel32.net>
References: <87d1ar504h.fsf@dusky.pond.sub.org>
	<c666d24d-c8fc-ea77-af25-7f528aee0a81@redhat.com>
	<20170601192206.3z6yki3sji5efrjc@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5960747.sqOHluFFxF";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Richard
	Henderson <rth@twiddle.net>

--nextPart5960747.sqOHluFFxF
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Aurelien/Paolo/Marcel,

On Thursday, 1 June 2017 12:22:06 PDT Aurelien Jarno wrote:
> On 2017-06-01 16:23, Paolo Bonzini wrote:
> > On 01/06/2017 10:27, Marcel Apfelbaum wrote:
> > > On 31/05/2017 11:28, Paolo Bonzini wrote:
> > >> No, for now I'd rather just go and remove msi_nonbroken.  When someone
> > >> reports a bug, we can add back "msi_broken".
> > > 
> > > Hi,
> > > I agree with the direction, but I am concerned msi_nonbroken is there
> > > for a reason.
> > > We might break some (obscure/not in use) machine.
> > > Maybe we should CC all arch machine maintainers/contributors to give
> > > them a chance to object...
> > 
> > Yeah, Alpha, MIPS and SH are those that support PCI.  Adding Richard and
> > Aurelien, do your platforms support MSI on real hardware but not in QEMU?
> 
> SH clearly doesn't support MSI.
> 
> The oldest MIPS board also do not support MSI, but I guess the Boston
> board might support it. I am adding Paul Burton in Cc: who probably
> knows about that.
> 
> Aurelien

Indeed, real Boston hardware does support MSI (or rather, the Xilinx AXI 
Bridge for PCI Express IP used on Boston does) & we make use of it in Linux.

Thanks,
    Paul
--nextPart5960747.sqOHluFFxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEELIGR03D5+Fg+69wPgiDZ+mk8HGUFAlkwj+UACgkQgiDZ+mk8
HGXm0w//QWIO/H4Zc970W5TO36Frp1OFkWRKBRempKss2dUBd0ecELfomvqP94PX
NYYRlDbkOBuLcNIrv9e9hgb1XISJiqJySOfzAUOrREuWDP2PFIWCFKQ9Cst6lIr7
ZTE4PmkWAbLsjmHi3p81pT/khFjcz6XG6tD+7E7VHbJ8tVJ0qEZxf1SdQKZGTfdM
yQZ4Tt194C2VTZgeTxXgBfjwyBmY1Nzo1mOrWyRvWc94NzwbOR0z0gC3pNhSuS1E
YvJPWFVpsNivffOfli73D5myPQOu+ufj1+cWIoQR1AP6CBjEBC+7RVa+kD/yep07
6iR78XuxHi3soSSmvW7YOkxkDBtzgw54kvAJp3YfuoHhmt810VWfHAXJ3TevIiS5
71SXhrtXrolochoADY+pJ3qwFGXAmLNEK2JNmopHlaBJUOz7nMAryZlWVsUhc4tY
zXfmSeJXuMo1H3bb8WAuhi8FgqOlxDxTDgvh11iUuC8Ov2VZX3Az8z2S/zudz5Ta
XDpwstXVaxjW4eCQpqsOUB9Hyqrm3R5+OpPJUOdz5Jh/dmEwgYlOVifRUXSuf5Zw
Ca8ji7FtErwaBrJkwvFxeKMpK0AM7RL0KRpMMAfTDDHZ3HHK0OkKfdDe7ntJ8nYw
+TRamQlXXv7KWpapbAMJrECmv18OBlmq5qTAGzBHxDiP1uKT32c=
=x/LO
-----END PGP SIGNATURE-----

--nextPart5960747.sqOHluFFxF--
