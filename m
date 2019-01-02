Received: from eggs.gnu.org ([208.118.235.92]:35301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gegQ8-0000rZ-Cy
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gegQ3-0007cc-Ci
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:18:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gegQ3-0007bz-6i
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 08:18:47 -0500
Date: Wed, 2 Jan 2019 13:18:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102131841.GO24009@stefanha-x1.localdomain>
References: <1545422632-24444-1-git-send-email-liam.merwick@oracle.com>
	<1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline
In-Reply-To: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
Subject: Re: [Qemu-devel] [RFC v2 4/4] pvh: Boot uncompressed kernel using
 direct boot ABI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, xen-devel@lists.xenproject.org, sgarzare@redhat.com, mst@redhat.com, maran.wilson@oracle.com, george.kennedy@oracle.com, boris.ostrovsky@oracle.com


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 21, 2018 at 08:03:52PM +0000, Liam Merwick wrote:
> @@ -1336,7 +1470,7 @@ void pc_memory_init(PCMachineState *pcms,
>      int linux_boot, i;
>      MemoryRegion *ram, *option_rom_mr;
>      MemoryRegion *ram_below_4g, *ram_above_4g;
> -    FWCfgState *fw_cfg;
> +    FWCfgState *fw_cfg = NULL;

What is the purpose of this change?

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLLoxAAoJEJykq7OBq3PI7ZcH/2EvpccwgtnKmMLzxe6vNcJz
Hxc6hpJuTHeya07m711EZ80pJNcbCWPp3SwVDgH2eYI+ZkiqP9Ld80C7824jAn9h
UgTrsaf+8k7rHBHSv59PgbUMlRALORpUKDQaQZceg/6jmu3YONpjNTyAyxALV+OT
E9rVse1kbVBSIFB+Y/jq5kYZapadlpIOgpYa978ZNZFbuVFjNm6lNWmz4EAqyFot
fwwln5fdHNzB7U5RNOebGfidNYHuAr07/D2hG/8R6v4/3z3PL/0EXLkh6LpHBlCy
AjDkuEo9fZi7OELW+ypYEteZiUImvIaen8OOT4uqpT3F+BJ6WV+QPXo5QESvjdU=
=JSAl
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--
