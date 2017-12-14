Received: from eggs.gnu.org ([2001:4830:134:3::10]:57894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePTW0-00085t-Am
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:25:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePTVx-0000WK-5I
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:25:32 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePTVw-0000Vn-TD
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:25:29 -0500
Received: by mail-qt0-x241.google.com with SMTP id u10so7908894qtg.2
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 05:25:28 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171213232025.24503-1-f4bug@amsat.org>
	<20171213232025.24503-2-f4bug@amsat.org>
	<20171214090658.GA3731@dhcp-200-186.str.redhat.com>
	<10883807-b248-c768-9879-fb51fb0fa441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <481352a0-baa6-1fdb-592e-73ecc8e2d3c4@amsat.org>
Date: Thu, 14 Dec 2017 10:25:19 -0300
MIME-Version: 1.0
In-Reply-To: <10883807-b248-c768-9879-fb51fb0fa441@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="sBrbNbw26hWvmNteUnuvsSSjQl79POjF3"
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sBrbNbw26hWvmNteUnuvsSSjQl79POjF3
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>,
 "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Andrey Yurovsky <yurovsky@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <famz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <481352a0-baa6-1fdb-592e-73ecc8e2d3c4@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 01/26] sdbus: add a QMP command to access a
 SDBus
References: <20171213232025.24503-1-f4bug@amsat.org>
 <20171213232025.24503-2-f4bug@amsat.org>
 <20171214090658.GA3731@dhcp-200-186.str.redhat.com>
 <10883807-b248-c768-9879-fb51fb0fa441@redhat.com>
In-Reply-To: <10883807-b248-c768-9879-fb51fb0fa441@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 12/14/2017 06:34 AM, Paolo Bonzini wrote:
> On 14/12/2017 10:06, Kevin Wolf wrote:
[...]
>> Doing this kind of thing over QMP doesn't look right to me. qtests
>> should access hardware the same way as real guests access the hardware=

>> (i.e. MMIO and I/O ports).
[...]
>=20
> Yeah, what we usually do is not test the device (e.g. SCSI) directly,
> but only through the HBA (e.g. virtio-scsi or AHCI, it would be SDHCI i=
n
> this case).

Yes, a SDHCI qtest is added in a later series (in C) using MMIO access:
http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg02391.html

But to be sure the SDHCI is correct I needed a SD slave to behave
correctly ;) Hence this "bus test".

Regards,

Phil.


--sBrbNbw26hWvmNteUnuvsSSjQl79POjF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAloye78ACgkQ4+MsLN6t
wN6LzBAAwxDw816E1npxbq37z+xl8H/9uvqsKOpZMJEzHni8GkBdmCKDk34Ev7N1
d81tPbPpEEVvS/kS6mNdZX21Jrx+Gj0oFRo+Ot0rpYnl3DFpJvnxBm8Nh+htEShT
lAeviVBdvMPfxvBUyq1bwMJG5akFtEXMwAeRcxXM0ZSUBgcFGI028OeGVvkQsTix
ylF5iu2wlR+as1V1VZ7FTRt8wRzBTH7neI147tQ9ykVaObWM8PljTaSaYieWFY+h
mZGMnCn16Jn4Iz3dlIA2vr9r4vUWxMLAOloR7OFGSWoeOQvafsMaKIMNIr9N4ic2
dQLy8YSrFJcgLCriHv5BbAKG5tUiSSNUlIPzPX4neD6h28YpG15rUDro4ZmXXm3I
9GLz1vGQynbaQS2xvIj91hIm0lQl2NVnSL1iuQQwC5mbrKDU6KDSlKzgUOMG2zwP
GnzPgolgFquIVmGZKg9FN5ll3MZn8EHScg8frRul4Z0BxH/Piifg9pJ4/oTzx0vt
+PPkx2ksyIf3UlUkxfX/W60O8PT07utXLluflg/BbSh9Hn7O8mvFokhy9Y0OjC90
185WpaoKR2CoFfnltLcaJQh/6jPJyVmu6R5/Txqup5KqHdtv4Z2bpUW0akdk3mEp
+G97CK/PeJTH1qcYh1SifMN/mgHQDJaKeRUIRUVvPJpBX1ggM2g=
=MOWr
-----END PGP SIGNATURE-----

--sBrbNbw26hWvmNteUnuvsSSjQl79POjF3--
